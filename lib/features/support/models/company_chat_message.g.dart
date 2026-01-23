// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyChatMessageImpl _$$CompanyChatMessageImplFromJson(
  Map<String, dynamic> json,
) => _$CompanyChatMessageImpl(
  id: json['id'] as String,
  companyId: json['companyId'] as String?,
  senderId: json['senderId'] as String?,
  senderType: $enumDecode(_$SenderTypeEnumMap, json['senderType']),
  senderName: json['senderName'] as String,
  message: json['message'] as String,
  isRead: json['isRead'] as bool? ?? false,
  readBy:
      (json['readBy'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$CompanyChatMessageImplToJson(
  _$CompanyChatMessageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'companyId': instance.companyId,
  'senderId': instance.senderId,
  'senderType': _$SenderTypeEnumMap[instance.senderType]!,
  'senderName': instance.senderName,
  'message': instance.message,
  'isRead': instance.isRead,
  'readBy': instance.readBy,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$SenderTypeEnumMap = {
  SenderType.companyAdmin: 'company_admin',
  SenderType.superAdmin: 'super_admin',
};
