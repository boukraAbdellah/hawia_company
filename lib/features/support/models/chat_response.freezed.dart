// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatMessagesResponse _$ChatMessagesResponseFromJson(Map<String, dynamic> json) {
  return _ChatMessagesResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatMessagesResponse {
  bool get success => throw _privateConstructorUsedError;
  ChatMessagesData get data => throw _privateConstructorUsedError;

  /// Serializes this ChatMessagesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessagesResponseCopyWith<ChatMessagesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessagesResponseCopyWith<$Res> {
  factory $ChatMessagesResponseCopyWith(
    ChatMessagesResponse value,
    $Res Function(ChatMessagesResponse) then,
  ) = _$ChatMessagesResponseCopyWithImpl<$Res, ChatMessagesResponse>;
  @useResult
  $Res call({bool success, ChatMessagesData data});

  $ChatMessagesDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ChatMessagesResponseCopyWithImpl<
  $Res,
  $Val extends ChatMessagesResponse
>
    implements $ChatMessagesResponseCopyWith<$Res> {
  _$ChatMessagesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? data = null}) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as ChatMessagesData,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatMessagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessagesDataCopyWith<$Res> get data {
    return $ChatMessagesDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessagesResponseImplCopyWith<$Res>
    implements $ChatMessagesResponseCopyWith<$Res> {
  factory _$$ChatMessagesResponseImplCopyWith(
    _$ChatMessagesResponseImpl value,
    $Res Function(_$ChatMessagesResponseImpl) then,
  ) = __$$ChatMessagesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, ChatMessagesData data});

  @override
  $ChatMessagesDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$ChatMessagesResponseImplCopyWithImpl<$Res>
    extends _$ChatMessagesResponseCopyWithImpl<$Res, _$ChatMessagesResponseImpl>
    implements _$$ChatMessagesResponseImplCopyWith<$Res> {
  __$$ChatMessagesResponseImplCopyWithImpl(
    _$ChatMessagesResponseImpl _value,
    $Res Function(_$ChatMessagesResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? data = null}) {
    return _then(
      _$ChatMessagesResponseImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as ChatMessagesData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessagesResponseImpl implements _ChatMessagesResponse {
  const _$ChatMessagesResponseImpl({required this.success, required this.data});

  factory _$ChatMessagesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessagesResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final ChatMessagesData data;

  @override
  String toString() {
    return 'ChatMessagesResponse(success: $success, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessagesResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, data);

  /// Create a copy of ChatMessagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessagesResponseImplCopyWith<_$ChatMessagesResponseImpl>
  get copyWith =>
      __$$ChatMessagesResponseImplCopyWithImpl<_$ChatMessagesResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessagesResponseImplToJson(this);
  }
}

abstract class _ChatMessagesResponse implements ChatMessagesResponse {
  const factory _ChatMessagesResponse({
    required final bool success,
    required final ChatMessagesData data,
  }) = _$ChatMessagesResponseImpl;

  factory _ChatMessagesResponse.fromJson(Map<String, dynamic> json) =
      _$ChatMessagesResponseImpl.fromJson;

  @override
  bool get success;
  @override
  ChatMessagesData get data;

  /// Create a copy of ChatMessagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessagesResponseImplCopyWith<_$ChatMessagesResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ChatMessagesData _$ChatMessagesDataFromJson(Map<String, dynamic> json) {
  return _ChatMessagesData.fromJson(json);
}

/// @nodoc
mixin _$ChatMessagesData {
  /// List of chat messages
  List<CompanyChatMessage> get messages => throw _privateConstructorUsedError;

  /// Pagination information
  ChatPagination get pagination => throw _privateConstructorUsedError;

  /// Serializes this ChatMessagesData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessagesData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessagesDataCopyWith<ChatMessagesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessagesDataCopyWith<$Res> {
  factory $ChatMessagesDataCopyWith(
    ChatMessagesData value,
    $Res Function(ChatMessagesData) then,
  ) = _$ChatMessagesDataCopyWithImpl<$Res, ChatMessagesData>;
  @useResult
  $Res call({List<CompanyChatMessage> messages, ChatPagination pagination});

  $ChatPaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$ChatMessagesDataCopyWithImpl<$Res, $Val extends ChatMessagesData>
    implements $ChatMessagesDataCopyWith<$Res> {
  _$ChatMessagesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessagesData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null, Object? pagination = null}) {
    return _then(
      _value.copyWith(
            messages:
                null == messages
                    ? _value.messages
                    : messages // ignore: cast_nullable_to_non_nullable
                        as List<CompanyChatMessage>,
            pagination:
                null == pagination
                    ? _value.pagination
                    : pagination // ignore: cast_nullable_to_non_nullable
                        as ChatPagination,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatMessagesData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatPaginationCopyWith<$Res> get pagination {
    return $ChatPaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessagesDataImplCopyWith<$Res>
    implements $ChatMessagesDataCopyWith<$Res> {
  factory _$$ChatMessagesDataImplCopyWith(
    _$ChatMessagesDataImpl value,
    $Res Function(_$ChatMessagesDataImpl) then,
  ) = __$$ChatMessagesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CompanyChatMessage> messages, ChatPagination pagination});

  @override
  $ChatPaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$ChatMessagesDataImplCopyWithImpl<$Res>
    extends _$ChatMessagesDataCopyWithImpl<$Res, _$ChatMessagesDataImpl>
    implements _$$ChatMessagesDataImplCopyWith<$Res> {
  __$$ChatMessagesDataImplCopyWithImpl(
    _$ChatMessagesDataImpl _value,
    $Res Function(_$ChatMessagesDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessagesData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null, Object? pagination = null}) {
    return _then(
      _$ChatMessagesDataImpl(
        messages:
            null == messages
                ? _value._messages
                : messages // ignore: cast_nullable_to_non_nullable
                    as List<CompanyChatMessage>,
        pagination:
            null == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                    as ChatPagination,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessagesDataImpl implements _ChatMessagesData {
  const _$ChatMessagesDataImpl({
    required final List<CompanyChatMessage> messages,
    required this.pagination,
  }) : _messages = messages;

  factory _$ChatMessagesDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessagesDataImplFromJson(json);

  /// List of chat messages
  final List<CompanyChatMessage> _messages;

  /// List of chat messages
  @override
  List<CompanyChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  /// Pagination information
  @override
  final ChatPagination pagination;

  @override
  String toString() {
    return 'ChatMessagesData(messages: $messages, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessagesDataImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_messages),
    pagination,
  );

  /// Create a copy of ChatMessagesData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessagesDataImplCopyWith<_$ChatMessagesDataImpl> get copyWith =>
      __$$ChatMessagesDataImplCopyWithImpl<_$ChatMessagesDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessagesDataImplToJson(this);
  }
}

abstract class _ChatMessagesData implements ChatMessagesData {
  const factory _ChatMessagesData({
    required final List<CompanyChatMessage> messages,
    required final ChatPagination pagination,
  }) = _$ChatMessagesDataImpl;

  factory _ChatMessagesData.fromJson(Map<String, dynamic> json) =
      _$ChatMessagesDataImpl.fromJson;

  /// List of chat messages
  @override
  List<CompanyChatMessage> get messages;

  /// Pagination information
  @override
  ChatPagination get pagination;

  /// Create a copy of ChatMessagesData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessagesDataImplCopyWith<_$ChatMessagesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatPagination _$ChatPaginationFromJson(Map<String, dynamic> json) {
  return _ChatPagination.fromJson(json);
}

/// @nodoc
mixin _$ChatPagination {
  /// Total number of messages
  int get total => throw _privateConstructorUsedError;

  /// Current page number
  int get page => throw _privateConstructorUsedError;

  /// Items per page
  int get limit => throw _privateConstructorUsedError;

  /// Total number of pages
  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this ChatPagination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatPagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatPaginationCopyWith<ChatPagination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatPaginationCopyWith<$Res> {
  factory $ChatPaginationCopyWith(
    ChatPagination value,
    $Res Function(ChatPagination) then,
  ) = _$ChatPaginationCopyWithImpl<$Res, ChatPagination>;
  @useResult
  $Res call({int total, int page, int limit, int totalPages});
}

/// @nodoc
class _$ChatPaginationCopyWithImpl<$Res, $Val extends ChatPagination>
    implements $ChatPaginationCopyWith<$Res> {
  _$ChatPaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatPagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? totalPages = null,
  }) {
    return _then(
      _value.copyWith(
            total:
                null == total
                    ? _value.total
                    : total // ignore: cast_nullable_to_non_nullable
                        as int,
            page:
                null == page
                    ? _value.page
                    : page // ignore: cast_nullable_to_non_nullable
                        as int,
            limit:
                null == limit
                    ? _value.limit
                    : limit // ignore: cast_nullable_to_non_nullable
                        as int,
            totalPages:
                null == totalPages
                    ? _value.totalPages
                    : totalPages // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatPaginationImplCopyWith<$Res>
    implements $ChatPaginationCopyWith<$Res> {
  factory _$$ChatPaginationImplCopyWith(
    _$ChatPaginationImpl value,
    $Res Function(_$ChatPaginationImpl) then,
  ) = __$$ChatPaginationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int total, int page, int limit, int totalPages});
}

/// @nodoc
class __$$ChatPaginationImplCopyWithImpl<$Res>
    extends _$ChatPaginationCopyWithImpl<$Res, _$ChatPaginationImpl>
    implements _$$ChatPaginationImplCopyWith<$Res> {
  __$$ChatPaginationImplCopyWithImpl(
    _$ChatPaginationImpl _value,
    $Res Function(_$ChatPaginationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatPagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? totalPages = null,
  }) {
    return _then(
      _$ChatPaginationImpl(
        total:
            null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                    as int,
        page:
            null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                    as int,
        limit:
            null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                    as int,
        totalPages:
            null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatPaginationImpl implements _ChatPagination {
  const _$ChatPaginationImpl({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory _$ChatPaginationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatPaginationImplFromJson(json);

  /// Total number of messages
  @override
  final int total;

  /// Current page number
  @override
  final int page;

  /// Items per page
  @override
  final int limit;

  /// Total number of pages
  @override
  final int totalPages;

  @override
  String toString() {
    return 'ChatPagination(total: $total, page: $page, limit: $limit, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatPaginationImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, page, limit, totalPages);

  /// Create a copy of ChatPagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatPaginationImplCopyWith<_$ChatPaginationImpl> get copyWith =>
      __$$ChatPaginationImplCopyWithImpl<_$ChatPaginationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatPaginationImplToJson(this);
  }
}

abstract class _ChatPagination implements ChatPagination {
  const factory _ChatPagination({
    required final int total,
    required final int page,
    required final int limit,
    required final int totalPages,
  }) = _$ChatPaginationImpl;

  factory _ChatPagination.fromJson(Map<String, dynamic> json) =
      _$ChatPaginationImpl.fromJson;

  /// Total number of messages
  @override
  int get total;

  /// Current page number
  @override
  int get page;

  /// Items per page
  @override
  int get limit;

  /// Total number of pages
  @override
  int get totalPages;

  /// Create a copy of ChatPagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatPaginationImplCopyWith<_$ChatPaginationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UnreadCountResponse _$UnreadCountResponseFromJson(Map<String, dynamic> json) {
  return _UnreadCountResponse.fromJson(json);
}

/// @nodoc
mixin _$UnreadCountResponse {
  bool get success => throw _privateConstructorUsedError;
  UnreadCountData get data => throw _privateConstructorUsedError;

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
  $Res call({bool success, UnreadCountData data});

  $UnreadCountDataCopyWith<$Res> get data;
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
  $Res call({Object? success = null, Object? data = null}) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as UnreadCountData,
          )
          as $Val,
    );
  }

  /// Create a copy of UnreadCountResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnreadCountDataCopyWith<$Res> get data {
    return $UnreadCountDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
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
  $Res call({bool success, UnreadCountData data});

  @override
  $UnreadCountDataCopyWith<$Res> get data;
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
  $Res call({Object? success = null, Object? data = null}) {
    return _then(
      _$UnreadCountResponseImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as UnreadCountData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UnreadCountResponseImpl implements _UnreadCountResponse {
  const _$UnreadCountResponseImpl({required this.success, required this.data});

  factory _$UnreadCountResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnreadCountResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final UnreadCountData data;

  @override
  String toString() {
    return 'UnreadCountResponse(success: $success, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnreadCountResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, data);

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
    required final UnreadCountData data,
  }) = _$UnreadCountResponseImpl;

  factory _UnreadCountResponse.fromJson(Map<String, dynamic> json) =
      _$UnreadCountResponseImpl.fromJson;

  @override
  bool get success;
  @override
  UnreadCountData get data;

  /// Create a copy of UnreadCountResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnreadCountResponseImplCopyWith<_$UnreadCountResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UnreadCountData _$UnreadCountDataFromJson(Map<String, dynamic> json) {
  return _UnreadCountData.fromJson(json);
}

/// @nodoc
mixin _$UnreadCountData {
  /// Number of unread messages
  int get unreadCount => throw _privateConstructorUsedError;

  /// Serializes this UnreadCountData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UnreadCountData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnreadCountDataCopyWith<UnreadCountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnreadCountDataCopyWith<$Res> {
  factory $UnreadCountDataCopyWith(
    UnreadCountData value,
    $Res Function(UnreadCountData) then,
  ) = _$UnreadCountDataCopyWithImpl<$Res, UnreadCountData>;
  @useResult
  $Res call({int unreadCount});
}

/// @nodoc
class _$UnreadCountDataCopyWithImpl<$Res, $Val extends UnreadCountData>
    implements $UnreadCountDataCopyWith<$Res> {
  _$UnreadCountDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnreadCountData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? unreadCount = null}) {
    return _then(
      _value.copyWith(
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
abstract class _$$UnreadCountDataImplCopyWith<$Res>
    implements $UnreadCountDataCopyWith<$Res> {
  factory _$$UnreadCountDataImplCopyWith(
    _$UnreadCountDataImpl value,
    $Res Function(_$UnreadCountDataImpl) then,
  ) = __$$UnreadCountDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int unreadCount});
}

/// @nodoc
class __$$UnreadCountDataImplCopyWithImpl<$Res>
    extends _$UnreadCountDataCopyWithImpl<$Res, _$UnreadCountDataImpl>
    implements _$$UnreadCountDataImplCopyWith<$Res> {
  __$$UnreadCountDataImplCopyWithImpl(
    _$UnreadCountDataImpl _value,
    $Res Function(_$UnreadCountDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UnreadCountData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? unreadCount = null}) {
    return _then(
      _$UnreadCountDataImpl(
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
class _$UnreadCountDataImpl implements _UnreadCountData {
  const _$UnreadCountDataImpl({required this.unreadCount});

  factory _$UnreadCountDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnreadCountDataImplFromJson(json);

  /// Number of unread messages
  @override
  final int unreadCount;

  @override
  String toString() {
    return 'UnreadCountData(unreadCount: $unreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnreadCountDataImpl &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, unreadCount);

  /// Create a copy of UnreadCountData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnreadCountDataImplCopyWith<_$UnreadCountDataImpl> get copyWith =>
      __$$UnreadCountDataImplCopyWithImpl<_$UnreadCountDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UnreadCountDataImplToJson(this);
  }
}

abstract class _UnreadCountData implements UnreadCountData {
  const factory _UnreadCountData({required final int unreadCount}) =
      _$UnreadCountDataImpl;

  factory _UnreadCountData.fromJson(Map<String, dynamic> json) =
      _$UnreadCountDataImpl.fromJson;

  /// Number of unread messages
  @override
  int get unreadCount;

  /// Create a copy of UnreadCountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnreadCountDataImplCopyWith<_$UnreadCountDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SendMessageResponse _$SendMessageResponseFromJson(Map<String, dynamic> json) {
  return _SendMessageResponse.fromJson(json);
}

/// @nodoc
mixin _$SendMessageResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  CompanyChatMessage get data => throw _privateConstructorUsedError;

  /// Serializes this SendMessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendMessageResponseCopyWith<SendMessageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendMessageResponseCopyWith<$Res> {
  factory $SendMessageResponseCopyWith(
    SendMessageResponse value,
    $Res Function(SendMessageResponse) then,
  ) = _$SendMessageResponseCopyWithImpl<$Res, SendMessageResponse>;
  @useResult
  $Res call({bool success, String message, CompanyChatMessage data});

  $CompanyChatMessageCopyWith<$Res> get data;
}

/// @nodoc
class _$SendMessageResponseCopyWithImpl<$Res, $Val extends SendMessageResponse>
    implements $SendMessageResponseCopyWith<$Res> {
  _$SendMessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as CompanyChatMessage,
          )
          as $Val,
    );
  }

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompanyChatMessageCopyWith<$Res> get data {
    return $CompanyChatMessageCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SendMessageResponseImplCopyWith<$Res>
    implements $SendMessageResponseCopyWith<$Res> {
  factory _$$SendMessageResponseImplCopyWith(
    _$SendMessageResponseImpl value,
    $Res Function(_$SendMessageResponseImpl) then,
  ) = __$$SendMessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, CompanyChatMessage data});

  @override
  $CompanyChatMessageCopyWith<$Res> get data;
}

/// @nodoc
class __$$SendMessageResponseImplCopyWithImpl<$Res>
    extends _$SendMessageResponseCopyWithImpl<$Res, _$SendMessageResponseImpl>
    implements _$$SendMessageResponseImplCopyWith<$Res> {
  __$$SendMessageResponseImplCopyWithImpl(
    _$SendMessageResponseImpl _value,
    $Res Function(_$SendMessageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$SendMessageResponseImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as CompanyChatMessage,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SendMessageResponseImpl implements _SendMessageResponse {
  const _$SendMessageResponseImpl({
    required this.success,
    required this.message,
    required this.data,
  });

  factory _$SendMessageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendMessageResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final CompanyChatMessage data;

  @override
  String toString() {
    return 'SendMessageResponse(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, data);

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageResponseImplCopyWith<_$SendMessageResponseImpl> get copyWith =>
      __$$SendMessageResponseImplCopyWithImpl<_$SendMessageResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SendMessageResponseImplToJson(this);
  }
}

abstract class _SendMessageResponse implements SendMessageResponse {
  const factory _SendMessageResponse({
    required final bool success,
    required final String message,
    required final CompanyChatMessage data,
  }) = _$SendMessageResponseImpl;

  factory _SendMessageResponse.fromJson(Map<String, dynamic> json) =
      _$SendMessageResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  CompanyChatMessage get data;

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMessageResponseImplCopyWith<_$SendMessageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatSuccessResponse _$ChatSuccessResponseFromJson(Map<String, dynamic> json) {
  return _ChatSuccessResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatSuccessResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this ChatSuccessResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatSuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatSuccessResponseCopyWith<ChatSuccessResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatSuccessResponseCopyWith<$Res> {
  factory $ChatSuccessResponseCopyWith(
    ChatSuccessResponse value,
    $Res Function(ChatSuccessResponse) then,
  ) = _$ChatSuccessResponseCopyWithImpl<$Res, ChatSuccessResponse>;
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class _$ChatSuccessResponseCopyWithImpl<$Res, $Val extends ChatSuccessResponse>
    implements $ChatSuccessResponseCopyWith<$Res> {
  _$ChatSuccessResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatSuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? message = null}) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatSuccessResponseImplCopyWith<$Res>
    implements $ChatSuccessResponseCopyWith<$Res> {
  factory _$$ChatSuccessResponseImplCopyWith(
    _$ChatSuccessResponseImpl value,
    $Res Function(_$ChatSuccessResponseImpl) then,
  ) = __$$ChatSuccessResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class __$$ChatSuccessResponseImplCopyWithImpl<$Res>
    extends _$ChatSuccessResponseCopyWithImpl<$Res, _$ChatSuccessResponseImpl>
    implements _$$ChatSuccessResponseImplCopyWith<$Res> {
  __$$ChatSuccessResponseImplCopyWithImpl(
    _$ChatSuccessResponseImpl _value,
    $Res Function(_$ChatSuccessResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatSuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? message = null}) {
    return _then(
      _$ChatSuccessResponseImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatSuccessResponseImpl implements _ChatSuccessResponse {
  const _$ChatSuccessResponseImpl({
    required this.success,
    required this.message,
  });

  factory _$ChatSuccessResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatSuccessResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;

  @override
  String toString() {
    return 'ChatSuccessResponse(success: $success, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatSuccessResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message);

  /// Create a copy of ChatSuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatSuccessResponseImplCopyWith<_$ChatSuccessResponseImpl> get copyWith =>
      __$$ChatSuccessResponseImplCopyWithImpl<_$ChatSuccessResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatSuccessResponseImplToJson(this);
  }
}

abstract class _ChatSuccessResponse implements ChatSuccessResponse {
  const factory _ChatSuccessResponse({
    required final bool success,
    required final String message,
  }) = _$ChatSuccessResponseImpl;

  factory _ChatSuccessResponse.fromJson(Map<String, dynamic> json) =
      _$ChatSuccessResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;

  /// Create a copy of ChatSuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatSuccessResponseImplCopyWith<_$ChatSuccessResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
