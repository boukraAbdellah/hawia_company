import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'core/router/app_router.dart';
import 'core/config/app_theme.dart';
import 'features/notifications/services/fcm_service.dart';
import 'features/notifications/services/websocket_service.dart';
import 'features/notifications/providers/notification_providers.dart';
import 'core/services/storage_service.dart';

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('📲 Background notification received');
  debugPrint('   Title: ${message.notification?.title ?? message.data['title']}');
  debugPrint('   Data: ${message.data}');
  
  // Show notification even in background (server sends data-only messages)
  await FCMService().showLocalNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Set background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  
  // Initialize FCM Service
  await FCMService().initialize();
  
  // Initialize WebSocket if user is logged in
  final token = await StorageService.getToken();
  if (token != null) {
    try {
      await WebsocketService.instance.connect(token);
    } catch (e) {
      debugPrint('❌ Failed to connect WebSocket on app start: $e');
    }
  }
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    
    // ⚠️ CRITICAL: Connect FCM callbacks to refresh providers when notifications arrive
    FCMService().onNotificationReceived = () {
      debugPrint('🔄 FCM callback: Refreshing notification list...');
      ref.read(adminNotificationsProvider.notifier).loadNotifications();
    };
    
    FCMService().onIncrementBadge = () {
      debugPrint('🔄 FCM callback: Refreshing unread count...');
      ref.read(unreadCountProvider.notifier).refresh();
    };
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    
    // Watch providers to ensure they initialize when authenticated
    ref.watch(adminNotificationsProvider);
    ref.watch(unreadCountProvider);

    return MaterialApp.router(
      title: 'حاويتكم',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // RTL Support
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'), // Arabic
        Locale('en', 'US'), // English
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
