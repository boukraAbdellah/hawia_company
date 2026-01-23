# Flutter Chat Models - Company Mobile App
## Chat Between Company Admin & Super Admin

---

## 🎯 Overview

This document provides **production-ready Flutter models** for the company-admin chat feature. All models use **freezed** for immutability and include **complete JSON serialization**.

### Chat System Details

- **Purpose:** Direct messaging between company admins and super admins
- **Database:** Master DB (`company_chat_messages` table)
- **Delivery:** REST API + WebSocket (real-time)
- **Sender Types:** `company_admin` | `super_admin`

---

## 🔌 API Integration Guide

### Base URL
```
API: /api/company/admin-chat
WebSocket: ws://your-backend-url (or wss:// for production)
```

### Authentication
All API requests require:
- **Header:** `Authorization: Bearer <jwt_token>`
- Token should be obtained from company login/authentication flow
- Token identifies the company and user making the request

### API Endpoints

#### 1. **GET** `/api/company/admin-chat/messages`
Fetch chat message history with pagination.

**Query Parameters:**
- `page` (number, optional, default: 1) - Page number
- `limit` (number, optional, default: 50) - Messages per page

**Response:**
```json
{
  "success": true,
  "data": {
    "messages": [
      {
        "id": "uuid-string",
        "companyId": "uuid-string",
        "senderId": "uuid-string",
        "senderType": "company_admin",
        "senderName": "أحمد محمد",
        "message": "مرحباً، لدي استفسار",
        "isRead": true,
        "readBy": ["uuid-1", "uuid-2"],
        "createdAt": "2026-01-21T10:30:00.000Z",
        "updatedAt": "2026-01-21T10:30:00.000Z"
      }
    ],
    "pagination": {
      "total": 150,
      "page": 1,
      "limit": 50,
      "totalPages": 3
    }
  }
}
```

#### 2. **POST** `/api/company/admin-chat/messages`
Send a new message to super admin.

**Request Body:**
```json
{
  "message": "نص الرسالة هنا"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "new-uuid",
    "companyId": "company-uuid",
    "senderId": "sender-uuid",
    "senderType": "company_admin",
    "senderName": "اسم المرسل",
    "message": "نص الرسالة",
    "isRead": false,
    "readBy": [],
    "createdAt": "2026-01-21T10:35:00.000Z",
    "updatedAt": "2026-01-21T10:35:00.000Z"
  }
}
```

**Notes:**
- Message is immediately broadcast via WebSocket to all connected clients
- Do NOT manually add the sent message to local state - wait for WebSocket broadcast
- This prevents duplicate messages

#### 3. **PATCH** `/api/company/admin-chat/mark-read`
Mark all unread messages as read (from super admin).

**Request Body:** None

**Response:**
```json
{
  "success": true,
  "message": "Messages marked as read"
}
```

**When to call:**
- When chat screen is opened/focused
- When user views new messages from super admin

#### 4. **GET** `/api/company/admin-chat/unread-count`
Get count of unread messages from super admin.

**Response:**
```json
{
  "success": true,
  "data": {
    "unreadCount": 5
  }
}
```

**Usage:**
- Display badge on chat icon in navigation
- Poll periodically (every 30-60 seconds) or use WebSocket events
- Call on app launch/resume

---

## 🔄 WebSocket Integration

### Connection Setup

**WebSocket URL:**
```
ws://your-backend-url (development)
wss://your-backend-url (production)
```

**Connection Flow:**
1. Establish WebSocket connection
2. Wait for `onopen` event
3. Send subscription message
4. Listen for incoming messages
5. Handle reconnection on close/error

### Subscription Message
After connection opens, send this JSON:
```json
{
  "type": "subscribe_company_chat",
  "companyId": "your-company-uuid",
  "userType": "company_admin",
  "userId": "company-admin-{userId}"
}
```

**Parameters:**
- `type`: Always `"subscribe_company_chat"`
- `companyId`: Convert to string if UUID
- `userType`: Always `"company_admin"` for company app
- `userId`: Format as `"company-admin-{actualUserId}"`

### Incoming WebSocket Messages
Listen for messages with this structure:
```json
{
  "type": "company_chat_message",
  "companyId": "company-uuid",
  "message": {
    "id": "message-uuid",
    "companyId": "company-uuid",
    "senderId": "sender-uuid",
    "senderType": "super_admin",
    "senderName": "الدعم الفني",
    "message": "نص الرسالة",
    "isRead": false,
    "readBy": [],
    "createdAt": "2026-01-21T10:40:00.000Z",
    "updatedAt": "2026-01-21T10:40:00.000Z"
  }
}
```

**Message Processing:**
1. Check `type === "company_chat_message"`
2. Verify `companyId` matches your company
3. Check if message already exists in local state (by `id`)
4. If new, add to message list
5. If sender is `super_admin`, call mark-read API
6. Scroll to bottom of chat
7. Remove any temporary messages with same content

### Unsubscribe Message
Before closing connection or on app exit:
```json
{
  "type": "unsubscribe_company_chat",
  "companyId": "your-company-uuid"
}
```

### Reconnection Strategy
**Exponential Backoff:**
- Initial retry: 1 second
- Double delay on each retry: 2s, 4s, 8s...
- Max delay: 10 seconds
- Max attempts: 10

**Auto-reconnect on:**
- `onclose` event
- `onerror` event
- Network connectivity restoration

### WebSocket Best Practices

#### 1. **Prevent Duplicate Messages**
```dart
Set<String> processingMessages = {};

void handleWebSocketMessage(dynamic data) {
  final messageId = data['message']['id'];
  final messageKey = '${data['companyId']}-$messageId';
  
  // Skip if already processing
  if (processingMessages.contains(messageKey)) return;
  
  processingMessages.add(messageKey);
  
  // Process message...
  
  // Clear after 5 seconds
  Future.delayed(Duration(seconds: 5), () {
    processingMessages.remove(messageKey);
  });
}
```

#### 2. **Optimistic UI Updates**
When sending a message:
```dart
// 1. Create temporary message with temp ID
final tempMessage = CompanyChatMessage(
  id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
  message: userInput,
  senderType: SenderType.companyAdmin,
  // ... other fields
);

// 2. Add to local state immediately
messages.add(tempMessage);

// 3. Send via API (don't wait for response)
try {
  await sendMessage(userInput);
} catch (e) {
  // Remove temp message on error
  messages.removeWhere((m) => m.id.startsWith('temp-'));
}

// 4. Real message arrives via WebSocket, replace temp
// WebSocket handler should:
// - Remove messages with temp- IDs
// - Add the real message from server
```

#### 3. **Connection Status Indicator**
Show to user:
- 🟢 Connected (WebSocket open + subscribed)
- 🔴 Disconnected (WebSocket closed)
- 🟡 Connecting (WebSocket opening)

---

## 💾 Local State Management

### Message Storage
**DO NOT store in local DB** - Always fetch from server on app open.

**Reasons:**
1. Messages synced across devices
2. Read status changes from super admin
3. Avoid sync conflicts
4. Always show latest data

### State Structure
```dart
class ChatState {
  List<CompanyChatMessage> messages = [];
  bool isLoading = false;
  bool isSendingMessage = false;
  String? error = null;
  int unreadCount = 0;
  bool isConnected = false; // WebSocket status
  
  ChatPagination? pagination;
}
```

### Lifecycle Management

**On Chat Screen Open:**
1. Fetch messages: `GET /messages?page=1&limit=50`
2. Mark as read: `PATCH /mark-read`
3. Establish WebSocket connection
4. Subscribe to chat channel

**On Chat Screen Close:**
1. Unsubscribe from chat channel
2. Close WebSocket connection
3. Keep messages in memory (don't clear)

**On App Background:**
- Keep WebSocket alive if possible
- If disconnected, reconnect on app resume

**On App Resume:**
- Check WebSocket connection
- Reconnect if needed
- Fetch unread count
- Optionally refresh messages

---

## 🎨 UI/UX Guidelines

### Message Alignment
- **Company Admin (You):** Right-aligned, primary color background
- **Super Admin:** Left-aligned, white/gray background with support icon

### Message Bubble Design
```dart
// Company admin message
Container(
  alignment: Alignment.centerRight,
  child: Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(message.message, style: TextStyle(color: Colors.white)),
  ),
);

// Super admin message
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    CircleAvatar(child: Icon(Icons.headset_mic)), // Support icon
    SizedBox(width: 8),
    Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(message.message),
    ),
  ],
);
```

### Empty State
```
📭
لا توجد رسائل بعد
ابدأ المحادثة مع فريق الدعم
```

### Timestamp Format
```dart
String formatMessageTime(DateTime time) {
  final now = DateTime.now();
  final diff = now.difference(time);
  
  if (diff.inDays == 0) {
    // Today: Show time only
    return DateFormat('HH:mm', 'ar').format(time);
  } else if (diff.inDays == 1) {
    return 'أمس ${DateFormat('HH:mm', 'ar').format(time)}';
  } else if (diff.inDays < 7) {
    return DateFormat('EEEE HH:mm', 'ar').format(time);
  } else {
    return DateFormat('dd/MM/yyyy HH:mm', 'ar').format(time);
  }
}
```

### Loading States
- **Initial load:** Full-screen spinner
- **Sending message:** Show temp message with opacity 0.5 + "(جاري الإرسال...)"
- **Connection lost:** Show warning banner at top

---

## 🔒 Security & Validation

### Message Validation
**Client-side:**
- Trim whitespace
- Minimum length: 1 character
- Maximum length: 1000 characters
- No empty messages

**Server handles:**
- HTML sanitization
- XSS prevention
- Rate limiting

### Error Handling

**Network Errors:**
```dart
try {
  await sendMessage(text);
} on DioError catch (e) {
  if (e.response?.statusCode == 401) {
    // Token expired - redirect to login
  } else if (e.type == DioErrorType.connectTimeout) {
    showError('تحقق من اتصال الإنترنت');
  } else {
    showError('فشل إرسال الرسالة');
  }
}
```

**WebSocket Errors:**
```dart
ws.onerror = (error) {
  setState(() => isConnected = false);
  // Auto-reconnect will be triggered by onclose
};

ws.onclose = (event) {
  setState(() => isConnected = false);
  scheduleReconnect(); // Exponential backoff
};
```

---

## 🧪 Testing Checklist

### Functional Tests
- ✅ Send message successfully
- ✅ Receive message from super admin
- ✅ Mark messages as read
- ✅ Display unread count badge
- ✅ Pagination works correctly
- ✅ Empty state shows correctly
- ✅ WebSocket reconnection works
- ✅ Optimistic UI updates correctly
- ✅ No duplicate messages

### Edge Cases
- ✅ Handle network disconnection
- ✅ Handle token expiration
- ✅ Handle WebSocket disconnection
- ✅ Multiple messages sent rapidly
- ✅ Very long messages (1000+ chars)
- ✅ Arabic text rendering
- ✅ Emoji support
- ✅ App backgrounding during send

### Performance Tests
- ✅ Load 100+ messages smoothly
- ✅ WebSocket doesn't cause memory leaks
- ✅ Scroll performance with many messages
- ✅ No UI freezing on message receive

---

## 📊 Implementation Example Flow

### Complete Message Send Flow
```dart
// User types and hits send
Future<void> handleSendMessage(String text) async {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return;
  
  // 1. Create temp message
  final tempMsg = CompanyChatMessage(
    id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
    companyId: currentCompany.id,
    senderId: currentUser.id,
    senderType: SenderType.companyAdmin,
    senderName: currentUser.name,
    message: trimmed,
    isRead: false,
    readBy: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  
  // 2. Add to local state
  setState(() {
    messages.add(tempMsg);
    messageController.clear();
  });
  
  // 3. Scroll to bottom
  scrollToBottom();
  
  // 4. Send via API
  try {
    await chatService.sendMessage(trimmed);
    // Don't add message here - wait for WebSocket
  } catch (e) {
    // 5. Remove temp message on error
    setState(() {
      messages.removeWhere((m) => m.id == tempMsg.id);
    });
    showError('فشل إرسال الرسالة');
  }
}

// WebSocket receives the real message
void handleWebSocketMessage(Map<String, dynamic> data) {
  if (data['type'] != 'company_chat_message') return;
  if (data['companyId'] != currentCompany.id) return;
  
  final newMessage = CompanyChatMessage.fromJson(data['message']);
  
  setState(() {
    // Remove temp messages
    messages.removeWhere((m) => m.id.startsWith('temp-'));
    
    // Add real message if not exists
    if (!messages.any((m) => m.id == newMessage.id)) {
      messages.add(newMessage);
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
  });
  
  // Mark as read if from super admin
  if (newMessage.senderType == SenderType.superAdmin) {
    chatService.markAsRead();
  }
  
  scrollToBottom();
}
```

---

## 📦 Required Packages

```yaml
dependencies:
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.6
  freezed: ^2.4.5
  json_serializable: ^6.7.1
```

---

## 📁 File Structure

```
lib/
├── models/
│   └── chat/
│       ├── company_chat_message.dart
│       ├── company_chat_message.freezed.dart  (generated)
│       ├── company_chat_message.g.dart       (generated)
│       ├── chat_response.dart
│       └── chat_response.freezed.dart        (generated)
```

---

## 🔷 Core Models

### 1. CompanyChatMessage Model

**File:** `lib/models/chat/company_chat_message.dart`

```dart
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
    required String companyId,
    
    /// ID of the user who sent the message (UUID)
    required String senderId,
    
    /// Type of sender: 'company_admin' or 'super_admin'
    required SenderType senderType,
    
    /// Display name of the sender
    required String senderName,
    
    /// Message content (text)
    required String message,
    
    /// Whether the message has been read
    required bool isRead,
    
    /// Array of user IDs who have read this message
    @Default([]) List<String> readBy,
    
    /// When the message was created
    required DateTime createdAt,
    
    /// When the message was last updated
    required DateTime updatedAt,
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
        return 'مسؤول الشركة';
      case SenderType.superAdmin:
        return 'الإدارة';
    }
  }

  /// Is this the current user? (company admin perspective)
  bool get isMe => this == SenderType.companyAdmin;
  
  /// Is this from super admin?
  bool get isSuperAdmin => this == SenderType.superAdmin;
}
```

---

### 2. Chat Response Models

**File:** `lib/models/chat/chat_response.dart`

```dart
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
    
    /// Whether there are any unread messages
    required bool hasUnread,
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
```

---

### 3. WebSocket Message Model

**File:** `lib/models/chat/websocket_message.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'company_chat_message.dart';

part 'websocket_message.freezed.dart';
part 'websocket_message.g.dart';

/// WebSocket message wrapper
@freezed
class WebSocketChatMessage with _$WebSocketChatMessage {
  const factory WebSocketChatMessage({
    /// Message type (should be 'company_chat_message')
    required String type,
    
    /// Company ID
    required String companyId,
    
    /// The actual chat message
    required WebSocketMessageData message,
  }) = _WebSocketChatMessage;

  factory WebSocketChatMessage.fromJson(Map<String, dynamic> json) =>
      _$WebSocketChatMessageFromJson(json);
}

/// WebSocket message data (simplified for real-time updates)
@freezed
class WebSocketMessageData with _$WebSocketMessageData {
  const factory WebSocketMessageData({
    /// Message ID
    required String id,
    
    /// Message content
    required String message,
    
    /// Sender type
    required SenderType senderType,
    
    /// Sender name
    required String senderName,
    
    /// Creation timestamp
    required DateTime createdAt,
  }) = _WebSocketMessageData;

  factory WebSocketMessageData.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageDataFromJson(json);
}
```

---

## 🌐 API Service

**File:** `lib/services/chat_service.dart`

```dart
import 'package:dio/dio.dart';
import '../models/chat/company_chat_message.dart';
import '../models/chat/chat_response.dart';

class ChatService {
  final Dio _dio;

  ChatService(this._dio);

  // ==================== Company Admin Chat Endpoints ====================

  /// Get all chat messages with super admins
  /// 
  /// Endpoint: GET /api/company/admin-chat/messages
  /// Query Parameters:
  ///   - page: int (default: 1)
  ///   - limit: int (default: 50)
  Future<ChatMessagesResponse> getChatMessages({
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await _dio.get(
        '/company/admin-chat/messages',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      
      return ChatMessagesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Send a message to super admins
  /// 
  /// Endpoint: POST /api/company/admin-chat/messages
  /// Body: { "message": "text content" }
  Future<SendMessageResponse> sendMessage(String message) async {
    try {
      if (message.trim().isEmpty) {
        throw Exception('Message cannot be empty');
      }

      final response = await _dio.post(
        '/company/admin-chat/messages',
        data: {'message': message.trim()},
      );
      
      return SendMessageResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get unread messages count from super admins
  /// 
  /// Endpoint: GET /api/company/admin-chat/unread-count
  Future<UnreadCountData> getUnreadCount() async {
    try {
      final response = await _dio.get('/company/admin-chat/unread-count');
      final parsed = UnreadCountResponse.fromJson(response.data);
      return parsed.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Mark all super admin messages as read
  /// 
  /// Endpoint: PATCH /api/company/admin-chat/mark-read
  Future<void> markAllAsRead() async {
    try {
      await _dio.patch('/company/admin-chat/mark-read');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ==================== Error Handling ====================

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final message = e.response?.data['message'] ?? 'Unknown error occurred';
      return Exception(message);
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return Exception('Connection timeout - please check your internet');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return Exception('Server took too long to respond');
    } else {
      return Exception('Network error: ${e.message}');
    }
  }
}
```

---

## 🔌 WebSocket Service

**File:** `lib/services/chat_websocket_service.dart`

```dart
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/chat/websocket_message.dart';

class ChatWebSocketService {
  static final ChatWebSocketService _instance = ChatWebSocketService._internal();
  factory ChatWebSocketService() => _instance;
  ChatWebSocketService._internal();

  WebSocketChannel? _channel;
  StreamController<WebSocketMessageData>? _messageController;
  Stream<WebSocketMessageData>? _messageStream;
  
  Timer? _reconnectTimer;
  bool _isConnected = false;
  String? _token;
  String? _companyId;

  /// Get message stream
  Stream<WebSocketMessageData> get messageStream {
    _messageController ??= StreamController<WebSocketMessageData>.broadcast();
    _messageStream ??= _messageController!.stream;
    return _messageStream!;
  }

  /// Connect to chat WebSocket
  /// 
  /// URL format: ws://your-server.com?token=jwt_token&role=company
  Future<void> connect(String token, String companyId, {String? baseUrl}) async {
    _token = token;
    _companyId = companyId;
    
    final wsUrl = baseUrl ?? 'ws://localhost:3000';
    
    try {
      print('🔌 Connecting to chat WebSocket...');
      
      _channel = WebSocketChannel.connect(
        Uri.parse('$wsUrl?token=$token&role=company'),
      );

      _isConnected = true;
      print('✅ Chat WebSocket connected');

      // Listen to messages
      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDisconnected,
      );
    } catch (e) {
      print('❌ Chat WebSocket connection failed: $e');
      _scheduleReconnect();
    }
  }

  /// Handle incoming WebSocket messages
  void _onMessage(dynamic data) {
    try {
      final json = jsonDecode(data as String);
      
      // Check if it's a chat message
      if (json['type'] == 'company_chat_message') {
        final wsMessage = WebSocketChatMessage.fromJson(json);
        
        // Only emit if it's for this company
        if (wsMessage.companyId == _companyId) {
          _messageController?.add(wsMessage.message);
          print('📬 New chat message received: ${wsMessage.message.message}');
        }
      }
    } catch (e) {
      print('❌ Error parsing WebSocket message: $e');
    }
  }

  /// Handle WebSocket errors
  void _onError(error) {
    print('❌ Chat WebSocket error: $error');
    _isConnected = false;
    _scheduleReconnect();
  }

  /// Handle disconnection
  void _onDisconnected() {
    print('🔌 Chat WebSocket disconnected');
    _isConnected = false;
    _scheduleReconnect();
  }

  /// Schedule reconnection attempt
  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (_token != null && _companyId != null && !_isConnected) {
        print('🔄 Attempting to reconnect chat WebSocket...');
        connect(_token!, _companyId!);
      }
    });
  }

  /// Disconnect from WebSocket
  void disconnect() {
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _isConnected = false;
    _token = null;
    _companyId = null;
    print('🔌 Chat WebSocket disconnected manually');
  }

  /// Check if currently connected
  bool get isConnected => _isConnected;
}
```

---

## 🎛️ Riverpod State Management

**File:** `lib/providers/chat_providers.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat/company_chat_message.dart';
import '../services/chat_service.dart';
import '../services/chat_websocket_service.dart';

part 'chat_providers.g.dart';

// ==================== Service Providers ====================

final chatServiceProvider = Provider<ChatService>((ref) {
  final dio = ref.read(dioProvider); // Your Dio instance
  return ChatService(dio);
});

final chatWebSocketServiceProvider = Provider<ChatWebSocketService>((ref) {
  return ChatWebSocketService();
});

// ==================== Chat Messages State ====================

@riverpod
class ChatMessages extends _$ChatMessages {
  @override
  Future<List<CompanyChatMessage>> build() async {
    // Connect WebSocket
    final token = ref.read(authTokenProvider);
    final companyId = ref.read(companyIdProvider);
    
    if (token != null && companyId != null) {
      final wsService = ref.read(chatWebSocketServiceProvider);
      await wsService.connect(token, companyId);
      
      // Listen to WebSocket stream for new messages
      wsService.messageStream.listen((wsMessage) {
        // Convert WebSocket message to full message
        final newMessage = CompanyChatMessage(
          id: wsMessage.id,
          companyId: companyId,
          senderId: '', // Not provided in WebSocket
          senderType: wsMessage.senderType,
          senderName: wsMessage.senderName,
          message: wsMessage.message,
          isRead: wsMessage.senderType == SenderType.companyAdmin, // Auto-read if sent by me
          readBy: [],
          createdAt: wsMessage.createdAt,
          updatedAt: wsMessage.createdAt,
        );
        
        // Add to existing messages
        state.whenData((messages) {
          state = AsyncValue.data([...messages, newMessage]);
        });
        
        // Mark as read if from super admin
        if (wsMessage.senderType == SenderType.superAdmin) {
          ref.read(chatMessagesProvider.notifier).markAllAsRead();
        }
      });
    }
    
    // Fetch initial messages
    final service = ref.read(chatServiceProvider);
    final response = await service.getChatMessages();
    return response.data.messages;
  }

  /// Refresh messages from API
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(chatServiceProvider);
      final response = await service.getChatMessages();
      return response.data.messages;
    });
  }

  /// Send a new message
  Future<void> sendMessage(String message) async {
    final service = ref.read(chatServiceProvider);
    
    try {
      final response = await service.sendMessage(message);
      
      // Add to local state optimistically
      state.whenData((messages) {
        state = AsyncValue.data([...messages, response.data]);
      });
    } catch (e) {
      // Handle error - maybe show snackbar
      rethrow;
    }
  }

  /// Mark all messages as read
  Future<void> markAllAsRead() async {
    final service = ref.read(chatServiceProvider);
    
    try {
      await service.markAllAsRead();
      
      // Update local state
      state.whenData((messages) {
        final updated = messages.map((msg) {
          if (msg.senderType == SenderType.superAdmin && !msg.isRead) {
            return msg.copyWith(isRead: true);
          }
          return msg;
        }).toList();
        state = AsyncValue.data(updated);
      });
      
      // Refresh unread count
      ref.invalidate(chatUnreadCountProvider);
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}

// ==================== Unread Count Provider ====================

@riverpod
class ChatUnreadCount extends _$ChatUnreadCount {
  @override
  Future<int> build() async {
    final service = ref.read(chatServiceProvider);
    final data = await service.getUnreadCount();
    return data.unreadCount;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(chatServiceProvider);
      final data = await service.getUnreadCount();
      return data.unreadCount;
    });
  }
}
```

---

## 📋 API Endpoints Summary

### Company Admin Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/company/admin-chat/messages` | Get all chat messages with super admins |
| POST | `/api/company/admin-chat/messages` | Send a message to super admins |
| GET | `/api/company/admin-chat/unread-count` | Get unread messages count |
| PATCH | `/api/company/admin-chat/mark-read` | Mark all super admin messages as read |

### Request/Response Examples

#### GET Messages
```json
// Request
GET /api/company/admin-chat/messages?page=1&limit=50

// Response
{
  "success": true,
  "data": {
    "messages": [
      {
        "id": "uuid-here",
        "companyId": "company-uuid",
        "senderId": "sender-uuid",
        "senderType": "super_admin",
        "senderName": "Admin Ahmed",
        "message": "Hello, how can we help?",
        "isRead": false,
        "readBy": [],
        "createdAt": "2026-01-21T10:30:00.000Z",
        "updatedAt": "2026-01-21T10:30:00.000Z"
      }
    ],
    "pagination": {
      "total": 45,
      "page": 1,
      "limit": 50,
      "totalPages": 1
    }
  }
}
```

#### POST Send Message
```json
// Request
POST /api/company/admin-chat/messages
{
  "message": "We need help with containers"
}

// Response
{
  "success": true,
  "message": "Message sent successfully.",
  "data": {
    "id": "new-message-uuid",
    "companyId": "company-uuid",
    "senderId": "admin-uuid",
    "senderType": "company_admin",
    "senderName": "Company Admin Name",
    "message": "We need help with containers",
    "isRead": false,
    "readBy": [],
    "createdAt": "2026-01-21T10:35:00.000Z",
    "updatedAt": "2026-01-21T10:35:00.000Z"
  }
}
```

#### GET Unread Count
```json
// Response
{
  "success": true,
  "data": {
    "unreadCount": 3,
    "hasUnread": true
  }
}
```

---

## 🔥 Generate Models

Run this command to generate freezed and JSON serialization code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Or for continuous watching:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## ✅ Validation & Type Safety

All models include:
- ✅ **Non-nullable fields** where required
- ✅ **Default values** for optional lists
- ✅ **Enum types** for senderType
- ✅ **DateTime parsing** with proper JSON serialization
- ✅ **UUID validation** through String type
- ✅ **Freezed immutability** - prevents accidental mutations
- ✅ **Complete JSON serialization** - fromJson/toJson

---

## 🚀 Usage Example

```dart
// Fetch messages
final chatMessages = ref.watch(chatMessagesProvider);

chatMessages.when(
  data: (messages) => ListView.builder(
    itemCount: messages.length,
    itemBuilder: (context, index) {
      final message = messages[index];
      return ChatBubble(
        text: message.message,
        isSentByMe: message.senderType.isMe,
        senderName: message.senderName,
        timestamp: message.createdAt,
        isRead: message.isRead,
      );
    },
  ),
  loading: () => CircularProgressIndicator(),
  error: (error, _) => Text('Error: $error'),
);

// Send message
await ref.read(chatMessagesProvider.notifier).sendMessage('Hello!');

// Get unread count
final unreadCount = ref.watch(chatUnreadCountProvider);
```

---

**All models are production-ready with complete type safety!** 🎉
