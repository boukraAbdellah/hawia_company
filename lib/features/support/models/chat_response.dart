import 'package:freezed_annotation/freezed_annotation.dart';
import 'company_chat_message.dart';

part 'chat_response.freezed.dart';
part 'chat_response.g.dart';

/// Response when fetching chat messages
@freezed
class ChatMessagesResponse with _$ChatMessagesResponse {
  const factory ChatMessagesResponse({
    required bool success,
    required ChatMessagesData data,
  }) = _ChatMessagesResponse;

  factory ChatMessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagesResponseFromJson(json);
}

/// Data structure for chat messages response
@freezed
class ChatMessagesData with _$ChatMessagesData {
  const factory ChatMessagesData({
    /// List of chat messages
    required List<CompanyChatMessage> messages,
    
    /// Pagination information
    required ChatPagination pagination,
  }) = _ChatMessagesData;

  factory ChatMessagesData.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagesDataFromJson(json);
}

/// Pagination information
@freezed
class ChatPagination with _$ChatPagination {
  const factory ChatPagination({
    /// Total number of messages
    required int total,
    
    /// Current page number
    required int page,
    
    /// Items per page
    required int limit,
    
    /// Total number of pages
    required int totalPages,
  }) = _ChatPagination;

  factory ChatPagination.fromJson(Map<String, dynamic> json) =>
      _$ChatPaginationFromJson(json);
}

/// Response for unread count
@freezed
class UnreadCountResponse with _$UnreadCountResponse {
  const factory UnreadCountResponse({
    required bool success,
    required UnreadCountData data,
  }) = _UnreadCountResponse;

  factory UnreadCountResponse.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountResponseFromJson(json);
}

/// Unread count data
@freezed
class UnreadCountData with _$UnreadCountData {
  const factory UnreadCountData({
    /// Number of unread messages
    required int unreadCount,
  }) = _UnreadCountData;

  factory UnreadCountData.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountDataFromJson(json);
}

/// Response after sending a message
@freezed
class SendMessageResponse with _$SendMessageResponse {
  const factory SendMessageResponse({
    required bool success,
    required String message,
    required CompanyChatMessage data,
  }) = _SendMessageResponse;

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SendMessageResponseFromJson(json);
}

/// Generic success response
@freezed
class ChatSuccessResponse with _$ChatSuccessResponse {
  const factory ChatSuccessResponse({
    required bool success,
    required String message,
  }) = _ChatSuccessResponse;

  factory ChatSuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatSuccessResponseFromJson(json);
}
