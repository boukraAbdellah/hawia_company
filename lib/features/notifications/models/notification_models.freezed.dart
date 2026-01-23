// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CompanyNotification _$CompanyNotificationFromJson(Map<String, dynamic> json) {
  return _CompanyNotification.fromJson(json);
}

/// @nodoc
mixin _$CompanyNotification {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String? get globalOrderId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  GlobalOrderBasic? get globalOrder => throw _privateConstructorUsedError;

  /// Serializes this CompanyNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompanyNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompanyNotificationCopyWith<CompanyNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyNotificationCopyWith<$Res> {
  factory $CompanyNotificationCopyWith(
    CompanyNotification value,
    $Res Function(CompanyNotification) then,
  ) = _$CompanyNotificationCopyWithImpl<$Res, CompanyNotification>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String? globalOrderId,
    String type,
    String title,
    String message,
    Map<String, dynamic>? data,
    bool isRead,
    DateTime? readAt,
    DateTime createdAt,
    DateTime updatedAt,
    GlobalOrderBasic? globalOrder,
  });

  $GlobalOrderBasicCopyWith<$Res>? get globalOrder;
}

/// @nodoc
class _$CompanyNotificationCopyWithImpl<$Res, $Val extends CompanyNotification>
    implements $CompanyNotificationCopyWith<$Res> {
  _$CompanyNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompanyNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? globalOrderId = freezed,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? data = freezed,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? globalOrder = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            companyId:
                null == companyId
                    ? _value.companyId
                    : companyId // ignore: cast_nullable_to_non_nullable
                        as String,
            globalOrderId:
                freezed == globalOrderId
                    ? _value.globalOrderId
                    : globalOrderId // ignore: cast_nullable_to_non_nullable
                        as String?,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            data:
                freezed == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
            isRead:
                null == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool,
            readAt:
                freezed == readAt
                    ? _value.readAt
                    : readAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                null == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            globalOrder:
                freezed == globalOrder
                    ? _value.globalOrder
                    : globalOrder // ignore: cast_nullable_to_non_nullable
                        as GlobalOrderBasic?,
          )
          as $Val,
    );
  }

  /// Create a copy of CompanyNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GlobalOrderBasicCopyWith<$Res>? get globalOrder {
    if (_value.globalOrder == null) {
      return null;
    }

    return $GlobalOrderBasicCopyWith<$Res>(_value.globalOrder!, (value) {
      return _then(_value.copyWith(globalOrder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CompanyNotificationImplCopyWith<$Res>
    implements $CompanyNotificationCopyWith<$Res> {
  factory _$$CompanyNotificationImplCopyWith(
    _$CompanyNotificationImpl value,
    $Res Function(_$CompanyNotificationImpl) then,
  ) = __$$CompanyNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String? globalOrderId,
    String type,
    String title,
    String message,
    Map<String, dynamic>? data,
    bool isRead,
    DateTime? readAt,
    DateTime createdAt,
    DateTime updatedAt,
    GlobalOrderBasic? globalOrder,
  });

  @override
  $GlobalOrderBasicCopyWith<$Res>? get globalOrder;
}

/// @nodoc
class __$$CompanyNotificationImplCopyWithImpl<$Res>
    extends _$CompanyNotificationCopyWithImpl<$Res, _$CompanyNotificationImpl>
    implements _$$CompanyNotificationImplCopyWith<$Res> {
  __$$CompanyNotificationImplCopyWithImpl(
    _$CompanyNotificationImpl _value,
    $Res Function(_$CompanyNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompanyNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? globalOrderId = freezed,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? data = freezed,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? globalOrder = freezed,
  }) {
    return _then(
      _$CompanyNotificationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        companyId:
            null == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                    as String,
        globalOrderId:
            freezed == globalOrderId
                ? _value.globalOrderId
                : globalOrderId // ignore: cast_nullable_to_non_nullable
                    as String?,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        data:
            freezed == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
        isRead:
            null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool,
        readAt:
            freezed == readAt
                ? _value.readAt
                : readAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        globalOrder:
            freezed == globalOrder
                ? _value.globalOrder
                : globalOrder // ignore: cast_nullable_to_non_nullable
                    as GlobalOrderBasic?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyNotificationImpl extends _CompanyNotification {
  const _$CompanyNotificationImpl({
    required this.id,
    required this.companyId,
    this.globalOrderId,
    required this.type,
    required this.title,
    required this.message,
    final Map<String, dynamic>? data,
    required this.isRead,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
    this.globalOrder,
  }) : _data = data,
       super._();

  factory _$CompanyNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyNotificationImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String? globalOrderId;
  @override
  final String type;
  @override
  final String title;
  @override
  final String message;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool isRead;
  @override
  final DateTime? readAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final GlobalOrderBasic? globalOrder;

  @override
  String toString() {
    return 'CompanyNotification(id: $id, companyId: $companyId, globalOrderId: $globalOrderId, type: $type, title: $title, message: $message, data: $data, isRead: $isRead, readAt: $readAt, createdAt: $createdAt, updatedAt: $updatedAt, globalOrder: $globalOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.globalOrderId, globalOrderId) ||
                other.globalOrderId == globalOrderId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.globalOrder, globalOrder) ||
                other.globalOrder == globalOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    companyId,
    globalOrderId,
    type,
    title,
    message,
    const DeepCollectionEquality().hash(_data),
    isRead,
    readAt,
    createdAt,
    updatedAt,
    globalOrder,
  );

  /// Create a copy of CompanyNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyNotificationImplCopyWith<_$CompanyNotificationImpl> get copyWith =>
      __$$CompanyNotificationImplCopyWithImpl<_$CompanyNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyNotificationImplToJson(this);
  }
}

abstract class _CompanyNotification extends CompanyNotification {
  const factory _CompanyNotification({
    required final String id,
    required final String companyId,
    final String? globalOrderId,
    required final String type,
    required final String title,
    required final String message,
    final Map<String, dynamic>? data,
    required final bool isRead,
    final DateTime? readAt,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final GlobalOrderBasic? globalOrder,
  }) = _$CompanyNotificationImpl;
  const _CompanyNotification._() : super._();

  factory _CompanyNotification.fromJson(Map<String, dynamic> json) =
      _$CompanyNotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String? get globalOrderId;
  @override
  String get type;
  @override
  String get title;
  @override
  String get message;
  @override
  Map<String, dynamic>? get data;
  @override
  bool get isRead;
  @override
  DateTime? get readAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  GlobalOrderBasic? get globalOrder;

  /// Create a copy of CompanyNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompanyNotificationImplCopyWith<_$CompanyNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdminNotification _$AdminNotificationFromJson(Map<String, dynamic> json) {
  return _AdminNotification.fromJson(json);
}

/// @nodoc
mixin _$AdminNotification {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get orderId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AdminNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminNotificationCopyWith<AdminNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminNotificationCopyWith<$Res> {
  factory $AdminNotificationCopyWith(
    AdminNotification value,
    $Res Function(AdminNotification) then,
  ) = _$AdminNotificationCopyWithImpl<$Res, AdminNotification>;
  @useResult
  $Res call({
    String id,
    String userId,
    String? orderId,
    String type,
    String title,
    String message,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$AdminNotificationCopyWithImpl<$Res, $Val extends AdminNotification>
    implements $AdminNotificationCopyWith<$Res> {
  _$AdminNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? orderId = freezed,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            orderId:
                freezed == orderId
                    ? _value.orderId
                    : orderId // ignore: cast_nullable_to_non_nullable
                        as String?,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                null == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminNotificationImplCopyWith<$Res>
    implements $AdminNotificationCopyWith<$Res> {
  factory _$$AdminNotificationImplCopyWith(
    _$AdminNotificationImpl value,
    $Res Function(_$AdminNotificationImpl) then,
  ) = __$$AdminNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String? orderId,
    String type,
    String title,
    String message,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$AdminNotificationImplCopyWithImpl<$Res>
    extends _$AdminNotificationCopyWithImpl<$Res, _$AdminNotificationImpl>
    implements _$$AdminNotificationImplCopyWith<$Res> {
  __$$AdminNotificationImplCopyWithImpl(
    _$AdminNotificationImpl _value,
    $Res Function(_$AdminNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? orderId = freezed,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AdminNotificationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        orderId:
            freezed == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as String?,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminNotificationImpl extends _AdminNotification {
  const _$AdminNotificationImpl({
    required this.id,
    required this.userId,
    this.orderId,
    required this.type,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  factory _$AdminNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminNotificationImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String? orderId;
  @override
  final String type;
  @override
  final String title;
  @override
  final String message;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'AdminNotification(id: $id, userId: $userId, orderId: $orderId, type: $type, title: $title, message: $message, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    orderId,
    type,
    title,
    message,
    createdAt,
    updatedAt,
  );

  /// Create a copy of AdminNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminNotificationImplCopyWith<_$AdminNotificationImpl> get copyWith =>
      __$$AdminNotificationImplCopyWithImpl<_$AdminNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminNotificationImplToJson(this);
  }
}

abstract class _AdminNotification extends AdminNotification {
  const factory _AdminNotification({
    required final String id,
    required final String userId,
    final String? orderId,
    required final String type,
    required final String title,
    required final String message,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$AdminNotificationImpl;
  const _AdminNotification._() : super._();

  factory _AdminNotification.fromJson(Map<String, dynamic> json) =
      _$AdminNotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String? get orderId;
  @override
  String get type;
  @override
  String get title;
  @override
  String get message;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of AdminNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminNotificationImplCopyWith<_$AdminNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) {
  return _UserNotification.fromJson(json);
}

/// @nodoc
mixin _$UserNotification {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  bool get isSeen => throw _privateConstructorUsedError;
  DateTime? get seenAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserNotificationCopyWith<UserNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNotificationCopyWith<$Res> {
  factory $UserNotificationCopyWith(
    UserNotification value,
    $Res Function(UserNotification) then,
  ) = _$UserNotificationCopyWithImpl<$Res, UserNotification>;
  @useResult
  $Res call({
    String id,
    String userId,
    String type,
    String title,
    String message,
    Map<String, dynamic>? data,
    bool isSeen,
    DateTime? seenAt,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$UserNotificationCopyWithImpl<$Res, $Val extends UserNotification>
    implements $UserNotificationCopyWith<$Res> {
  _$UserNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? data = freezed,
    Object? isSeen = null,
    Object? seenAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            data:
                freezed == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
            isSeen:
                null == isSeen
                    ? _value.isSeen
                    : isSeen // ignore: cast_nullable_to_non_nullable
                        as bool,
            seenAt:
                freezed == seenAt
                    ? _value.seenAt
                    : seenAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                null == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserNotificationImplCopyWith<$Res>
    implements $UserNotificationCopyWith<$Res> {
  factory _$$UserNotificationImplCopyWith(
    _$UserNotificationImpl value,
    $Res Function(_$UserNotificationImpl) then,
  ) = __$$UserNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String type,
    String title,
    String message,
    Map<String, dynamic>? data,
    bool isSeen,
    DateTime? seenAt,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserNotificationImplCopyWithImpl<$Res>
    extends _$UserNotificationCopyWithImpl<$Res, _$UserNotificationImpl>
    implements _$$UserNotificationImplCopyWith<$Res> {
  __$$UserNotificationImplCopyWithImpl(
    _$UserNotificationImpl _value,
    $Res Function(_$UserNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? data = freezed,
    Object? isSeen = null,
    Object? seenAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserNotificationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        data:
            freezed == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
        isSeen:
            null == isSeen
                ? _value.isSeen
                : isSeen // ignore: cast_nullable_to_non_nullable
                    as bool,
        seenAt:
            freezed == seenAt
                ? _value.seenAt
                : seenAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserNotificationImpl implements _UserNotification {
  const _$UserNotificationImpl({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.message,
    final Map<String, dynamic>? data,
    required this.isSeen,
    this.seenAt,
    required this.createdAt,
    required this.updatedAt,
  }) : _data = data;

  factory _$UserNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserNotificationImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String type;
  @override
  final String title;
  @override
  final String message;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool isSeen;
  @override
  final DateTime? seenAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserNotification(id: $id, userId: $userId, type: $type, title: $title, message: $message, data: $data, isSeen: $isSeen, seenAt: $seenAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.isSeen, isSeen) || other.isSeen == isSeen) &&
            (identical(other.seenAt, seenAt) || other.seenAt == seenAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    type,
    title,
    message,
    const DeepCollectionEquality().hash(_data),
    isSeen,
    seenAt,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UserNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserNotificationImplCopyWith<_$UserNotificationImpl> get copyWith =>
      __$$UserNotificationImplCopyWithImpl<_$UserNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserNotificationImplToJson(this);
  }
}

abstract class _UserNotification implements UserNotification {
  const factory _UserNotification({
    required final String id,
    required final String userId,
    required final String type,
    required final String title,
    required final String message,
    final Map<String, dynamic>? data,
    required final bool isSeen,
    final DateTime? seenAt,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$UserNotificationImpl;

  factory _UserNotification.fromJson(Map<String, dynamic> json) =
      _$UserNotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get type;
  @override
  String get title;
  @override
  String get message;
  @override
  Map<String, dynamic>? get data;
  @override
  bool get isSeen;
  @override
  DateTime? get seenAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of UserNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserNotificationImplCopyWith<_$UserNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GlobalOrderBasic _$GlobalOrderBasicFromJson(Map<String, dynamic> json) {
  return _GlobalOrderBasic.fromJson(json);
}

/// @nodoc
mixin _$GlobalOrderBasic {
  String get id => throw _privateConstructorUsedError;
  String? get orderNumber => throw _privateConstructorUsedError;
  String? get containerType => throw _privateConstructorUsedError;
  String? get containerSize => throw _privateConstructorUsedError;
  DeliveryLocation? get deliveryLocation => throw _privateConstructorUsedError;

  /// Serializes this GlobalOrderBasic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GlobalOrderBasic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GlobalOrderBasicCopyWith<GlobalOrderBasic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GlobalOrderBasicCopyWith<$Res> {
  factory $GlobalOrderBasicCopyWith(
    GlobalOrderBasic value,
    $Res Function(GlobalOrderBasic) then,
  ) = _$GlobalOrderBasicCopyWithImpl<$Res, GlobalOrderBasic>;
  @useResult
  $Res call({
    String id,
    String? orderNumber,
    String? containerType,
    String? containerSize,
    DeliveryLocation? deliveryLocation,
  });

  $DeliveryLocationCopyWith<$Res>? get deliveryLocation;
}

/// @nodoc
class _$GlobalOrderBasicCopyWithImpl<$Res, $Val extends GlobalOrderBasic>
    implements $GlobalOrderBasicCopyWith<$Res> {
  _$GlobalOrderBasicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GlobalOrderBasic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = freezed,
    Object? containerType = freezed,
    Object? containerSize = freezed,
    Object? deliveryLocation = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            orderNumber:
                freezed == orderNumber
                    ? _value.orderNumber
                    : orderNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            containerType:
                freezed == containerType
                    ? _value.containerType
                    : containerType // ignore: cast_nullable_to_non_nullable
                        as String?,
            containerSize:
                freezed == containerSize
                    ? _value.containerSize
                    : containerSize // ignore: cast_nullable_to_non_nullable
                        as String?,
            deliveryLocation:
                freezed == deliveryLocation
                    ? _value.deliveryLocation
                    : deliveryLocation // ignore: cast_nullable_to_non_nullable
                        as DeliveryLocation?,
          )
          as $Val,
    );
  }

  /// Create a copy of GlobalOrderBasic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeliveryLocationCopyWith<$Res>? get deliveryLocation {
    if (_value.deliveryLocation == null) {
      return null;
    }

    return $DeliveryLocationCopyWith<$Res>(_value.deliveryLocation!, (value) {
      return _then(_value.copyWith(deliveryLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GlobalOrderBasicImplCopyWith<$Res>
    implements $GlobalOrderBasicCopyWith<$Res> {
  factory _$$GlobalOrderBasicImplCopyWith(
    _$GlobalOrderBasicImpl value,
    $Res Function(_$GlobalOrderBasicImpl) then,
  ) = __$$GlobalOrderBasicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? orderNumber,
    String? containerType,
    String? containerSize,
    DeliveryLocation? deliveryLocation,
  });

  @override
  $DeliveryLocationCopyWith<$Res>? get deliveryLocation;
}

/// @nodoc
class __$$GlobalOrderBasicImplCopyWithImpl<$Res>
    extends _$GlobalOrderBasicCopyWithImpl<$Res, _$GlobalOrderBasicImpl>
    implements _$$GlobalOrderBasicImplCopyWith<$Res> {
  __$$GlobalOrderBasicImplCopyWithImpl(
    _$GlobalOrderBasicImpl _value,
    $Res Function(_$GlobalOrderBasicImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GlobalOrderBasic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = freezed,
    Object? containerType = freezed,
    Object? containerSize = freezed,
    Object? deliveryLocation = freezed,
  }) {
    return _then(
      _$GlobalOrderBasicImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        orderNumber:
            freezed == orderNumber
                ? _value.orderNumber
                : orderNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        containerType:
            freezed == containerType
                ? _value.containerType
                : containerType // ignore: cast_nullable_to_non_nullable
                    as String?,
        containerSize:
            freezed == containerSize
                ? _value.containerSize
                : containerSize // ignore: cast_nullable_to_non_nullable
                    as String?,
        deliveryLocation:
            freezed == deliveryLocation
                ? _value.deliveryLocation
                : deliveryLocation // ignore: cast_nullable_to_non_nullable
                    as DeliveryLocation?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GlobalOrderBasicImpl implements _GlobalOrderBasic {
  const _$GlobalOrderBasicImpl({
    required this.id,
    this.orderNumber,
    this.containerType,
    this.containerSize,
    this.deliveryLocation,
  });

  factory _$GlobalOrderBasicImpl.fromJson(Map<String, dynamic> json) =>
      _$$GlobalOrderBasicImplFromJson(json);

  @override
  final String id;
  @override
  final String? orderNumber;
  @override
  final String? containerType;
  @override
  final String? containerSize;
  @override
  final DeliveryLocation? deliveryLocation;

  @override
  String toString() {
    return 'GlobalOrderBasic(id: $id, orderNumber: $orderNumber, containerType: $containerType, containerSize: $containerSize, deliveryLocation: $deliveryLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GlobalOrderBasicImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.containerType, containerType) ||
                other.containerType == containerType) &&
            (identical(other.containerSize, containerSize) ||
                other.containerSize == containerSize) &&
            (identical(other.deliveryLocation, deliveryLocation) ||
                other.deliveryLocation == deliveryLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    orderNumber,
    containerType,
    containerSize,
    deliveryLocation,
  );

  /// Create a copy of GlobalOrderBasic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GlobalOrderBasicImplCopyWith<_$GlobalOrderBasicImpl> get copyWith =>
      __$$GlobalOrderBasicImplCopyWithImpl<_$GlobalOrderBasicImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GlobalOrderBasicImplToJson(this);
  }
}

abstract class _GlobalOrderBasic implements GlobalOrderBasic {
  const factory _GlobalOrderBasic({
    required final String id,
    final String? orderNumber,
    final String? containerType,
    final String? containerSize,
    final DeliveryLocation? deliveryLocation,
  }) = _$GlobalOrderBasicImpl;

  factory _GlobalOrderBasic.fromJson(Map<String, dynamic> json) =
      _$GlobalOrderBasicImpl.fromJson;

  @override
  String get id;
  @override
  String? get orderNumber;
  @override
  String? get containerType;
  @override
  String? get containerSize;
  @override
  DeliveryLocation? get deliveryLocation;

  /// Create a copy of GlobalOrderBasic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GlobalOrderBasicImplCopyWith<_$GlobalOrderBasicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeliveryLocation _$DeliveryLocationFromJson(Map<String, dynamic> json) {
  return _DeliveryLocation.fromJson(json);
}

/// @nodoc
mixin _$DeliveryLocation {
  String get address => throw _privateConstructorUsedError;
  String? get cityName => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Serializes this DeliveryLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeliveryLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliveryLocationCopyWith<DeliveryLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryLocationCopyWith<$Res> {
  factory $DeliveryLocationCopyWith(
    DeliveryLocation value,
    $Res Function(DeliveryLocation) then,
  ) = _$DeliveryLocationCopyWithImpl<$Res, DeliveryLocation>;
  @useResult
  $Res call({
    String address,
    String? cityName,
    double latitude,
    double longitude,
  });
}

/// @nodoc
class _$DeliveryLocationCopyWithImpl<$Res, $Val extends DeliveryLocation>
    implements $DeliveryLocationCopyWith<$Res> {
  _$DeliveryLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliveryLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? cityName = freezed,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(
      _value.copyWith(
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            cityName:
                freezed == cityName
                    ? _value.cityName
                    : cityName // ignore: cast_nullable_to_non_nullable
                        as String?,
            latitude:
                null == latitude
                    ? _value.latitude
                    : latitude // ignore: cast_nullable_to_non_nullable
                        as double,
            longitude:
                null == longitude
                    ? _value.longitude
                    : longitude // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeliveryLocationImplCopyWith<$Res>
    implements $DeliveryLocationCopyWith<$Res> {
  factory _$$DeliveryLocationImplCopyWith(
    _$DeliveryLocationImpl value,
    $Res Function(_$DeliveryLocationImpl) then,
  ) = __$$DeliveryLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String address,
    String? cityName,
    double latitude,
    double longitude,
  });
}

/// @nodoc
class __$$DeliveryLocationImplCopyWithImpl<$Res>
    extends _$DeliveryLocationCopyWithImpl<$Res, _$DeliveryLocationImpl>
    implements _$$DeliveryLocationImplCopyWith<$Res> {
  __$$DeliveryLocationImplCopyWithImpl(
    _$DeliveryLocationImpl _value,
    $Res Function(_$DeliveryLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeliveryLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? cityName = freezed,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(
      _$DeliveryLocationImpl(
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        cityName:
            freezed == cityName
                ? _value.cityName
                : cityName // ignore: cast_nullable_to_non_nullable
                    as String?,
        latitude:
            null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                    as double,
        longitude:
            null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliveryLocationImpl implements _DeliveryLocation {
  const _$DeliveryLocationImpl({
    required this.address,
    this.cityName,
    required this.latitude,
    required this.longitude,
  });

  factory _$DeliveryLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryLocationImplFromJson(json);

  @override
  final String address;
  @override
  final String? cityName;
  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'DeliveryLocation(address: $address, cityName: $cityName, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryLocationImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, cityName, latitude, longitude);

  /// Create a copy of DeliveryLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryLocationImplCopyWith<_$DeliveryLocationImpl> get copyWith =>
      __$$DeliveryLocationImplCopyWithImpl<_$DeliveryLocationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryLocationImplToJson(this);
  }
}

abstract class _DeliveryLocation implements DeliveryLocation {
  const factory _DeliveryLocation({
    required final String address,
    final String? cityName,
    required final double latitude,
    required final double longitude,
  }) = _$DeliveryLocationImpl;

  factory _DeliveryLocation.fromJson(Map<String, dynamic> json) =
      _$DeliveryLocationImpl.fromJson;

  @override
  String get address;
  @override
  String? get cityName;
  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of DeliveryLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryLocationImplCopyWith<_$DeliveryLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationsResponse _$NotificationsResponseFromJson(
  Map<String, dynamic> json,
) {
  return _NotificationsResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationsResponse {
  bool get success => throw _privateConstructorUsedError;
  List<CompanyNotification> get notifications =>
      throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this NotificationsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationsResponseCopyWith<NotificationsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsResponseCopyWith<$Res> {
  factory $NotificationsResponseCopyWith(
    NotificationsResponse value,
    $Res Function(NotificationsResponse) then,
  ) = _$NotificationsResponseCopyWithImpl<$Res, NotificationsResponse>;
  @useResult
  $Res call({
    bool success,
    List<CompanyNotification> notifications,
    int unreadCount,
    int total,
  });
}

/// @nodoc
class _$NotificationsResponseCopyWithImpl<
  $Res,
  $Val extends NotificationsResponse
>
    implements $NotificationsResponseCopyWith<$Res> {
  _$NotificationsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? notifications = null,
    Object? unreadCount = null,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            notifications:
                null == notifications
                    ? _value.notifications
                    : notifications // ignore: cast_nullable_to_non_nullable
                        as List<CompanyNotification>,
            unreadCount:
                null == unreadCount
                    ? _value.unreadCount
                    : unreadCount // ignore: cast_nullable_to_non_nullable
                        as int,
            total:
                null == total
                    ? _value.total
                    : total // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationsResponseImplCopyWith<$Res>
    implements $NotificationsResponseCopyWith<$Res> {
  factory _$$NotificationsResponseImplCopyWith(
    _$NotificationsResponseImpl value,
    $Res Function(_$NotificationsResponseImpl) then,
  ) = __$$NotificationsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    List<CompanyNotification> notifications,
    int unreadCount,
    int total,
  });
}

/// @nodoc
class __$$NotificationsResponseImplCopyWithImpl<$Res>
    extends
        _$NotificationsResponseCopyWithImpl<$Res, _$NotificationsResponseImpl>
    implements _$$NotificationsResponseImplCopyWith<$Res> {
  __$$NotificationsResponseImplCopyWithImpl(
    _$NotificationsResponseImpl _value,
    $Res Function(_$NotificationsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? notifications = null,
    Object? unreadCount = null,
    Object? total = null,
  }) {
    return _then(
      _$NotificationsResponseImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        notifications:
            null == notifications
                ? _value._notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                    as List<CompanyNotification>,
        unreadCount:
            null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                    as int,
        total:
            null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationsResponseImpl implements _NotificationsResponse {
  const _$NotificationsResponseImpl({
    required this.success,
    required final List<CompanyNotification> notifications,
    required this.unreadCount,
    required this.total,
  }) : _notifications = notifications;

  factory _$NotificationsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationsResponseImplFromJson(json);

  @override
  final bool success;
  final List<CompanyNotification> _notifications;
  @override
  List<CompanyNotification> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  @override
  final int unreadCount;
  @override
  final int total;

  @override
  String toString() {
    return 'NotificationsResponse(success: $success, notifications: $notifications, unreadCount: $unreadCount, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(
              other._notifications,
              _notifications,
            ) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    const DeepCollectionEquality().hash(_notifications),
    unreadCount,
    total,
  );

  /// Create a copy of NotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsResponseImplCopyWith<_$NotificationsResponseImpl>
  get copyWith =>
      __$$NotificationsResponseImplCopyWithImpl<_$NotificationsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationsResponseImplToJson(this);
  }
}

abstract class _NotificationsResponse implements NotificationsResponse {
  const factory _NotificationsResponse({
    required final bool success,
    required final List<CompanyNotification> notifications,
    required final int unreadCount,
    required final int total,
  }) = _$NotificationsResponseImpl;

  factory _NotificationsResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationsResponseImpl.fromJson;

  @override
  bool get success;
  @override
  List<CompanyNotification> get notifications;
  @override
  int get unreadCount;
  @override
  int get total;

  /// Create a copy of NotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationsResponseImplCopyWith<_$NotificationsResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UnreadCountResponse _$UnreadCountResponseFromJson(Map<String, dynamic> json) {
  return _UnreadCountResponse.fromJson(json);
}

/// @nodoc
mixin _$UnreadCountResponse {
  bool get success => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;

  /// Serializes this UnreadCountResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UnreadCountResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnreadCountResponseCopyWith<UnreadCountResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnreadCountResponseCopyWith<$Res> {
  factory $UnreadCountResponseCopyWith(
    UnreadCountResponse value,
    $Res Function(UnreadCountResponse) then,
  ) = _$UnreadCountResponseCopyWithImpl<$Res, UnreadCountResponse>;
  @useResult
  $Res call({bool success, int unreadCount});
}

/// @nodoc
class _$UnreadCountResponseCopyWithImpl<$Res, $Val extends UnreadCountResponse>
    implements $UnreadCountResponseCopyWith<$Res> {
  _$UnreadCountResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnreadCountResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? unreadCount = null}) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            unreadCount:
                null == unreadCount
                    ? _value.unreadCount
                    : unreadCount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UnreadCountResponseImplCopyWith<$Res>
    implements $UnreadCountResponseCopyWith<$Res> {
  factory _$$UnreadCountResponseImplCopyWith(
    _$UnreadCountResponseImpl value,
    $Res Function(_$UnreadCountResponseImpl) then,
  ) = __$$UnreadCountResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, int unreadCount});
}

/// @nodoc
class __$$UnreadCountResponseImplCopyWithImpl<$Res>
    extends _$UnreadCountResponseCopyWithImpl<$Res, _$UnreadCountResponseImpl>
    implements _$$UnreadCountResponseImplCopyWith<$Res> {
  __$$UnreadCountResponseImplCopyWithImpl(
    _$UnreadCountResponseImpl _value,
    $Res Function(_$UnreadCountResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UnreadCountResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? unreadCount = null}) {
    return _then(
      _$UnreadCountResponseImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        unreadCount:
            null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UnreadCountResponseImpl implements _UnreadCountResponse {
  const _$UnreadCountResponseImpl({
    required this.success,
    required this.unreadCount,
  });

  factory _$UnreadCountResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnreadCountResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final int unreadCount;

  @override
  String toString() {
    return 'UnreadCountResponse(success: $success, unreadCount: $unreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnreadCountResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, unreadCount);

  /// Create a copy of UnreadCountResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnreadCountResponseImplCopyWith<_$UnreadCountResponseImpl> get copyWith =>
      __$$UnreadCountResponseImplCopyWithImpl<_$UnreadCountResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UnreadCountResponseImplToJson(this);
  }
}

abstract class _UnreadCountResponse implements UnreadCountResponse {
  const factory _UnreadCountResponse({
    required final bool success,
    required final int unreadCount,
  }) = _$UnreadCountResponseImpl;

  factory _UnreadCountResponse.fromJson(Map<String, dynamic> json) =
      _$UnreadCountResponseImpl.fromJson;

  @override
  bool get success;
  @override
  int get unreadCount;

  /// Create a copy of UnreadCountResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnreadCountResponseImplCopyWith<_$UnreadCountResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdminNotificationsResponse _$AdminNotificationsResponseFromJson(
  Map<String, dynamic> json,
) {
  return _AdminNotificationsResponse.fromJson(json);
}

/// @nodoc
mixin _$AdminNotificationsResponse {
  String get message => throw _privateConstructorUsedError;
  int get totalNotifications => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  List<AdminNotification> get notifications =>
      throw _privateConstructorUsedError;

  /// Serializes this AdminNotificationsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminNotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminNotificationsResponseCopyWith<AdminNotificationsResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminNotificationsResponseCopyWith<$Res> {
  factory $AdminNotificationsResponseCopyWith(
    AdminNotificationsResponse value,
    $Res Function(AdminNotificationsResponse) then,
  ) =
      _$AdminNotificationsResponseCopyWithImpl<
        $Res,
        AdminNotificationsResponse
      >;
  @useResult
  $Res call({
    String message,
    int totalNotifications,
    int totalPages,
    int currentPage,
    List<AdminNotification> notifications,
  });
}

/// @nodoc
class _$AdminNotificationsResponseCopyWithImpl<
  $Res,
  $Val extends AdminNotificationsResponse
>
    implements $AdminNotificationsResponseCopyWith<$Res> {
  _$AdminNotificationsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminNotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? totalNotifications = null,
    Object? totalPages = null,
    Object? currentPage = null,
    Object? notifications = null,
  }) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            totalNotifications:
                null == totalNotifications
                    ? _value.totalNotifications
                    : totalNotifications // ignore: cast_nullable_to_non_nullable
                        as int,
            totalPages:
                null == totalPages
                    ? _value.totalPages
                    : totalPages // ignore: cast_nullable_to_non_nullable
                        as int,
            currentPage:
                null == currentPage
                    ? _value.currentPage
                    : currentPage // ignore: cast_nullable_to_non_nullable
                        as int,
            notifications:
                null == notifications
                    ? _value.notifications
                    : notifications // ignore: cast_nullable_to_non_nullable
                        as List<AdminNotification>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminNotificationsResponseImplCopyWith<$Res>
    implements $AdminNotificationsResponseCopyWith<$Res> {
  factory _$$AdminNotificationsResponseImplCopyWith(
    _$AdminNotificationsResponseImpl value,
    $Res Function(_$AdminNotificationsResponseImpl) then,
  ) = __$$AdminNotificationsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    int totalNotifications,
    int totalPages,
    int currentPage,
    List<AdminNotification> notifications,
  });
}

/// @nodoc
class __$$AdminNotificationsResponseImplCopyWithImpl<$Res>
    extends
        _$AdminNotificationsResponseCopyWithImpl<
          $Res,
          _$AdminNotificationsResponseImpl
        >
    implements _$$AdminNotificationsResponseImplCopyWith<$Res> {
  __$$AdminNotificationsResponseImplCopyWithImpl(
    _$AdminNotificationsResponseImpl _value,
    $Res Function(_$AdminNotificationsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminNotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? totalNotifications = null,
    Object? totalPages = null,
    Object? currentPage = null,
    Object? notifications = null,
  }) {
    return _then(
      _$AdminNotificationsResponseImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        totalNotifications:
            null == totalNotifications
                ? _value.totalNotifications
                : totalNotifications // ignore: cast_nullable_to_non_nullable
                    as int,
        totalPages:
            null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                    as int,
        currentPage:
            null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                    as int,
        notifications:
            null == notifications
                ? _value._notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                    as List<AdminNotification>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminNotificationsResponseImpl implements _AdminNotificationsResponse {
  const _$AdminNotificationsResponseImpl({
    required this.message,
    required this.totalNotifications,
    required this.totalPages,
    required this.currentPage,
    required final List<AdminNotification> notifications,
  }) : _notifications = notifications;

  factory _$AdminNotificationsResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AdminNotificationsResponseImplFromJson(json);

  @override
  final String message;
  @override
  final int totalNotifications;
  @override
  final int totalPages;
  @override
  final int currentPage;
  final List<AdminNotification> _notifications;
  @override
  List<AdminNotification> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  @override
  String toString() {
    return 'AdminNotificationsResponse(message: $message, totalNotifications: $totalNotifications, totalPages: $totalPages, currentPage: $currentPage, notifications: $notifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminNotificationsResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.totalNotifications, totalNotifications) ||
                other.totalNotifications == totalNotifications) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            const DeepCollectionEquality().equals(
              other._notifications,
              _notifications,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    totalNotifications,
    totalPages,
    currentPage,
    const DeepCollectionEquality().hash(_notifications),
  );

  /// Create a copy of AdminNotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminNotificationsResponseImplCopyWith<_$AdminNotificationsResponseImpl>
  get copyWith => __$$AdminNotificationsResponseImplCopyWithImpl<
    _$AdminNotificationsResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminNotificationsResponseImplToJson(this);
  }
}

abstract class _AdminNotificationsResponse
    implements AdminNotificationsResponse {
  const factory _AdminNotificationsResponse({
    required final String message,
    required final int totalNotifications,
    required final int totalPages,
    required final int currentPage,
    required final List<AdminNotification> notifications,
  }) = _$AdminNotificationsResponseImpl;

  factory _AdminNotificationsResponse.fromJson(Map<String, dynamic> json) =
      _$AdminNotificationsResponseImpl.fromJson;

  @override
  String get message;
  @override
  int get totalNotifications;
  @override
  int get totalPages;
  @override
  int get currentPage;
  @override
  List<AdminNotification> get notifications;

  /// Create a copy of AdminNotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminNotificationsResponseImplCopyWith<_$AdminNotificationsResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UserNotificationsResponse _$UserNotificationsResponseFromJson(
  Map<String, dynamic> json,
) {
  return _UserNotificationsResponse.fromJson(json);
}

/// @nodoc
mixin _$UserNotificationsResponse {
  List<UserNotification> get notifications =>
      throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;

  /// Serializes this UserNotificationsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserNotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserNotificationsResponseCopyWith<UserNotificationsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNotificationsResponseCopyWith<$Res> {
  factory $UserNotificationsResponseCopyWith(
    UserNotificationsResponse value,
    $Res Function(UserNotificationsResponse) then,
  ) = _$UserNotificationsResponseCopyWithImpl<$Res, UserNotificationsResponse>;
  @useResult
  $Res call({List<UserNotification> notifications, int totalCount});
}

/// @nodoc
class _$UserNotificationsResponseCopyWithImpl<
  $Res,
  $Val extends UserNotificationsResponse
>
    implements $UserNotificationsResponseCopyWith<$Res> {
  _$UserNotificationsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserNotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notifications = null, Object? totalCount = null}) {
    return _then(
      _value.copyWith(
            notifications:
                null == notifications
                    ? _value.notifications
                    : notifications // ignore: cast_nullable_to_non_nullable
                        as List<UserNotification>,
            totalCount:
                null == totalCount
                    ? _value.totalCount
                    : totalCount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserNotificationsResponseImplCopyWith<$Res>
    implements $UserNotificationsResponseCopyWith<$Res> {
  factory _$$UserNotificationsResponseImplCopyWith(
    _$UserNotificationsResponseImpl value,
    $Res Function(_$UserNotificationsResponseImpl) then,
  ) = __$$UserNotificationsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserNotification> notifications, int totalCount});
}

/// @nodoc
class __$$UserNotificationsResponseImplCopyWithImpl<$Res>
    extends
        _$UserNotificationsResponseCopyWithImpl<
          $Res,
          _$UserNotificationsResponseImpl
        >
    implements _$$UserNotificationsResponseImplCopyWith<$Res> {
  __$$UserNotificationsResponseImplCopyWithImpl(
    _$UserNotificationsResponseImpl _value,
    $Res Function(_$UserNotificationsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserNotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notifications = null, Object? totalCount = null}) {
    return _then(
      _$UserNotificationsResponseImpl(
        notifications:
            null == notifications
                ? _value._notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                    as List<UserNotification>,
        totalCount:
            null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserNotificationsResponseImpl implements _UserNotificationsResponse {
  const _$UserNotificationsResponseImpl({
    required final List<UserNotification> notifications,
    required this.totalCount,
  }) : _notifications = notifications;

  factory _$UserNotificationsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserNotificationsResponseImplFromJson(json);

  final List<UserNotification> _notifications;
  @override
  List<UserNotification> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  @override
  final int totalCount;

  @override
  String toString() {
    return 'UserNotificationsResponse(notifications: $notifications, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserNotificationsResponseImpl &&
            const DeepCollectionEquality().equals(
              other._notifications,
              _notifications,
            ) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_notifications),
    totalCount,
  );

  /// Create a copy of UserNotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserNotificationsResponseImplCopyWith<_$UserNotificationsResponseImpl>
  get copyWith => __$$UserNotificationsResponseImplCopyWithImpl<
    _$UserNotificationsResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserNotificationsResponseImplToJson(this);
  }
}

abstract class _UserNotificationsResponse implements UserNotificationsResponse {
  const factory _UserNotificationsResponse({
    required final List<UserNotification> notifications,
    required final int totalCount,
  }) = _$UserNotificationsResponseImpl;

  factory _UserNotificationsResponse.fromJson(Map<String, dynamic> json) =
      _$UserNotificationsResponseImpl.fromJson;

  @override
  List<UserNotification> get notifications;
  @override
  int get totalCount;

  /// Create a copy of UserNotificationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserNotificationsResponseImplCopyWith<_$UserNotificationsResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
