import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_models.freezed.dart';
part 'notification_models.g.dart';

// ==================== Company Notification Model (Admin) ====================

@freezed
class CompanyNotification with _$CompanyNotification {
  const CompanyNotification._();
  
  const factory CompanyNotification({
    required String id,
    required String companyId,
    String? globalOrderId,
    required String type,
    required String title,
    required String message,
    Map<String, dynamic>? data,
    required bool isRead,
    DateTime? readAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    GlobalOrderBasic? globalOrder,
  }) = _CompanyNotification;

  factory CompanyNotification.fromJson(Map<String, dynamic> json) =>
      _$CompanyNotificationFromJson(json);

  // Get NotificationType from string type
  NotificationType get typeInfo {
    try {
      // Handle special case for new_sub_order with sub-types
      if (type == 'new_sub_order' && data != null) {
        final subType = data!['type'] as String?;
        if (subType != null) {
          // Return newSubOrder - the UI will check data['type'] for the specific sub-type
          return NotificationType.newSubOrder;
        }
      }
      
      return NotificationType.values.firstWhere(
        (e) => e.name.toLowerCase() == type.toLowerCase().replaceAll('_', ''),
        orElse: () => NotificationType.systemMessage,
      );
    } catch (e) {
      return NotificationType.systemMessage;
    }
  }
  
  // Get display name for sub-order types
  String get subOrderDisplayName {
    if (type != 'new_sub_order' || data == null) return typeInfo.displayName;
    
    final subType = data!['type'] as String?;
    if (subType == null) return typeInfo.displayName;
    
    switch (subType.toLowerCase()) {
      case 'delivery':
        return 'طلب توصيل';
      case 'return':
        return 'طلب إرجاع';
      case 'unload':
        return 'طلب تفريغ';
      case 're_delivery':
        return 'طلب إعادة توصيل';
      default:
        return typeInfo.displayName;
    }
  }
  
  // Get icon for sub-order types
  IconData get subOrderIcon {
    if (type != 'new_sub_order' || data == null) return typeInfo.icon;
    
    final subType = data!['type'] as String?;
    if (subType == null) return typeInfo.icon;
    
    switch (subType.toLowerCase()) {
      case 'delivery':
        return Icons.delivery_dining_outlined;
      case 'return':
        return Icons.reply_all_outlined;
      case 'unload':
        return Icons.cleaning_services_outlined;
      case 're_delivery':
        return Icons.refresh_outlined;
      default:
        return typeInfo.icon;
    }
  }
}

// ==================== Admin Notification Model (Messages & Assessments) ====================

@freezed
class AdminNotification with _$AdminNotification {
  const AdminNotification._();
  
  const factory AdminNotification({
    required String id,
    required String userId,
    String? orderId,
    required String type,
    required String title,
    required String message,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AdminNotification;

  factory AdminNotification.fromJson(Map<String, dynamic> json) =>
      _$AdminNotificationFromJson(json);

  // Get NotificationType from string type
  NotificationType get typeInfo {
    try {
      return NotificationType.values.firstWhere(
        (e) => e.name == type.replaceAll('_', ''),
        orElse: () => NotificationType.systemMessage,
      );
    } catch (e) {
      return NotificationType.systemMessage;
    }
  }
}

// ==================== User Notification Model (Drivers) ====================

@freezed
class UserNotification with _$UserNotification {
  const factory UserNotification({
    required String id,
    required String userId,
    required String type,
    required String title,
    required String message,
    Map<String, dynamic>? data,
    required bool isSeen,
    DateTime? seenAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserNotification;

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationFromJson(json);
}

// ==================== Global Order Basic ====================

@freezed
class GlobalOrderBasic with _$GlobalOrderBasic {
  const factory GlobalOrderBasic({
    required String id,
    String? orderNumber,
    String? containerType,
    String? containerSize,
    DeliveryLocation? deliveryLocation,
  }) = _GlobalOrderBasic;

  factory GlobalOrderBasic.fromJson(Map<String, dynamic> json) =>
      _$GlobalOrderBasicFromJson(json);
}

// ==================== Delivery Location ====================

@freezed
class DeliveryLocation with _$DeliveryLocation {
  const factory DeliveryLocation({
    required String address,
    String? cityName,
    required double latitude,
    required double longitude,
  }) = _DeliveryLocation;

  factory DeliveryLocation.fromJson(Map<String, dynamic> json) =>
      _$DeliveryLocationFromJson(json);
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

@freezed
class AdminNotificationsResponse with _$AdminNotificationsResponse {
  const factory AdminNotificationsResponse({
    required String message,
    required int totalNotifications,
    required int totalPages,
    required int currentPage,
    required List<AdminNotification> notifications,
  }) = _AdminNotificationsResponse;

  factory AdminNotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminNotificationsResponseFromJson(json);
}

@freezed
class UserNotificationsResponse with _$UserNotificationsResponse {
  const factory UserNotificationsResponse({
    required List<UserNotification> notifications,
    required int totalCount,
  }) = _UserNotificationsResponse;

  factory UserNotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationsResponseFromJson(json);
}

// ==================== Notification Type Enum ====================

enum NotificationType {
  @JsonValue('new_order')
  newOrder,
  @JsonValue('new_sub_order')
  newSubOrder,
  @JsonValue('order_cancelled')
  orderCancelled,
  @JsonValue('order_accepted')
  orderAccepted,
  @JsonValue('driver_assigned')
  driverAssigned,
  @JsonValue('order_completed')
  orderCompleted,
  @JsonValue('payment_received')
  paymentReceived,
  @JsonValue('system_message')
  systemMessage,
  @JsonValue('admin_message')
  adminMessage,
  @JsonValue('assessment_warning')
  assessmentWarning,
  @JsonValue('assessment_passed')
  assessmentPassed,
  @JsonValue('company_banned')
  companyBanned,
  @JsonValue('admin_warning')
  adminWarning,
  @JsonValue('platform_announcement')
  platformAnnouncement,
  @JsonValue('container_type_request_approved')
  containerTypeRequestApproved,
  @JsonValue('container_type_request_rejected')
  containerTypeRequestRejected;

  String get displayName {
    switch (this) {
      case NotificationType.newOrder:
        return 'طلب جديد';
      case NotificationType.newSubOrder:
        return 'طلب فرعي جديد';
      case NotificationType.orderCancelled:
        return 'تم إلغاء الطلب';
      case NotificationType.orderAccepted:
        return 'تم قبول الطلب';
      case NotificationType.driverAssigned:
        return 'تم تعيين سائق';
      case NotificationType.orderCompleted:
        return 'تم إكمال الطلب';
      case NotificationType.paymentReceived:
        return 'دفعة مستلمة';
      case NotificationType.systemMessage:
        return 'رسالة النظام';
      case NotificationType.adminMessage:
        return 'رسالة جديدة';
      case NotificationType.assessmentWarning:
        return 'تحذير التقييم';
      case NotificationType.assessmentPassed:
        return 'نجاح التقييم';
      case NotificationType.companyBanned:
        return 'حظر الشركة';
      case NotificationType.adminWarning:
        return 'تحذير من الإدارة';
      case NotificationType.platformAnnouncement:
        return 'إعلان المنصة';
      case NotificationType.containerTypeRequestApproved:
        return 'تمت الموافقة على طلب نوع الحاوية';
      case NotificationType.containerTypeRequestRejected:
        return 'تم رفض طلب نوع الحاوية';
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.newOrder:
        return const Color(0xFF2196F3); // Blue
      case NotificationType.newSubOrder:
        return const Color(0xFF9C27B0); // Purple
      case NotificationType.orderCancelled:
        return const Color(0xFFF44336); // Red
      case NotificationType.orderAccepted:
        return const Color(0xFF4CAF50); // Green
      case NotificationType.driverAssigned:
        return const Color(0xFF2196F3); // Blue
      case NotificationType.orderCompleted:
        return const Color(0xFF4CAF50); // Green
      case NotificationType.paymentReceived:
        return const Color(0xFF4CAF50); // Green
      case NotificationType.systemMessage:
        return const Color(0xFF757575); // Grey
      case NotificationType.adminMessage:
        return const Color(0xFF2196F3); // Blue
      case NotificationType.assessmentWarning:
        return const Color(0xFFFF9800); // Orange
      case NotificationType.assessmentPassed:
        return const Color(0xFF4CAF50); // Green
      case NotificationType.companyBanned:
        return const Color(0xFFD32F2F); // Dark Red
      case NotificationType.adminWarning:
        return const Color(0xFFFF5722); // Deep Orange
      case NotificationType.platformAnnouncement:
        return const Color(0xFF00BCD4); // Cyan
      case NotificationType.containerTypeRequestApproved:
        return const Color(0xFF8BC34A); // Light Green
      case NotificationType.containerTypeRequestRejected:
        return const Color(0xFFE91E63); // Pink
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.newOrder:
        return Icons.add_circle_outline;
      case NotificationType.newSubOrder:
        return Icons.assignment_outlined;
      case NotificationType.orderCancelled:
        return Icons.cancel_outlined;
      case NotificationType.orderAccepted:
        return Icons.check_circle_outline;
      case NotificationType.driverAssigned:
        return Icons.drive_eta_outlined;
      case NotificationType.orderCompleted:
        return Icons.done_all_outlined;
      case NotificationType.paymentReceived:
        return Icons.payment_outlined;
      case NotificationType.systemMessage:
        return Icons.info_outlined;
      case NotificationType.adminMessage:
        return Icons.message_outlined;
      case NotificationType.assessmentWarning:
        return Icons.warning_amber_outlined;
      case NotificationType.assessmentPassed:
        return Icons.verified_outlined;
      case NotificationType.companyBanned:
        return Icons.block_outlined;
      case NotificationType.adminWarning:
        return Icons.warning_outlined;
      case NotificationType.platformAnnouncement:
        return Icons.campaign_outlined;
      case NotificationType.containerTypeRequestApproved:
        return Icons.check_circle_outlined;
      case NotificationType.containerTypeRequestRejected:
        return Icons.cancel_outlined;
    }
  }
}

// ==================== Extensions ====================

extension NotificationTypeX on String {
  NotificationType? get toNotificationType {
    try {
      return NotificationType.values.firstWhere(
        (e) => e.name == replaceAll('_', '').toLowerCase() ||
            e.toString().split('.').last == this,
      );
    } catch (_) {
      return null;
    }
  }
}
