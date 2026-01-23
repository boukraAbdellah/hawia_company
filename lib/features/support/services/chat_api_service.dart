import 'package:dio/dio.dart';
import '../models/chat_response.dart';

class ChatApiService {
  final Dio _dio;

  ChatApiService(this._dio);

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
        '/api/company/admin-chat/messages',
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
        '/api/company/admin-chat/messages',
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
      final response = await _dio.get('/api/company/admin-chat/unread-count');
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
      await _dio.patch('/api/company/admin-chat/mark-read');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ==================== Error Handling ====================

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final message = e.response?.data['message'] ?? 'حدث خطأ غير متوقع';
      return Exception(message);
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return Exception('انتهت مهلة الاتصال - تحقق من الإنترنت');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return Exception('استغرق الخادم وقتًا طويلاً للرد');
    } else {
      return Exception('خطأ في الشبكة: ${e.message}');
    }
  }
}
