// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessagesResponseImpl _$$ChatMessagesResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ChatMessagesResponseImpl(
  success: json['success'] as bool,
  data: ChatMessagesData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ChatMessagesResponseImplToJson(
  _$ChatMessagesResponseImpl instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

_$ChatMessagesDataImpl _$$ChatMessagesDataImplFromJson(
  Map<String, dynamic> json,
) => _$ChatMessagesDataImpl(
  messages:
      (json['messages'] as List<dynamic>)
          .map((e) => CompanyChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
  pagination: ChatPagination.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$ChatMessagesDataImplToJson(
  _$ChatMessagesDataImpl instance,
) => <String, dynamic>{
  'messages': instance.messages,
  'pagination': instance.pagination,
};

_$ChatPaginationImpl _$$ChatPaginationImplFromJson(Map<String, dynamic> json) =>
    _$ChatPaginationImpl(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$$ChatPaginationImplToJson(
  _$ChatPaginationImpl instance,
) => <String, dynamic>{
  'total': instance.total,
  'page': instance.page,
  'limit': instance.limit,
  'totalPages': instance.totalPages,
};

_$UnreadCountResponseImpl _$$UnreadCountResponseImplFromJson(
  Map<String, dynamic> json,
) => _$UnreadCountResponseImpl(
  success: json['success'] as bool,
  data: UnreadCountData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$UnreadCountResponseImplToJson(
  _$UnreadCountResponseImpl instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

_$UnreadCountDataImpl _$$UnreadCountDataImplFromJson(
  Map<String, dynamic> json,
) => _$UnreadCountDataImpl(unreadCount: (json['unreadCount'] as num).toInt());

Map<String, dynamic> _$$UnreadCountDataImplToJson(
  _$UnreadCountDataImpl instance,
) => <String, dynamic>{'unreadCount': instance.unreadCount};

_$SendMessageResponseImpl _$$SendMessageResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SendMessageResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: CompanyChatMessage.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$SendMessageResponseImplToJson(
  _$SendMessageResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_$ChatSuccessResponseImpl _$$ChatSuccessResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ChatSuccessResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String,
);

Map<String, dynamic> _$$ChatSuccessResponseImplToJson(
  _$ChatSuccessResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};
