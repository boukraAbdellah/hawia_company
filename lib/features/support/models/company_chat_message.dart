import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_chat_message.freezed.dart';
part 'company_chat_message.g.dart';

/// Represents a single chat message between company admin and super admin
@freezed
class CompanyChatMessage with _$CompanyChatMessage {
  const factory CompanyChatMessage({
    /// Unique message ID (UUID)
    required String id,
    
    /// Company ID this message belongs to (UUID)
    String? companyId,
    
    /// ID of the user who sent the message (UUID)
    String? senderId,
    
    /// Type of sender: 'company_admin' or 'super_admin'
    required SenderType senderType,
    
    /// Display name of the sender
    required String senderName,
    
    /// Message content (text)
    required String message,
    
    /// Whether the message has been read
    @Default(false) bool isRead,
    
    /// Array of user IDs who have read this message
    @Default([]) List<String> readBy,
    
    /// When the message was created
    required DateTime createdAt,
    
    /// When the message was last updated
    DateTime? updatedAt,
  }) = _CompanyChatMessage;

  factory CompanyChatMessage.fromJson(Map<String, dynamic> json) =>
      _$CompanyChatMessageFromJson(json);
}

/// Enum for sender type
enum SenderType {
  @JsonValue('company_admin')
  companyAdmin,
  
  @JsonValue('super_admin')
  superAdmin;

  /// Display name in Arabic
  String get displayName {
    switch (this) {
      case SenderType.companyAdmin:
        return 'أنت';
      case SenderType.superAdmin:
        return 'الدعم الفني';
    }
  }

  /// Is this the current user? (company admin perspective)
  bool get isMe => this == SenderType.companyAdmin;
  
  /// Is this from super admin?
  bool get isSuperAdmin => this == SenderType.superAdmin;
}
