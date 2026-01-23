// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CompanyChatMessage _$CompanyChatMessageFromJson(Map<String, dynamic> json) {
  return _CompanyChatMessage.fromJson(json);
}

/// @nodoc
mixin _$CompanyChatMessage {
  /// Unique message ID (UUID)
  String get id => throw _privateConstructorUsedError;

  /// Company ID this message belongs to (UUID)
  String? get companyId => throw _privateConstructorUsedError;

  /// ID of the user who sent the message (UUID)
  String? get senderId => throw _privateConstructorUsedError;

  /// Type of sender: 'company_admin' or 'super_admin'
  SenderType get senderType => throw _privateConstructorUsedError;

  /// Display name of the sender
  String get senderName => throw _privateConstructorUsedError;

  /// Message content (text)
  String get message => throw _privateConstructorUsedError;

  /// Whether the message has been read
  bool get isRead => throw _privateConstructorUsedError;

  /// Array of user IDs who have read this message
  List<String> get readBy => throw _privateConstructorUsedError;

  /// When the message was created
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// When the message was last updated
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CompanyChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompanyChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompanyChatMessageCopyWith<CompanyChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyChatMessageCopyWith<$Res> {
  factory $CompanyChatMessageCopyWith(
    CompanyChatMessage value,
    $Res Function(CompanyChatMessage) then,
  ) = _$CompanyChatMessageCopyWithImpl<$Res, CompanyChatMessage>;
  @useResult
  $Res call({
    String id,
    String? companyId,
    String? senderId,
    SenderType senderType,
    String senderName,
    String message,
    bool isRead,
    List<String> readBy,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$CompanyChatMessageCopyWithImpl<$Res, $Val extends CompanyChatMessage>
    implements $CompanyChatMessageCopyWith<$Res> {
  _$CompanyChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompanyChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = freezed,
    Object? senderId = freezed,
    Object? senderType = null,
    Object? senderName = null,
    Object? message = null,
    Object? isRead = null,
    Object? readBy = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            companyId:
                freezed == companyId
                    ? _value.companyId
                    : companyId // ignore: cast_nullable_to_non_nullable
                        as String?,
            senderId:
                freezed == senderId
                    ? _value.senderId
                    : senderId // ignore: cast_nullable_to_non_nullable
                        as String?,
            senderType:
                null == senderType
                    ? _value.senderType
                    : senderType // ignore: cast_nullable_to_non_nullable
                        as SenderType,
            senderName:
                null == senderName
                    ? _value.senderName
                    : senderName // ignore: cast_nullable_to_non_nullable
                        as String,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            isRead:
                null == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool,
            readBy:
                null == readBy
                    ? _value.readBy
                    : readBy // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CompanyChatMessageImplCopyWith<$Res>
    implements $CompanyChatMessageCopyWith<$Res> {
  factory _$$CompanyChatMessageImplCopyWith(
    _$CompanyChatMessageImpl value,
    $Res Function(_$CompanyChatMessageImpl) then,
  ) = __$$CompanyChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? companyId,
    String? senderId,
    SenderType senderType,
    String senderName,
    String message,
    bool isRead,
    List<String> readBy,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$CompanyChatMessageImplCopyWithImpl<$Res>
    extends _$CompanyChatMessageCopyWithImpl<$Res, _$CompanyChatMessageImpl>
    implements _$$CompanyChatMessageImplCopyWith<$Res> {
  __$$CompanyChatMessageImplCopyWithImpl(
    _$CompanyChatMessageImpl _value,
    $Res Function(_$CompanyChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompanyChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = freezed,
    Object? senderId = freezed,
    Object? senderType = null,
    Object? senderName = null,
    Object? message = null,
    Object? isRead = null,
    Object? readBy = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$CompanyChatMessageImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        companyId:
            freezed == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                    as String?,
        senderId:
            freezed == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                    as String?,
        senderType:
            null == senderType
                ? _value.senderType
                : senderType // ignore: cast_nullable_to_non_nullable
                    as SenderType,
        senderName:
            null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                    as String,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        isRead:
            null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool,
        readBy:
            null == readBy
                ? _value._readBy
                : readBy // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyChatMessageImpl implements _CompanyChatMessage {
  const _$CompanyChatMessageImpl({
    required this.id,
    this.companyId,
    this.senderId,
    required this.senderType,
    required this.senderName,
    required this.message,
    this.isRead = false,
    final List<String> readBy = const [],
    required this.createdAt,
    this.updatedAt,
  }) : _readBy = readBy;

  factory _$CompanyChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyChatMessageImplFromJson(json);

  /// Unique message ID (UUID)
  @override
  final String id;

  /// Company ID this message belongs to (UUID)
  @override
  final String? companyId;

  /// ID of the user who sent the message (UUID)
  @override
  final String? senderId;

  /// Type of sender: 'company_admin' or 'super_admin'
  @override
  final SenderType senderType;

  /// Display name of the sender
  @override
  final String senderName;

  /// Message content (text)
  @override
  final String message;

  /// Whether the message has been read
  @override
  @JsonKey()
  final bool isRead;

  /// Array of user IDs who have read this message
  final List<String> _readBy;

  /// Array of user IDs who have read this message
  @override
  @JsonKey()
  List<String> get readBy {
    if (_readBy is EqualUnmodifiableListView) return _readBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readBy);
  }

  /// When the message was created
  @override
  final DateTime createdAt;

  /// When the message was last updated
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CompanyChatMessage(id: $id, companyId: $companyId, senderId: $senderId, senderType: $senderType, senderName: $senderName, message: $message, isRead: $isRead, readBy: $readBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderType, senderType) ||
                other.senderType == senderType) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            const DeepCollectionEquality().equals(other._readBy, _readBy) &&
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
    companyId,
    senderId,
    senderType,
    senderName,
    message,
    isRead,
    const DeepCollectionEquality().hash(_readBy),
    createdAt,
    updatedAt,
  );

  /// Create a copy of CompanyChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyChatMessageImplCopyWith<_$CompanyChatMessageImpl> get copyWith =>
      __$$CompanyChatMessageImplCopyWithImpl<_$CompanyChatMessageImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyChatMessageImplToJson(this);
  }
}

abstract class _CompanyChatMessage implements CompanyChatMessage {
  const factory _CompanyChatMessage({
    required final String id,
    final String? companyId,
    final String? senderId,
    required final SenderType senderType,
    required final String senderName,
    required final String message,
    final bool isRead,
    final List<String> readBy,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$CompanyChatMessageImpl;

  factory _CompanyChatMessage.fromJson(Map<String, dynamic> json) =
      _$CompanyChatMessageImpl.fromJson;

  /// Unique message ID (UUID)
  @override
  String get id;

  /// Company ID this message belongs to (UUID)
  @override
  String? get companyId;

  /// ID of the user who sent the message (UUID)
  @override
  String? get senderId;

  /// Type of sender: 'company_admin' or 'super_admin'
  @override
  SenderType get senderType;

  /// Display name of the sender
  @override
  String get senderName;

  /// Message content (text)
  @override
  String get message;

  /// Whether the message has been read
  @override
  bool get isRead;

  /// Array of user IDs who have read this message
  @override
  List<String> get readBy;

  /// When the message was created
  @override
  DateTime get createdAt;

  /// When the message was last updated
  @override
  DateTime? get updatedAt;

  /// Create a copy of CompanyChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompanyChatMessageImplCopyWith<_$CompanyChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
