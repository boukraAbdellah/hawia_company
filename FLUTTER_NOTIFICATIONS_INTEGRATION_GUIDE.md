# Flutter Notification Integration Guide - Company Mobile App
## WebSocket + REST API + FCM Push Notifications

---

## 🎯 Overview

Your backend has **TWO NOTIFICATION SYSTEMS** for companies:

### 1️⃣ **CompanyNotification** (Master Database)
- **Purpose:** Admin-level notifications for company owners/managers
- **Types:** `new_order`, `new_sub_order`, `order_cancelled`, `payment_received`, `system_message`
- **Database:** Master DB (`company_notifications` table)
- **Delivery:** WebSocket (real-time) + REST API (fetch) + FCM Push (when app is closed)
- **Routes:** `/api/company/admin/notifications/*`

### 2️⃣ **Notification** (Company Database)  
- **Purpose:** User-level notifications for drivers and internal company users
- **Types:** `new_order`, `new_sub_order`, `admin_message`, `company_banned`, `admin_warning`, `platform_announcement`, `container_type_request_approved`, `container_type_request_rejected`
- **Database:** Company DB (`notifications` table)
- **Delivery:** REST API only (drivers/company users)
- **Routes:** `/api/company/notifications/*`

---

## ✅ Current Backend API Assessment

### **YES** - Ready for Flutter Integration

Your current notification routes are **PERFECT** for Flutter mobile app integration. Here's what you have:

#### ✅ CompanyNotification API (Admin Notifications)
```
GET    /api/company/admin/notifications              ✅ Fetch all notifications with pagination
GET    /api/company/admin/notifications/unread-count ✅ Get unread badge count
PATCH  /api/company/admin/notifications/:id/read     ✅ Mark single as read
PATCH  /api/company/admin/notifications/mark-all-read✅ Mark all as read
DELETE /api/company/admin/notifications/:id          ✅ Delete notification
```

#### ✅ Regular Notification API (Driver/User Notifications)
```
GET    /api/company/notifications              ✅ Fetch with pagination
PATCH  /api/company/notifications/seen         ✅ Mark as seen (updates lastReadAt)
GET    /api/company/notifications/unread-count ✅ Get unread count
```

#### ✅ Additional Features
- **WebSocket Support:** Real-time push via WebSocket for admin notifications
- **FCM Integration:** Firebase Cloud Messaging already configured (`config/pushNotification.js`)
- **Level-Based Delay:** Notifications sent based on company level (0-9 minutes delay)
- **Database Persistence:** All notifications stored in DB
- **Order Association:** Notifications linked to `globalOrderId`

---

## 📦 What You Need to Add (Backend - OPTIONAL)

### ✅ FCM Token Registration Endpoint (NOW AVAILABLE)

**Endpoint:** `POST /api/company/auth/admin/update-fcm-token`

**Purpose:** Register or update the FCM token for company admin users to receive push notifications when offline.

**Request:**
```json
{
  "fcmToken": "firebase_device_token_here"
}
```

**Headers:**
```json
{
  "Cookie": "authToken=<jwt_token_from_login>"
}
```

**Response (200 OK):**
```json
{
  "message": "FCM token updated successfully",
  "updated": true
}
```

**Response (200 OK - Already up to date):**
```json
{
  "message": "FCM token is already up to date",
  "updated": false
}
```

**When to Call:**
- ✅ After successful admin login
- ✅ When FCM token refreshes
- ✅ When app comes back online after being offline

**Example Flutter Implementation:**
```dart
Future<void> registerFcmToken(String fcmToken) async {
  final dio = Dio();
  
  try {
    final response = await dio.post(
      'https://your-api.com/api/company/auth/admin/update-fcm-token',
      data: {'fcmToken': fcmToken},
      options: Options(
        headers: {
          'Cookie': 'authToken=$authToken',
        },
      ),
    );
    
    print('✅ FCM token registered: ${response.data}');
  } catch (e) {
    print('❌ Failed to register FCM token: $e');
  }
}
```

---

### 2. FCM Token Cleanup on Logout

```javascript
// POST /api/company/auth/logout
{
  "fcmToken": "firebase_token_here"
}
```

**Why:** Remove token when user logs out to avoid sending notifications to wrong device.

---

## 📱 Flutter Implementation Architecture

### Three-Layer Notification System

```
┌─────────────────────────────────────────────────────────┐
│                    FLUTTER APP                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Layer 1: FCM Push (App Closed/Background)              │
│  ├─ Firebase Messaging                                  │
│  ├─ Local Notifications                                 │
│  └─ Background Handler                                  │
│                                                         │
│  Layer 2: WebSocket (App Open - Real-time)              │
│  ├─ WebSocket Connection                                │
│  ├─ Auto-reconnect Logic                                │
│  └─ Riverpod State Update                               │
│                                                         │
│  Layer 3: REST API (Fetch & Sync)                       │
│  ├─ Pull Notifications on App Open                      │
│  ├─ Mark as Read/Seen                                   │
│  └─ Delete Notifications                                │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 🔥 Step 1: FCM Setup (Push Notifications)

### Flutter Packages Required

```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_messaging: ^14.7.9
  flutter_local_notifications: ^16.3.0
```

### FCM Service Implementation

```dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ==================== Background Handler (Top-level function) ====================

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('📲 Background notification: ${message.notification?.title}');
  
  // Show local notification
  await _showLocalNotification(message);
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

  // Initialize FCM
  Future<void> initialize() async {
    // Request permission
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ FCM Permission granted');
      
      // Get FCM token
      _fcmToken = await _firebaseMessaging.getToken();
      print('📱 FCM Token: $_fcmToken');
      
      // Initialize local notifications
      await _initializeLocalNotifications();
      
      // Listen to token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        // TODO: Send new token to backend
        _updateTokenOnBackend(newToken);
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
    }
  }

  // Initialize local notifications (for showing when app is in foreground)
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );
  }

  // Handle foreground messages (app is open)
  void _handleForegroundMessage(RemoteMessage message) {
    print('📨 Foreground notification: ${message.notification?.title}');
    
    // Show local notification when app is in foreground
    _showLocalNotification(message);
    
    // Update Riverpod state (refresh notifications list)
    // TODO: Trigger Riverpod provider refresh
  }

  // Handle notification tap
  void _handleNotificationTap(RemoteMessage message) {
    print('👆 Notification tapped: ${message.data}');
    
    // Navigate to specific screen based on notification type
    final type = message.data['type'];
    final globalOrderId = message.data['globalOrderId'];
    
    if (type == 'new_order' || type == 'new_sub_order') {
      // Navigate to order details
      // TODO: Navigation logic
    }
  }

  // Show local notification
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'hawiya_notifications',
      'Hawiya Notifications',
      channelDescription: 'Notifications for new orders and updates',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await FlutterLocalNotificationsPlugin().show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
      payload: message.data.toString(),
    );
  }

  // Handle local notification tap
  void _onLocalNotificationTap(NotificationResponse response) {
    print('👆 Local notification tapped: ${response.payload}');
    // TODO: Navigation logic
  }

  // Update token on backend
  Future<void> _updateTokenOnBackend(String token) async {
    try {
      final dio = Dio();
      
      // Get auth token from secure storage
      final authToken = await SecureStorage().getAuthToken();
      
      final response = await dio.post(
        'https://your-api.com/api/company/auth/admin/update-fcm-token',
        data: {'fcmToken': token},
        options: Options(
          headers: {
            'Cookie': 'authToken=$authToken',
          },
        ),
      );
      
      print('✅ FCM token updated on backend: ${response.data}');
    } catch (e) {
      print('❌ Failed to update FCM token: $e');
    }
  }

  // Unsubscribe (on logout)
  Future<void> unsubscribe() async {
    if (_fcmToken != null) {
      // TODO: Call backend to remove token
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
    }
  }
}
```

---

## 🔌 Step 2: WebSocket Integration (Real-time)

### WebSocket Service

```dart
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

// ==================== WebSocket Service ====================

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  WebSocketChannel? _channel;
  StreamController<CompanyNotification>? _notificationController;
  Stream<CompanyNotification>? _notificationStream;
  
  Timer? _reconnectTimer;
  bool _isConnected = false;
  String? _token;

  // Get notification stream
  Stream<CompanyNotification> get notificationStream {
    _notificationController ??= StreamController<CompanyNotification>.broadcast();
    _notificationStream ??= _notificationController!.stream;
    return _notificationStream!;
  }

  // Connect to WebSocket
  Future<void> connect(String token) async {
    _token = token;
    
    try {
      print('🔌 Connecting to WebSocket...');
      
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://localhost:3000?token=$token&role=company'),
      );

      _isConnected = true;
      print('✅ WebSocket connected');

      // Listen to messages
      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDisconnected,
      );
    } catch (e) {
      print('❌ WebSocket connection failed: $e');
      _scheduleReconnect();
    }
  }

  // Handle incoming messages
  void _onMessage(dynamic data) {
    try {
      final json = jsonDecode(data);
      final type = json['type'];

      if (type == 'new_notification') {
        final notification = CompanyNotification.fromJson(json['notification']);
        _notificationController?.add(notification);
        print('📬 New notification received: ${notification.title}');
      }
    } catch (e) {
      print('❌ Error parsing WebSocket message: $e');
    }
  }

  // Handle errors
  void _onError(error) {
    print('❌ WebSocket error: $error');
    _isConnected = false;
    _scheduleReconnect();
  }

  // Handle disconnection
  void _onDisconnected() {
    print('🔌 WebSocket disconnected');
    _isConnected = false;
    _scheduleReconnect();
  }

  // Schedule reconnection
  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (_token != null && !_isConnected) {
        print('🔄 Attempting to reconnect...');
        connect(_token!);
      }
    });
  }

  // Disconnect
  void disconnect() {
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _isConnected = false;
    _token = null;
    print('🔌 WebSocket disconnected manually');
  }

  // Check connection status
  bool get isConnected => _isConnected;
}
```

---

## 🌐 Step 3: REST API Models & Service

### Models (freezed)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_notification.freezed.dart';
part 'company_notification.g.dart';

// ==================== Company Notification Model ====================

@freezed
class CompanyNotification with _$CompanyNotification {
  const factory CompanyNotification({
    required String id,
    required String companyId,
    String? globalOrderId,
    required String type, // new_order, new_sub_order, order_cancelled, payment_received, system_message
    required String title,
    required String message,
    Map<String, dynamic>? data,
    required bool isRead,
    DateTime? readAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    GlobalOrderBasic? globalOrder, // Associated order (if any)
  }) = _CompanyNotification;

  factory CompanyNotification.fromJson(Map<String, dynamic> json) =>
      _$CompanyNotificationFromJson(json);
}

// ==================== Global Order Basic (for association) ====================

@freezed
class GlobalOrderBasic with _$GlobalOrderBasic {
  const factory GlobalOrderBasic({
    required String id,
    String? orderNumber,
    String? containerType,
    String? containerSize,
    String? deliveryLocation,
  }) = _GlobalOrderBasic;

  factory GlobalOrderBasic.fromJson(Map<String, dynamic> json) =>
      _$GlobalOrderBasicFromJson(json);
}

// ==================== Response Models ====================

@freezed
class NotificationsResponse with _$NotificationsResponse {
  const factory NotificationsResponse({
    required bool success,
    required List<CompanyNotification> notifications,
    required int unreadCount,
    required int total,
  }) = _NotificationsResponse;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);
}

@freezed
class UnreadCountResponse with _$UnreadCountResponse {
  const factory UnreadCountResponse({
    required bool success,
    required int unreadCount,
  }) = _UnreadCountResponse;

  factory UnreadCountResponse.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountResponseFromJson(json);
}

// ==================== Notification Type Enum ====================

enum NotificationType {
  @JsonValue('new_order')
  newOrder,
  @JsonValue('new_sub_order')
  newSubOrder,
  @JsonValue('order_cancelled')
  orderCancelled,
  @JsonValue('payment_received')
  paymentReceived,
  @JsonValue('system_message')
  systemMessage;

  String get displayName {
    switch (this) {
      case NotificationType.newOrder:
        return 'طلب جديد';
      case NotificationType.newSubOrder:
        return 'طلب فرعي';
      case NotificationType.orderCancelled:
        return 'طلب ملغي';
      case NotificationType.paymentReceived:
        return 'دفعة مستلمة';
      case NotificationType.systemMessage:
        return 'رسالة النظام';
    }
  }

  String get iconPath {
    switch (this) {
      case NotificationType.newOrder:
        return 'assets/icons/new_order.svg';
      case NotificationType.newSubOrder:
        return 'assets/icons/sub_order.svg';
      case NotificationType.orderCancelled:
        return 'assets/icons/cancelled.svg';
      case NotificationType.paymentReceived:
        return 'assets/icons/payment.svg';
      case NotificationType.systemMessage:
        return 'assets/icons/system.svg';
    }
  }

  String get colorHex {
    switch (this) {
      case NotificationType.newOrder:
        return '#4CAF50'; // Green
      case NotificationType.newSubOrder:
        return '#2196F3'; // Blue
      case NotificationType.orderCancelled:
        return '#F44336'; // Red
      case NotificationType.paymentReceived:
        return '#FF9800'; // Orange
      case NotificationType.systemMessage:
        return '#9C27B0'; // Purple
    }
  }
}
```

### API Service

```dart
import 'package:dio/dio.dart';

class NotificationService {
  final Dio _dio;

  NotificationService(this._dio);

  // ==================== Admin Notifications ====================

  /// Get all admin notifications with pagination
  Future<NotificationsResponse> getAdminNotifications({
    int limit = 50,
    int offset = 0,
    bool unreadOnly = false,
  }) async {
    final response = await _dio.get(
      '/company/admin/notifications',
      queryParameters: {
        'limit': limit,
        'offset': offset,
        'unreadOnly': unreadOnly,
      },
    );
    return NotificationsResponse.fromJson(response.data);
  }

  /// Get unread count
  Future<int> getUnreadCount() async {
    final response = await _dio.get('/company/admin/notifications/unread-count');
    final data = UnreadCountResponse.fromJson(response.data);
    return data.unreadCount;
  }

  /// Mark single notification as read
  Future<void> markAsRead(String notificationId) async {
    await _dio.patch('/company/admin/notifications/$notificationId/read');
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    await _dio.patch('/company/admin/notifications/mark-all-read');
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    await _dio.delete('/company/admin/notifications/$notificationId');
  }

  // ==================== Regular Notifications (Drivers) ====================

  /// Get user notifications (for drivers)
  Future<List<CompanyNotification>> getUserNotifications({
    int page = 1,
  }) async {
    final response = await _dio.get(
      '/company/notifications',
      queryParameters: {'page': page},
    );
    
    final notifications = (response.data['notifications'] as List)
        .map((json) => CompanyNotification.fromJson(json))
        .toList();
    
    return notifications;
  }

  /// Mark notifications as seen (updates lastReadAt)
  Future<void> markNotificationsAsSeen() async {
    await _dio.patch('/company/notifications/seen');
  }

  /// Get unread count for user
  Future<int> getUserUnreadCount() async {
    final response = await _dio.get('/company/notifications/unread-count');
    return response.data['unreadCount'] as int;
  }
}
```

---

## 🎛️ Step 4: Riverpod State Management

### Providers

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== Notification Service Provider ====================

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final dio = ref.read(dioProvider);
  return NotificationService(dio);
});

// ==================== WebSocket Service Provider ====================

final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  return WebSocketService();
});

// ==================== FCM Service Provider ====================

final fcmServiceProvider = Provider<FCMService>((ref) {
  return FCMService();
});

// ==================== Admin Notifications State ====================

@riverpod
class AdminNotifications extends _$AdminNotifications {
  @override
  Future<List<CompanyNotification>> build() async {
    // Connect WebSocket
    final token = ref.read(authTokenProvider);
    if (token != null) {
      final wsService = ref.read(webSocketServiceProvider);
      await wsService.connect(token);
      
      // Listen to WebSocket stream
      wsService.notificationStream.listen((notification) {
        // Add new notification to list
        state.whenData((notifications) {
          state = AsyncValue.data([notification, ...notifications]);
        });
        
        // Refresh unread count
        ref.invalidate(unreadCountProvider);
      });
    }
    
    // Fetch initial notifications
    final service = ref.read(notificationServiceProvider);
    final response = await service.getAdminNotifications();
    return response.notifications;
  }

  /// Refresh notifications
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(notificationServiceProvider);
      final response = await service.getAdminNotifications();
      return response.notifications;
    });
  }

  /// Mark as read
  Future<void> markAsRead(String notificationId) async {
    final service = ref.read(notificationServiceProvider);
    await service.markAsRead(notificationId);
    
    // Update local state
    state.whenData((notifications) {
      final updated = notifications.map((n) {
        if (n.id == notificationId) {
          return n.copyWith(isRead: true, readAt: DateTime.now());
        }
        return n;
      }).toList();
      state = AsyncValue.data(updated);
    });
    
    // Refresh unread count
    ref.invalidate(unreadCountProvider);
  }

  /// Mark all as read
  Future<void> markAllAsRead() async {
    final service = ref.read(notificationServiceProvider);
    await service.markAllAsRead();
    
    // Update local state
    state.whenData((notifications) {
      final updated = notifications.map((n) {
        return n.copyWith(isRead: true, readAt: DateTime.now());
      }).toList();
      state = AsyncValue.data(updated);
    });
    
    // Refresh unread count
    ref.invalidate(unreadCountProvider);
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    final service = ref.read(notificationServiceProvider);
    await service.deleteNotification(notificationId);
    
    // Remove from local state
    state.whenData((notifications) {
      final updated = notifications.where((n) => n.id != notificationId).toList();
      state = AsyncValue.data(updated);
    });
    
    // Refresh unread count
    ref.invalidate(unreadCountProvider);
  }
}

// ==================== Unread Count Provider ====================

@riverpod
class UnreadCount extends _$UnreadCount {
  @override
  Future<int> build() async {
    final service = ref.read(notificationServiceProvider);
    return await service.getUnreadCount();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(notificationServiceProvider);
      return await service.getUnreadCount();
    });
  }
}
```

---

## 🎨 Step 5: UI Implementation

### Notifications Screen

```dart
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(adminNotificationsProvider);
    final unreadCountAsync = ref.watch(unreadCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        actions: [
          // Unread count badge
          unreadCountAsync.when(
            data: (count) => count > 0
                ? Badge(
                    label: Text('$count'),
                    child: const Icon(Icons.notifications),
                  )
                : const Icon(Icons.notifications_none),
            loading: () => const Icon(Icons.notifications_none),
            error: (_, __) => const Icon(Icons.notifications_none),
          ),
          const SizedBox(width: 8),
          
          // Mark all as read button
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              ref.read(adminNotificationsProvider.notifier).markAllAsRead();
            },
          ),
        ],
      ),
      body: notificationsAsync.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('لا توجد إشعارات', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(adminNotificationsProvider.notifier).refresh();
            },
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(
                  notification: notification,
                  onTap: () => _handleNotificationTap(context, ref, notification),
                  onDismiss: () => _handleDelete(ref, notification.id),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('خطأ: $error')),
      ),
    );
  }

  void _handleNotificationTap(
    BuildContext context,
    WidgetRef ref,
    CompanyNotification notification,
  ) {
    // Mark as read
    if (!notification.isRead) {
      ref.read(adminNotificationsProvider.notifier).markAsRead(notification.id);
    }

    // Navigate based on type
    if (notification.globalOrderId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OrderDetailsScreen(orderId: notification.globalOrderId!),
        ),
      );
    }
  }

  Future<void> _handleDelete(WidgetRef ref, String notificationId) async {
    await ref.read(adminNotificationsProvider.notifier).deleteNotification(notificationId);
  }
}
```

### Notification Card Widget

```dart
class NotificationCard extends StatelessWidget {
  final CompanyNotification notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final type = NotificationType.values.firstWhere(
      (e) => e.name == notification.type,
      orElse: () => NotificationType.systemMessage,
    );

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDismiss(),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Color(
            int.parse(type.colorHex.substring(1), radix: 16) + 0xFF000000,
          ),
          child: const Icon(Icons.notifications, color: Colors.white),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification.message),
            const SizedBox(height: 4),
            Text(
              _formatDate(notification.createdAt),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: !notification.isRead
            ? Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        tileColor: notification.isRead ? null : Colors.blue.withOpacity(0.05),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) return 'الآن';
    if (difference.inMinutes < 60) return 'منذ ${difference.inMinutes} دقيقة';
    if (difference.inHours < 24) return 'منذ ${difference.inHours} ساعة';
    if (difference.inDays < 7) return 'منذ ${difference.inDays} يوم';
    
    return '${date.day}/${date.month}/${date.year}';
  }
}
```

---

## 🔔 Step 6: Unread Badge (App-wide)

### Badge in AppBar

```dart
AppBar(
  actions: [
    Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            );
          },
        ),
        Consumer(
          builder: (context, ref, _) {
            final unreadCount = ref.watch(unreadCountProvider);
            return unreadCount.when(
              data: (count) => count > 0
                  ? Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          count > 99 ? '99+' : '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            );
          },
        ),
      ],
    ),
  ],
)
```

---

## 🚀 Step 7: App Lifecycle Integration

### Main App Setup

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Set background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeNotifications();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initializeNotifications() async {
    // Initialize FCM
    final fcmService = ref.read(fcmServiceProvider);
    await fcmService.initialize();
    
    // If user is logged in, connect WebSocket
    final token = ref.read(authTokenProvider);
    if (token != null) {
      final wsService = ref.read(webSocketServiceProvider);
      await wsService.connect(token);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App resumed - refresh notifications
      ref.invalidate(adminNotificationsProvider);
      ref.invalidate(unreadCountProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hawiya Company',
      home: const HomeScreen(),
    );
  }
}
```

---

## 📋 Summary & Best Practices

### ✅ What Your Backend Has

1. **REST API:** Complete CRUD for notifications ✅
2. **WebSocket:** Real-time push for admin notifications ✅
3. **FCM Integration:** Firebase Cloud Messaging configured ✅
4. **Database Persistence:** All notifications stored ✅
5. **Order Association:** Link to `globalOrderId` ✅

### ⚠️ What You Need to Add (Backend)

1. **FCM Token Registration:** `POST /api/company/auth/register-fcm-token`
2. **FCM Token Cleanup:** `POST /api/company/auth/logout` (with token removal)

### 🎯 Flutter Integration Checklist

- [ ] Add Firebase packages to `pubspec.yaml`
- [ ] Configure Firebase (download `google-services.json` for Android, `GoogleService-Info.plist` for iOS)
- [ ] Implement FCM Service with background handler
- [ ] Implement WebSocket Service with auto-reconnect
- [ ] Create Freezed models for notifications
- [ ] Create API service with Dio
- [ ] Create Riverpod providers for state management
- [ ] Build Notifications UI screen
- [ ] Add unread badge to AppBar
- [ ] Handle notification taps (navigation)
- [ ] Test foreground, background, and terminated states

---

**Your backend is READY for Flutter integration!** The current API structure is perfect for a production mobile app. Just add FCM token registration endpoints and you're good to go! 🚀
