import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

// ==================== Background Handler (Top-level function) ====================

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('📲 Background notification: ${message.notification?.title}');
  await FCMService().showLocalNotification(message);
}

// ==================== FCM Service Class ====================

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  final _notificationTapController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get onNotificationTap => _notificationTapController.stream;

  // Callbacks for refreshing providers when notifications arrive
  Function()? onNotificationReceived;
  Function()? onIncrementBadge;

  // Update app icon badge using flutter_local_notifications
  Future<void> updateBadge(int count) async {
    try {
      // iOS badge support
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosPlugin = _localNotifications
            .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
        if (iosPlugin != null) {
          await iosPlugin.requestPermissions(badge: true);
          // Badge is set via notification badgeNumber on iOS
        }
      }
      
      // Android: Badge is automatically managed by notification system
      // The badge count reflects the number of active notifications
      debugPrint('🔢 Badge count updated to: $count');
    } catch (e) {
      debugPrint('❌ Error updating badge: $e');
    }
  }

  // Initialize FCM
  Future<void> initialize() async {
    try {
      // Request permission
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('✅ FCM Permission granted');

        // Get FCM token
        _fcmToken = await _firebaseMessaging.getToken();
        debugPrint('📱 FCM Token: $_fcmToken');

        // Initialize local notifications
        await _initializeLocalNotifications();

        // Listen to token refresh
        _firebaseMessaging.onTokenRefresh.listen((newToken) {
          _fcmToken = newToken;
          debugPrint('🔄 FCM Token refreshed: $newToken');
          // Token will be sent to backend by the app layer
        });

        // Handle foreground messages
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

        // Handle notification taps (when app is in background)
        FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

        // Check if app was opened from notification
        final initialMessage = await _firebaseMessaging.getInitialMessage();
        if (initialMessage != null) {
          _handleNotificationTap(initialMessage);
        }
      } else {
        debugPrint('❌ FCM Permission denied');
      }
    } catch (e) {
      debugPrint('❌ FCM initialization error: $e');
    }
  }

  // Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    // Create Android notification channel
    const channel = AndroidNotificationChannel(
      'hawiya_notifications',
      'Hawiya Notifications',
      description: 'Notifications for new orders and updates',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Handle foreground messages (app is open)
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('📨 Foreground notification received!');
    debugPrint('   Title: ${message.notification?.title}');
    debugPrint('   Body: ${message.notification?.body}');
    debugPrint('   Data: ${message.data}');
    showLocalNotification(message);
    
    // ⚠️ CRITICAL: Refresh providers when notification arrives
    debugPrint('🔄 Triggering provider refreshes...');
    onNotificationReceived?.call();
    onIncrementBadge?.call();
  }

  // Handle notification tap
  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('👆 Notification tapped!');
    debugPrint('   Data: ${message.data}');
    _notificationTapController.add(message.data);
  }

  // Show local notification
  Future<void> showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;
    
    // Handle data-only messages (server sends data-only)
    final title = notification?.title ?? data['title'] ?? 'إشعار جديد';
    final body = notification?.body ?? data['message'] ?? data['body'] ?? '';

    const androidDetails = AndroidNotificationDetails(
      'hawiya_notifications',
      'Hawiya Notifications',
      channelDescription: 'Notifications for new orders and updates',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      playSound: true,
      enableVibration: true,
      enableLights: true,
      visibility: NotificationVisibility.public,
      ticker: 'حاويتكم',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1, // This triggers badge update on iOS
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await _localNotifications.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title,
        body,
        details,
        payload: message.data.toString(),
      );
      debugPrint('✅ Local notification displayed: $title');
    } catch (e) {
      debugPrint('❌ Error showing local notification: $e');
    }
  }

  // Handle local notification tap
  void _onLocalNotificationTap(NotificationResponse response) {
    debugPrint('👆 Local notification tapped: ${response.payload}');
    if (response.payload != null) {
      try {
        // Parse payload and emit to stream
        _notificationTapController.add({'payload': response.payload});
      } catch (e) {
        debugPrint('❌ Error parsing notification payload: $e');
      }
    }
  }

  // Unsubscribe (on logout)
  Future<void> unsubscribe() async {
    if (_fcmToken != null) {
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
      debugPrint('🔕 FCM unsubscribed');
    }
  }

  void dispose() {
    _notificationTapController.close();
  }
}
