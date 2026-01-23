# Notification System Implementation

## Overview
This notification system provides real-time notifications for admin users with three-layer delivery:
1. **FCM Push Notifications** - When app is closed or in background
2. **WebSocket Real-time** - When app is open and active
3. **REST API** - For fetching notification history and synchronization

## Architecture

### 📁 File Structure
```
lib/features/notifications/
├── models/
│   ├── notification_models.dart         # Freezed models for notifications
│   ├── notification_models.freezed.dart # Generated freezed code
│   └── notification_models.g.dart       # Generated JSON serialization
├── services/
│   ├── fcm_service.dart                 # Firebase Cloud Messaging service
│   ├── websocket_service.dart           # Real-time WebSocket connection
│   └── notification_api_service.dart    # REST API for notifications
├── providers/
│   └── notification_providers.dart      # Riverpod state management
└── screens/
    └── notifications_screen.dart        # Notification list UI

lib/shared/widgets/
└── notification_icon_button.dart        # Badge icon for AppBar
```

### 🔧 Services

#### 1. FCMService
**Purpose:** Handle push notifications when app is closed/background

**Key Features:**
- Background handler for terminated app state
- Permission request and token management
- Token refresh listener
- Foreground message display with local notifications
- Notification tap handling with stream

**Methods:**
- `initialize()` - Setup FCM and request permissions
- `fcmToken` - Get current FCM token (property)
- `onNotificationTap` - Stream for notification tap events
- `unsubscribe()` - Remove token on logout

#### 2. WebsocketService
**Purpose:** Real-time notification delivery when app is active

**Key Features:**
- Singleton pattern for app-wide access
- Auto-reconnect with 5-second delay
- Ping/pong keep-alive every 30 seconds
- Broadcast stream for multiple listeners
- Graceful error handling

**Methods:**
- `connect(token)` - Establish WebSocket connection
- `disconnect()` - Manual disconnect (logout)
- `notificationStream` - Broadcast stream of notifications
- `isConnected` - Connection status (property)

#### 3. NotificationApiService
**Purpose:** REST API for notification CRUD operations

**Admin Methods:**
- `getAdminNotifications(limit, offset, unreadOnly)` - Paginated fetch
- `getUnreadCount()` - Badge count
- `markAsRead(id)` - Single notification
- `markAllAsRead()` - Bulk operation
- `deleteNotification(id)` - Remove notification

**FCM Methods:**
- `updateFcmToken(token)` - Register device
- `removeFcmToken(token)` - Unregister on logout

### 📊 State Management

#### AdminNotificationsNotifier
**State:**
```dart
{
  notifications: List<CompanyNotification>,
  isLoading: bool,
  error: String?,
  hasMore: bool,
  currentOffset: int
}
```

**Features:**
- WebSocket listener for real-time updates
- Pagination with infinite scroll
- Optimistic UI updates
- Error handling with retry

**Methods:**
- `loadNotifications(refresh)` - Initial/refresh load
- `loadMore()` - Pagination
- `markAsRead(id)` - Update read status
- `markAllAsRead()` - Bulk read
- `deleteNotification(id)` - Remove notification

#### UnreadCountNotifier
**State:** `int` (count)

**Features:**
- WebSocket listener for new notifications
- Auto-increment on new unread notification
- Decrement/reset methods for UI updates

**Methods:**
- `refresh()` - Reload count from API
- `decrementCount()` - When marking one as read
- `resetCount()` - When marking all as read

### 🎨 UI Components

#### NotificationsScreen
**Features:**
- Pull-to-refresh
- Infinite scroll pagination
- Swipe-to-delete
- Empty state
- Error state with retry
- "Mark all as read" button

**Card Features:**
- Type-based color and icon
- Unread indicator (badge)
- Relative time display
- Order information chip
- Tap to navigate

#### NotificationIconButton
**Features:**
- Unread badge with count
- Auto-updates via Riverpod
- 99+ overflow handling
- Navigation to notifications screen

### 🔄 Integration

#### App Initialization (main.dart)
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize FCM
  await FCMService().initialize();
  
  // Connect WebSocket if logged in
  final token = await StorageService.getToken();
  if (token != null) {
    await WebsocketService.instance.connect(token);
  }
  
  runApp(ProviderScope(child: MyApp()));
}
```

#### Auth Integration (auth_provider.dart)
**On Login:**
1. Get FCM token
2. Send token to backend
3. Connect WebSocket

**On Logout:**
1. Get FCM token
2. Remove token from backend
3. Unsubscribe from FCM
4. Disconnect WebSocket
5. Clear storage

### 🎯 Notification Types
```dart
enum NotificationType {
  newOrder,                     // طلب جديد
  newSubOrder,                  // طلب فرعي جديد
  orderCancelled,               // تم إلغاء الطلب
  paymentReceived,              // تم استلام الدفع
  systemMessage,                // رسالة النظام
  adminMessage,                 // رسالة من الإدارة
  companyBanned,                // تم حظر الشركة
  adminWarning,                 // تحذير من الإدارة
  platformAnnouncement,         // إعلان المنصة
  containerTypeRequestApproved, // تمت الموافقة على نوع الحاوية
  containerTypeRequestRejected, // تم رفض نوع الحاوية
}
```

Each type has:
- `displayName` (Arabic)
- `color` (Color)
- `icon` (IconData)

### 🔗 Navigation
**Routes:**
- `/notifications` - Notification list screen

**Protected Routes:**
Updated router to include `/notifications` in protected routes

**AppBar Integration:**
Added `NotificationIconButton` to `MainLayout` AppBar

### 🚀 Usage Examples

#### Accessing Notifications in a Screen
```dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch notifications
    final notificationsState = ref.watch(adminNotificationsProvider);
    
    // Watch unread count
    final unreadCount = ref.watch(unreadCountProvider);
    
    // Actions
    final notifier = ref.read(adminNotificationsProvider.notifier);
    await notifier.loadNotifications();
    await notifier.markAsRead(notificationId);
  }
}
```

#### Listening to New Notifications
The providers automatically listen to WebSocket for new notifications. No manual subscription needed.

### ⚙️ Configuration

#### API Endpoints
```dart
// Admin Notifications
GET    /api/company/admin/notifications?limit=50&offset=0&unreadOnly=true
GET    /api/company/admin/notifications/unread-count
PATCH  /api/company/admin/notifications/:id/read
PATCH  /api/company/admin/notifications/mark-all-read
DELETE /api/company/admin/notifications/:id

// FCM Tokens
POST   /api/company/auth/admin/update-fcm-token
POST   /api/company/auth/logout (with fcmToken)
```

#### WebSocket URL
Automatically derived from `ApiConfig.baseUrl`:
- `http://` → `ws://`
- `https://` → `wss://`

Connection URL: `ws://host:port?token=<jwt>&role=company`

### 🔒 Security

1. **JWT Authentication:**
   - Token in WebSocket query parameter
   - Bearer token in API requests (via ApiService interceptor)

2. **Token Management:**
   - FCM token sent to backend on login
   - FCM token removed on logout
   - WebSocket disconnected on logout

3. **State Persistence:**
   - Token stored in secure storage
   - Auto-reconnect on app restart if logged in

### 📱 Firebase Setup Required

**Android:**
1. Download `google-services.json` from Firebase Console
2. Place in `android/app/google-services.json`
3. Ensure Firebase SDK is configured in `android/build.gradle`

**iOS:**
1. Download `GoogleService-Info.plist` from Firebase Console
2. Place in `ios/Runner/GoogleService-Info.plist`
3. Configure in Xcode project

### ✅ Testing Checklist

- [ ] FCM notifications received when app is closed
- [ ] FCM notifications received when app is in background
- [ ] Local notification displayed when app is open
- [ ] WebSocket notifications appear instantly when app is open
- [ ] Unread count updates in real-time
- [ ] Pull-to-refresh works
- [ ] Infinite scroll pagination works
- [ ] Swipe-to-delete works
- [ ] Mark as read updates badge count
- [ ] Mark all as read resets badge
- [ ] Notification tap navigates correctly
- [ ] WebSocket reconnects after disconnect
- [ ] Token sent to backend on login
- [ ] Token removed on logout
- [ ] App icon badge updates (iOS)

### 🐛 Troubleshooting

**WebSocket not connecting:**
- Check baseUrl in ApiConfig
- Verify token is valid
- Check network connectivity
- Look for error logs in console

**FCM not receiving:**
- Verify Firebase setup (google-services.json/GoogleService-Info.plist)
- Check FCM token in console
- Ensure backend is sending to correct token
- Check notification permissions

**Badge not updating:**
- Verify providers are watched (not just read)
- Check WebSocket is connected
- Ensure notifications have isRead=false

**Build errors:**
- Run `flutter pub get`
- Run `flutter pub run build_runner build --delete-conflicting-outputs`
- Clean and rebuild: `flutter clean && flutter pub get`

### 📝 Notes

1. **Notification Persistence:**
   - Notifications are fetched from API on app start
   - WebSocket provides real-time updates
   - Local state is updated optimistically

2. **Performance:**
   - Pagination prevents loading all notifications at once
   - WebSocket broadcasts to multiple listeners efficiently
   - Freezed models ensure immutability and performance

3. **Future Enhancements:**
   - Push notification sound/vibration customization
   - Notification categories/filters
   - Notification settings screen
   - Mark as unread
   - Notification search
   - Rich media notifications (images)

## Dependencies
```yaml
firebase_core: ^2.24.2
firebase_messaging: ^14.7.9
flutter_local_notifications: ^16.3.0
web_socket_channel: ^2.4.0
freezed: ^2.4.4
freezed_annotation: ^2.4.4
```

## Completion Status
✅ All core features implemented
✅ Integration with auth system complete
✅ UI screens created
✅ Error handling added
✅ No compilation errors
⏳ Firebase configuration pending (requires google-services.json)
⏳ Testing pending
