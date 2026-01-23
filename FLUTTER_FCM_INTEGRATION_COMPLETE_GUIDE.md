# Flutter FCM Integration - Complete Guide for Company Admin App

## Overview
The server sends FCM notifications with **data-only messages** (no automatic notification UI). Your Flutter app MUST handle display, sound, and badge updates manually.

---

## 1️⃣ Firebase Console Configuration

### ✅ Checklist
- [ ] **Android**: `google-services.json` added to `android/app/`
- [ ] **iOS**: `GoogleService-Info.plist` added to `ios/Runner/`
- [ ] **iOS**: APNs Authentication Key uploaded in Firebase Console
  - Go to Firebase Console → Project Settings → Cloud Messaging
  - Upload APNs Auth Key (.p8 file) or APNs Certificate
- [ ] **Android**: Firebase Cloud Messaging API (V1) enabled
  - Firebase Console → Project Settings → Cloud Messaging → Enable

---

## 2️⃣ Flutter Dependencies

```yaml
# pubspec.yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_messaging: ^14.7.9
  flutter_local_notifications: ^16.3.0  # For foreground notifications
  badges: ^3.1.2  # For badge count on app icon
```

---

## 3️⃣ Android Configuration

### `android/app/src/main/AndroidManifest.xml`
```xml
<manifest ...>
    <!-- Add permissions OUTSIDE <application> -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/> <!-- Android 13+ -->
    <uses-permission android:name="android.permission.VIBRATE"/>
    <uses-permission android:name="android.permission.WAKE_LOCK"/>
    
    <application ...>
        <!-- ... your existing code ... -->
        
        <!-- FCM Default Icon -->
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_icon"
            android:resource="@drawable/ic_notification" />
        
        <!-- FCM Default Color -->
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_color"
            android:resource="@color/notification_color" />
            
        <!-- FCM Default Channel (Android 8+) -->
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_channel_id"
            android:value="hawiya_notifications" />
    </application>
</manifest>
```

### Create notification icon
- Add `ic_notification.png` to `android/app/src/main/res/drawable/`
- Add color in `android/app/src/main/res/values/colors.xml`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="notification_color">#FF6B35</color>
</resources>
```

---

## 5️⃣ Flutter Code Implementation

### A. Initialize FCM Service

```dart
// lib/services/fcm_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import '../api/auth_api.dart'; // Your API service

// ⚠️ CRITICAL: Background handler MUST be top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('📩 Background message: ${message.messageId}');
  
  // Update badge count in background
  final badgeCount = await _getUnreadCount();
  FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();
}

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();
  
  int _badgeCount = 0;
  
  Future<void> initialize() async {
    // 1. Request permissions (iOS/Android 13+)
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      print('❌ Notification permissions denied');
      return;
    }
    
    print('✅ Notification permissions granted');

    // 2. Initialize local notifications (for foreground display)
    await _initializeLocalNotifications();

    // 3. Get FCM token and send to server
    String? token = await _fcm.getToken();
    if (token != null) {
      print('📱 FCM Token: $token');
      await _sendTokenToServer(token);
    }

    // 4. Listen for token refresh
    _fcm.onTokenRefresh.listen(_sendTokenToServer);

    // 5. Register background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 6. Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // 7. Handle notification taps (when app opened from notification)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    
    // 8. Check for initial notification (app opened from terminated state)
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  Future<void> _initializeLocalNotifications() async {
    // Android settings
    const AndroidInitializationSettings androidSettings = 
        AndroidInitializationSettings('@drawable/ic_notification');

    // iOS settings
    final DarwinInitializationSettings iosSettings = 
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        if (response.payload != null) {
          _navigateToNotification(response.payload!);
        }
      },
    );

    // Create Android notification channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'hawiya_notifications', // Must match AndroidManifest.xml
      'Hawiya Notifications',
      description: 'Notifications for company admins',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _sendTokenToServer(String token) async {
    try {
      await AuthAPI.updateAdminFcmToken(token);
      print('✅ FCM token sent to server');
    } catch (e) {
      print('❌ Failed to send FCM token: $e');
    }
  }

  // ⚠️ CRITICAL: Server sends DATA-ONLY messages
  // You MUST show notification manually in foreground
  void _handleForegroundMessage(RemoteMessage message) {
    print('📩 Foreground message received');
    print('Data: ${message.data}');
    
    final String title = message.data['title'] ?? 'New Notification';
    final String body = message.data['message'] ?? '';
    final String type = message.data['type'] ?? '';
    
    // Show local notification with sound and vibration
    _showLocalNotification(title, body, message.data);
    
    // Increment badge
    _incrementBadge();
    
    // Refresh notification list if on notification screen
    _notifyListeners(type);
  }

  Future<void> _showLocalNotification(
    String title, 
    String body, 
    Map<String, dynamic> data
  ) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'hawiya_notifications',
      'Hawiya Notifications',
      channelDescription: 'Notifications for company admins',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@drawable/ic_notification',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: data['notificationId'] ?? data['type'],
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    print('🔔 Notification tapped: ${message.data}');
    final String type = message.data['type'] ?? '';
    _navigateToNotification(type);
  }

  void _navigateToNotification(String type) {
    // Navigate based on notification type
    // Example: navigatorKey.currentState?.pushNamed('/notifications');
  }

  void _incrementBadge() {
    _badgeCount++;
    _updateBadge(_badgeCount);
  }

  void _updateBadge(int count) {
    // Update app icon badge
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      _localNotifications.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(badge: true);
    }
  }

  Future<void> resetBadge() async {
    _badgeCount = 0;
    _updateBadge(0);
  }

  void _notifyListeners(String type) {
    // Notify your state management to refresh notification list
    // Example: notificationProvider.refresh();
  }
}

// Helper to get unread count from your local database/cache
Future<int> _getUnreadCount() async {
  // Implement your logic to get unread notification count
  return 0;
}
```

### B. Initialize in `main.dart`

```dart
// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Generated by FlutterFire CLI
import 'services/fcm_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize FCM
  await FCMService().initialize();
  
  runApp(MyApp());
}
```

### C. Update FCM Token After Login

```dart
// After successful login
final fcmToken = await FirebaseMessaging.instance.getToken();
if (fcmToken != null) {
  await authAPI.updateAdminFcmToken(fcmToken);
}
```

### D. API Service Method

```dart
// lib/api/auth_api.dart
class AuthAPI {
  static Future<void> updateAdminFcmToken(String fcmToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/company/auth/admin/update-fcm-token'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'your-session-cookie', // Include auth cookie
      },
      body: json.encode({'fcmToken': fcmToken}),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to update FCM token');
    }
  }
}
```

---

## 6️⃣ Server Payload Structure

### What Your App Receives
```json
{
  "type": "new_order",              // or "admin_warning", "platform_announcement"
  "title": "New Order #12345",
  "message": "You have a new order",
  "notificationId": "uuid-here",
  "globalOrderId": "order-uuid",
  "data": "{\"orderId\":\"123\"}"   // Stringified JSON
}
```

### Handle Different Notification Types
```dart
void _handleForegroundMessage(RemoteMessage message) {
  final String type = message.data['type'] ?? '';
  
  switch (type) {
    case 'new_order':
    case 'new_sub_order':
    case 'order_cancelled':
    case 'payment_received':
      // Navigate to orders screen
      break;
      
    case 'admin_warning':
    case 'platform_announcement':
      // Navigate to notifications screen
      break;
      
    default:
      // Generic notification
      break;
  }
}
```

---

## 7️⃣ Testing Checklist

### ✅ Server-Side Test
```bash
# SSH into production server
ssh root@your-server

# Test FCM token exists
node -e "
const { createCompanySequelize } = require('./config/db.config');
const seq = createCompanySequelize('company_xxxxx_db');
const User = require('./models/company/user.model.js')(seq);
User.findAll({ where: { role: 'admin' }, attributes: ['id', 'name', 'fcmToken'] })
  .then(users => { console.log(users.map(u => ({ id: u.id, name: u.name, hasToken: !!u.fcmToken }))); process.exit(0); });
"
```

### ✅ Client-Side Test
1. **Check Token Registration**
   - Login to app
   - Check debug console for: `📱 FCM Token: ...`
   - Verify server logs show: `✅ FCM token sent to server`

2. **Test Foreground Notification**
   - Keep app OPEN and in foreground
   - Send test notification from super admin
   - Should see: notification popup + sound + badge increment

3. **Test Background Notification**
   - Minimize app (don't close)
   - Send test notification
   - Should see: system notification in tray + sound

4. **Test Terminated State**
   - Force close app completely
   - Send test notification
   - Should see: system notification
   - Tap notification → app opens → navigates to correct screen

5. **Check Badge Count**
   - iOS: Long-press app icon → should show notification count
   - Android: Depends on launcher (some show badge dots)

---

## 8️⃣ Common Issues & Solutions

### ❌ No notifications received
**Check:**
- [ ] `google-services.json` / `GoogleService-Info.plist` present?
- [ ] Firebase Cloud Messaging API enabled in Firebase Console?
- [ ] FCM token sent to server successfully?
- [ ] Server logs show FCM sent? (Check for `✅ Sent FCM to admin...`)
- [ ] Notification permissions granted? (Check Settings → App → Notifications)

### ❌ No sound/vibration
**Fix:**
- Android: Ensure notification channel importance is `Importance.high`
- iOS: Check device is not in silent mode
- Android: Check app notification settings in device settings

### ❌ No badge count
**Fix:**
- iOS: Request badge permission in `requestPermission()`
- Android: Badge support depends on launcher (Samsung, OnePlus, Pixel support it)
- Manually track unread count and update badge using `flutter_local_notifications`

### ❌ Notifications only work in foreground
**Fix:**
- Ensure `FirebaseMessaging.onBackgroundMessage()` is registered
- Background handler MUST be top-level function (not inside class)
- iOS: Check `UIBackgroundModes` includes `remote-notification`

### ❌ iOS not receiving notifications
**Check:**
- [ ] APNs certificate uploaded to Firebase Console?
- [ ] Device is not in Low Power Mode (disables background refresh)
- [ ] `FirebaseAppDelegateProxyEnabled = false` in Info.plist
- [ ] `Messaging.messaging().apnsToken` set in AppDelegate

---

## 9️⃣ Production Deployment

### Before Going Live
1. **Test on physical device** (not simulator/emulator)
2. **Test all 3 states**: foreground, background, terminated
3. **Test iOS + Android**
4. **Verify badge count updates correctly**
5. **Test notification navigation**
6. **Verify server logs show FCM delivery success**

### Monitor in Production
```bash
# Check server logs for FCM errors
pm2 logs --lines 100 | grep FCM

# Count admins with FCM tokens
# (Run in production server)
```

---

## 📝 Summary for Developer

**Tell your Flutter developer:**

1. **Server sends DATA-ONLY messages** (no automatic UI)
   - Must manually show notification using `flutter_local_notifications`
   - Must manually play sound/vibration
   - Must manually update badge count

2. **Three handlers required:**
   - `onMessage` → Foreground (show local notification)
   - `onBackgroundMessage` → Background (top-level function)
   - `onMessageOpenedApp` → Notification tap navigation

3. **Permissions are critical:**
   - Request on app start
   - Check authorization status
   - Guide user to settings if denied

4. **Test on real device:**
   - Simulator/emulator has limited FCM support
   - Test all app states (foreground, background, terminated)

5. **Debug with logs:**
   - Print FCM token
   - Print received messages
   - Check server logs for delivery confirmation
