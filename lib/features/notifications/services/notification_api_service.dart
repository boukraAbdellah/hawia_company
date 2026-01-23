import '../models/notification_models.dart';
import '../../../core/services/api_service.dart';

class NotificationApiService {
  final ApiService _apiService;

  NotificationApiService(this._apiService);

  // ==================== Admin Notifications (CompanyNotification) ====================

  /// Get all admin notifications with pagination (Order-related)
  Future<NotificationsResponse> getAdminNotifications({
    int limit = 50,
    int offset = 0,
    bool unreadOnly = false,
  }) async {
    final response = await _apiService.get(
      '/api/company/admin/notifications',
      queryParameters: {
        'limit': limit,
        'offset': offset,
        if (unreadOnly) 'unreadOnly': true,
      },
    );
    return NotificationsResponse.fromJson(response.data as Map<String, dynamic>);
  }

  /// Get general admin notifications (Messages & Assessments)
  Future<AdminNotificationsResponse> getGeneralNotifications({
    int page = 1,
  }) async {
    final response = await _apiService.get(
      '/api/company/notifications',
      queryParameters: {'page': page},
    );
    return AdminNotificationsResponse.fromJson(response.data as Map<String, dynamic>);
  }

  /// Get unread count
  Future<int> getUnreadCount() async {
    final response = await _apiService.get('/api/company/admin/notifications/unread-count');
    final data = UnreadCountResponse.fromJson(response.data as Map<String, dynamic>);
    return data.unreadCount;
  }

  /// Mark single notification as read
  Future<void> markAsRead(String notificationId) async {
    await _apiService.patch('/api/company/admin/notifications/$notificationId/read');
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    await _apiService.patch('/api/company/admin/notifications/mark-all-read');
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    await _apiService.delete('/api/company/admin/notifications/$notificationId');
  }

  // ==================== User Notifications (Drivers/Staff) ====================

  /// Get user notifications (for drivers and company users)
  Future<List<UserNotification>> getUserNotifications({
    int page = 1,
  }) async {
    final response = await _apiService.get(
      '/api/company/notifications',
      queryParameters: {'page': page},
    );

    final data = response.data as Map<String, dynamic>;
    final notifications = (data['notifications'] as List)
        .map((json) => UserNotification.fromJson(json as Map<String, dynamic>))
        .toList();

    return notifications;
  }

  /// Mark notifications as seen (updates lastReadAt)
  Future<void> markNotificationsAsSeen() async {
    await _apiService.patch('/api/company/notifications/seen');
  }

  /// Get unread count for user
  Future<int> getUserUnreadCount() async {
    final response = await _apiService.get('/api/company/notifications/unread-count');
    final data = response.data as Map<String, dynamic>;
    return data['unreadCount'] as int;
  }

  // ==================== FCM Token Management ====================

  /// Register or update FCM token
  Future<void> updateFcmToken(String fcmToken) async {
    try {
      await _apiService.post(
        '/api/company/auth/admin/update-fcm-token',
        data: {'fcmToken': fcmToken},
      );
    } catch (e) {
      // Log error but don't throw - FCM token update is not critical
      print('❌ Failed to update FCM token: $e');
    }
  }

  /// Remove FCM token on logout
  Future<void> removeFcmToken(String fcmToken) async {
    try {
      await _apiService.post(
        '/api/company/auth/logout',
        data: {'fcmToken': fcmToken},
      );
    } catch (e) {
      print('❌ Failed to remove FCM token: $e');
    }
  }
}
