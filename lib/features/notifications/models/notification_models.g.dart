// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyNotificationImpl _$$CompanyNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$CompanyNotificationImpl(
  id: json['id'] as String,
  companyId: json['companyId'] as String,
  globalOrderId: json['globalOrderId'] as String?,
  type: json['type'] as String,
  title: json['title'] as String,
  message: json['message'] as String,
  data: json['data'] as Map<String, dynamic>?,
  isRead: json['isRead'] as bool,
  readAt:
      json['readAt'] == null ? null : DateTime.parse(json['readAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  globalOrder:
      json['globalOrder'] == null
          ? null
          : GlobalOrderBasic.fromJson(
            json['globalOrder'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$$CompanyNotificationImplToJson(
  _$CompanyNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'companyId': instance.companyId,
  'globalOrderId': instance.globalOrderId,
  'type': instance.type,
  'title': instance.title,
  'message': instance.message,
  'data': instance.data,
  'isRead': instance.isRead,
  'readAt': instance.readAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'globalOrder': instance.globalOrder,
};

_$AdminNotificationImpl _$$AdminNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$AdminNotificationImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  orderId: json['orderId'] as String?,
  type: json['type'] as String,
  title: json['title'] as String,
  message: json['message'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$AdminNotificationImplToJson(
  _$AdminNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'orderId': instance.orderId,
  'type': instance.type,
  'title': instance.title,
  'message': instance.message,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$UserNotificationImpl _$$UserNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$UserNotificationImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  type: json['type'] as String,
  title: json['title'] as String,
  message: json['message'] as String,
  data: json['data'] as Map<String, dynamic>?,
  isSeen: json['isSeen'] as bool,
  seenAt:
      json['seenAt'] == null ? null : DateTime.parse(json['seenAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$UserNotificationImplToJson(
  _$UserNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'type': instance.type,
  'title': instance.title,
  'message': instance.message,
  'data': instance.data,
  'isSeen': instance.isSeen,
  'seenAt': instance.seenAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$GlobalOrderBasicImpl _$$GlobalOrderBasicImplFromJson(
  Map<String, dynamic> json,
) => _$GlobalOrderBasicImpl(
  id: json['id'] as String,
  orderNumber: json['orderNumber'] as String?,
  containerType: json['containerType'] as String?,
  containerSize: json['containerSize'] as String?,
  deliveryLocation:
      json['deliveryLocation'] == null
          ? null
          : DeliveryLocation.fromJson(
            json['deliveryLocation'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$$GlobalOrderBasicImplToJson(
  _$GlobalOrderBasicImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'orderNumber': instance.orderNumber,
  'containerType': instance.containerType,
  'containerSize': instance.containerSize,
  'deliveryLocation': instance.deliveryLocation,
};

_$DeliveryLocationImpl _$$DeliveryLocationImplFromJson(
  Map<String, dynamic> json,
) => _$DeliveryLocationImpl(
  address: json['address'] as String,
  cityName: json['cityName'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$$DeliveryLocationImplToJson(
  _$DeliveryLocationImpl instance,
) => <String, dynamic>{
  'address': instance.address,
  'cityName': instance.cityName,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};

_$NotificationsResponseImpl _$$NotificationsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationsResponseImpl(
  success: json['success'] as bool,
  notifications:
      (json['notifications'] as List<dynamic>)
          .map((e) => CompanyNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
  unreadCount: (json['unreadCount'] as num).toInt(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$$NotificationsResponseImplToJson(
  _$NotificationsResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'notifications': instance.notifications,
  'unreadCount': instance.unreadCount,
  'total': instance.total,
};

_$UnreadCountResponseImpl _$$UnreadCountResponseImplFromJson(
  Map<String, dynamic> json,
) => _$UnreadCountResponseImpl(
  success: json['success'] as bool,
  unreadCount: (json['unreadCount'] as num).toInt(),
);

Map<String, dynamic> _$$UnreadCountResponseImplToJson(
  _$UnreadCountResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'unreadCount': instance.unreadCount,
};

_$AdminNotificationsResponseImpl _$$AdminNotificationsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$AdminNotificationsResponseImpl(
  message: json['message'] as String,
  totalNotifications: (json['totalNotifications'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  currentPage: (json['currentPage'] as num).toInt(),
  notifications:
      (json['notifications'] as List<dynamic>)
          .map((e) => AdminNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$AdminNotificationsResponseImplToJson(
  _$AdminNotificationsResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'totalNotifications': instance.totalNotifications,
  'totalPages': instance.totalPages,
  'currentPage': instance.currentPage,
  'notifications': instance.notifications,
};

_$UserNotificationsResponseImpl _$$UserNotificationsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$UserNotificationsResponseImpl(
  notifications:
      (json['notifications'] as List<dynamic>)
          .map((e) => UserNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
);

Map<String, dynamic> _$$UserNotificationsResponseImplToJson(
  _$UserNotificationsResponseImpl instance,
) => <String, dynamic>{
  'notifications': instance.notifications,
  'totalCount': instance.totalCount,
};
