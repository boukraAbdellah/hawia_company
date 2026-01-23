// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyImpl _$$CompanyImplFromJson(Map<String, dynamic> json) =>
    _$CompanyImpl(
      name: json['name'] as String,
      domain: json['domain'] as String,
      logoUrl: json['logoUrl'] as String,
      status: json['status'] as String,
      level: (json['level'] as num).toInt(),
      plan: json['plan'] as String,
      commissionPercentage: json['commissionPercentage'] as String,
      companyPhoneNumber: json['companyPhoneNumber'] as String,
      cityName: json['cityName'] as String,
    );

Map<String, dynamic> _$$CompanyImplToJson(_$CompanyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'domain': instance.domain,
      'logoUrl': instance.logoUrl,
      'status': instance.status,
      'level': instance.level,
      'plan': instance.plan,
      'commissionPercentage': instance.commissionPercentage,
      'companyPhoneNumber': instance.companyPhoneNumber,
      'cityName': instance.cityName,
    };

_$AdminUserImpl _$$AdminUserImplFromJson(Map<String, dynamic> json) =>
    _$AdminUserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$$AdminUserImplToJson(_$AdminUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
    };

_$ProfileResponseImpl _$$ProfileResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileResponseImpl(
  success: json['success'] as bool,
  company: Company.fromJson(json['company'] as Map<String, dynamic>),
  adminUser: AdminUser.fromJson(json['adminUser'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ProfileResponseImplToJson(
  _$ProfileResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'company': instance.company,
  'adminUser': instance.adminUser,
};
