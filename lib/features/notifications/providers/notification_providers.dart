import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/notification_models.dart';
import '../services/fcm_service.dart';
import '../services/notification_api_service.dart';
import '../services/websocket_service.dart';

// ==================== Service Providers ====================

/// FCM Service Provider
final fcmServiceProvider = Provider<FCMService>((ref) {
  return FCMService();
});

/// WebSocket Service Provider  
final websocketServiceProvider = Provider<WebsocketService>((ref) {
  return WebsocketService.instance;
});

/// Notification API Service Provider
final notificationApiServiceProvider = Provider<NotificationApiService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return NotificationApiService(apiService);
});

// ==================== Notification State ====================

/// Notification State Model
class NotificationState {
  final List<CompanyNotification> notifications;
  final bool isLoading;
  final String? error;
  final bool hasMore;
  final int currentOffset;

  const NotificationState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
    this.hasMore = true,
    this.currentOffset = 0,
  });

  NotificationState copyWith({
    List<CompanyNotification>? notifications,
    bool? isLoading,
    String? error,
    bool? hasMore,
    int? currentOffset,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }
}

// ==================== Notifications Notifier ====================

class AdminNotificationsNotifier extends StateNotifier<NotificationState> {
  final NotificationApiService _apiService;
  final WebsocketService _websocketService;
  final bool _isAuthenticated;

  AdminNotificationsNotifier(this._apiService, this._websocketService)
      : _isAuthenticated = true,
        super(const NotificationState()) {
    _listenToWebSocket();
    // Auto-load to ensure background listening works
    loadNotifications();
  }

  // Empty constructor for unauthenticated users
  AdminNotificationsNotifier._empty(this._apiService, this._websocketService)
      : _isAuthenticated = false,
        super(const NotificationState());

  /// Listen to WebSocket for real-time notifications
  void _listenToWebSocket() {
    _websocketService.notificationStream.listen(
      (notification) {
        // Add new notification to the top of the list
        state = state.copyWith(
          notifications: [notification, ...state.notifications],
        );
      },
      onError: (error) {
        print('❌ WebSocket error in AdminNotificationsNotifier: $error');
      },
    );
  }

  /// Load notifications (initial or refresh)
  Future<void> loadNotifications({bool refresh = false}) async {
    if (!_isAuthenticated) {
      print('⚠️ AdminNotificationsNotifier: Not authenticated, skipping load');
      return;
    }
    
    print('📥 Loading notifications...');
    
    if (refresh) {
      state = const NotificationState(isLoading: true);
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      final response = await _apiService.getAdminNotifications(
        limit: 50,
        offset: 0,
      );
      
      print('✅ Loaded ${response.notifications.length} notifications');

      state = NotificationState(
        notifications: response.notifications,
        isLoading: false,
        hasMore: response.total > 50,
        currentOffset: 50,
      );
    } catch (e) {
      print('❌ Error loading notifications: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'فشل تحميل الإشعارات: ${e.toString().contains('404') ? 'الواجهة غير موجودة' : e.toString().contains('401') ? 'انتهت الجلسة' : 'خطأ في الاتصال'}',
      );
    }
  }

  /// Load more notifications (pagination)
  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await _apiService.getAdminNotifications(
        limit: 50,
        offset: state.currentOffset,
      );

      final allNotifications = [...state.notifications, ...response.notifications];

      state = state.copyWith(
        notifications: allNotifications,
        isLoading: false,
        hasMore: allNotifications.length < response.total,
        currentOffset: state.currentOffset + 50,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'فشل تحميل المزيد',
      );
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _apiService.markAsRead(notificationId);

      // Update local state
      state = state.copyWith(
        notifications: state.notifications.map((n) {
          if (n.id == notificationId) {
            return n.copyWith(
              isRead: true,
              readAt: DateTime.now(),
            );
          }
          return n;
        }).toList(),
      );
    } catch (e) {
      // Silently fail - not critical
      print('❌ Failed to mark as read: $e');
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      await _apiService.markAllAsRead();

      // Update local state
      final now = DateTime.now();
      state = state.copyWith(
        notifications: state.notifications.map((n) {
          return n.copyWith(isRead: true, readAt: now);
        }).toList(),
      );
    } catch (e) {
      print('❌ Failed to mark all as read: $e');
    }
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _apiService.deleteNotification(notificationId);

      // Remove from local state
      state = state.copyWith(
        notifications: state.notifications.where((n) => n.id != notificationId).toList(),
      );
    } catch (e) {
      print('❌ Failed to delete notification: $e');
    }
  }
}

/// Admin Notifications Provider
final adminNotificationsProvider =
    StateNotifierProvider<AdminNotificationsNotifier, NotificationState>((ref) {
  final authState = ref.watch(authProvider);
  final apiService = ref.watch(notificationApiServiceProvider);
  final websocketService = ref.watch(websocketServiceProvider);
  
  // Only initialize if user is authenticated
  if (!authState.isAuthenticated) {
    return AdminNotificationsNotifier._empty(apiService, websocketService);
  }
  
  return AdminNotificationsNotifier(apiService, websocketService);
});

// ==================== General Notifications State ====================

/// General Notification State Model (for admin messages & assessments)
class GeneralNotificationState {
  final List<AdminNotification> notifications;
  final bool isLoading;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final int totalPages;

  const GeneralNotificationState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 0,
    this.totalPages = 1,
  });

  GeneralNotificationState copyWith({
    List<AdminNotification>? notifications,
    bool? isLoading,
    String? error,
    bool? hasMore,
    int? currentPage,
    int? totalPages,
  }) {
    return GeneralNotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}

// ==================== General Notifications Notifier ====================

class GeneralNotificationsNotifier extends StateNotifier<GeneralNotificationState> {
  final NotificationApiService _apiService;

  GeneralNotificationsNotifier(this._apiService)
      : super(const GeneralNotificationState());

  /// Load notifications (initial or refresh)
  Future<void> loadNotifications({bool refresh = false}) async {
    if (refresh) {
      state = const GeneralNotificationState(isLoading: true);
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      final response = await _apiService.getGeneralNotifications(page: 1);

      state = GeneralNotificationState(
        notifications: response.notifications,
        isLoading: false,
        hasMore: response.currentPage < response.totalPages,
        currentPage: response.currentPage,
        totalPages: response.totalPages,
      );
    } catch (e) {
      print('❌ Error loading general notifications: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'فشل تحميل الإشعارات: ${e.toString().contains('404') ? 'الواجهة غير موجودة' : e.toString().contains('401') ? 'انتهت الجلسة' : 'خطأ في الاتصال'}',
      );
    }
  }

  /// Load more notifications (pagination)
  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await _apiService.getGeneralNotifications(
        page: state.currentPage + 1,
      );

      final allNotifications = [...state.notifications, ...response.notifications];

      state = state.copyWith(
        notifications: allNotifications,
        isLoading: false,
        hasMore: response.currentPage < response.totalPages,
        currentPage: response.currentPage,
        totalPages: response.totalPages,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'فشل تحميل المزيد',
      );
    }
  }
}

/// General Notifications Provider
final generalNotificationsProvider =
    StateNotifierProvider<GeneralNotificationsNotifier, GeneralNotificationState>((ref) {
  final apiService = ref.watch(notificationApiServiceProvider);
  return GeneralNotificationsNotifier(apiService);
});

// ==================== Unread Count Provider ====================

/// Unread Count Notifier
class UnreadCountNotifier extends StateNotifier<int> {
  final NotificationApiService _apiService;
  final WebsocketService _websocketService;
  final FCMService _fcmService;
  final bool _isAuthenticated;

  UnreadCountNotifier(this._apiService, this._websocketService, this._fcmService)
      : _isAuthenticated = true,
        super(0) {
    _listenToWebSocket();
    // Auto-load unread count on initialization
    _loadUnreadCount();
  }

  // Empty constructor for unauthenticated users
  UnreadCountNotifier._empty(this._apiService, this._websocketService, this._fcmService)
      : _isAuthenticated = false,
        super(0);

  /// Listen to WebSocket for new notifications
  void _listenToWebSocket() {
    print('🔊 UnreadCountNotifier: Starting WebSocket listener...');
    _websocketService.notificationStream.listen(
      (notification) {
        print('📥 UnreadCountNotifier: Received notification - isRead: ${notification.isRead}');
        if (!notification.isRead) {
          final newCount = state + 1;
          state = newCount;
          _fcmService.updateBadge(newCount);
          print('✅ UnreadCountNotifier: Incremented count to $state');
        }
      },
      onError: (error) {
        print('❌ WebSocket error in UnreadCountNotifier: $error');
      },
    );
  }

  /// Load unread count from API
  Future<void> _loadUnreadCount() async {
    if (!_isAuthenticated) {
      print('⚠️ UnreadCountNotifier: Not authenticated, skipping load');
      return;
    }
    
    print('📊 Loading unread count...');
    
    try {
      final count = await _apiService.getUnreadCount();
      state = count;      await _fcmService.updateBadge(count);      print('✅ Unread count: $count');
    } catch (e) {
      print('❌ Failed to load unread count: $e');
    }
  }

  /// Refresh unread count
  Future<void> refresh() async {
    await _loadUnreadCount();
  }

  /// Decrement count (when marking as read)
  void decrementCount() {
    if (state > 0) {
      final newCount = state - 1;
      state = newCount;
      _fcmService.updateBadge(newCount);
    }
  }

  /// Reset count to 0 (when marking all as read)
  void resetCount() {
    state = 0;
    _fcmService.updateBadge(0);
  }
}

/// Unread Count Provider
final unreadCountProvider = StateNotifierProvider<UnreadCountNotifier, int>((ref) {
  final authState = ref.watch(authProvider);
  final apiService = ref.watch(notificationApiServiceProvider);
  final websocketService = ref.watch(websocketServiceProvider);
  final fcmService = ref.watch(fcmServiceProvider);
  
  // Only initialize if user is authenticated
  if (!authState.isAuthenticated) {
    return UnreadCountNotifier._empty(apiService, websocketService, fcmService);
  }
  
  return UnreadCountNotifier(apiService, websocketService, fcmService);
});
