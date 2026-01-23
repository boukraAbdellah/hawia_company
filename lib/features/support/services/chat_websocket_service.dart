import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/company_chat_message.dart';
import '../../../core/config/api_config.dart';

// ==================== Chat WebSocket Service ====================

class ChatWebsocketService {
  static final ChatWebsocketService _instance = ChatWebsocketService._internal();
  static ChatWebsocketService get instance => _instance;
  factory ChatWebsocketService() => _instance;
  ChatWebsocketService._internal();

  WebSocketChannel? _channel;
  StreamController<CompanyChatMessage>? _messageController;
  Stream<CompanyChatMessage>? _messageStream;

  Timer? _reconnectTimer;
  Timer? _pingTimer;
  bool _isConnected = false;
  bool _shouldReconnect = true;
  String? _token;
  String? _companyId;
  String? _userId;
  String? _wsUrl;

  // Get message stream
  Stream<CompanyChatMessage> get messageStream {
    _messageController ??= StreamController<CompanyChatMessage>.broadcast();
    _messageStream ??= _messageController!.stream;
    return _messageStream!;
  }

  // Connect to Chat WebSocket
  Future<void> connect(String token, String companyId, String userId) async {
    _token = token;
    _companyId = companyId;
    _userId = userId;
    _wsUrl = ApiConfig.websocketUrl;
    _shouldReconnect = true;

    try {
      // Build WebSocket URL as string to avoid Uri parsing issues
      final wsUrl = '$_wsUrl?token=$token&role=company';
      debugPrint('🔌 Connecting to Chat WebSocket: $wsUrl');

      _channel = WebSocketChannel.connect(
        Uri.parse(wsUrl),
      );

      _isConnected = true;
      debugPrint('✅ Chat WebSocket connected');

      // Subscribe to company chat channel
      _subscribeToChat();

      // Start ping timer to keep connection alive
      _startPingTimer();

      // Listen to messages
      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDisconnected,
        cancelOnError: false,
      );
    } on WebSocketException catch (e) {
      debugPrint('❌ Chat WebSocket connection failed (WebSocketException): $e');
      debugPrint('   Server might not support WebSocket at this endpoint');
      _isConnected = false;
      _scheduleReconnect();
    } catch (e) {
      debugPrint('❌ Chat WebSocket connection failed: $e');
      _isConnected = false;
      _scheduleReconnect();
    }
  }

  // Subscribe to company chat
  void _subscribeToChat() {
    if (_channel == null || _companyId == null || _userId == null) return;

    try {
      final subscribeMessage = jsonEncode({
        'type': 'subscribe_company_chat',
        'companyId': _companyId,
        'userType': 'company_admin',
        'userId': 'company-admin-$_userId',
      });

      _channel!.sink.add(subscribeMessage);
      debugPrint('📡 Subscribed to company chat: $_companyId');
    } catch (e) {
      debugPrint('❌ Failed to subscribe to chat: $e');
    }
  }

  // Start ping timer
  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_isConnected && _channel != null) {
        try {
          _channel!.sink.add(jsonEncode({'type': 'ping'}));
        } catch (e) {
          debugPrint('❌ Ping failed: $e');
        }
      }
    });
  }

  // Handle incoming messages
  void _onMessage(dynamic data) {
    try {
      debugPrint('📨 Raw WebSocket message received: $data');
      final json = jsonDecode(data as String) as Map<String, dynamic>;
      final type = json['type'] as String?;
      debugPrint('📨 Message type: $type');

      if (type == 'company_chat_message') {
        // Verify this message is for our company
        final messageCompanyId = json['companyId'] as String?;
        debugPrint('📨 Message companyId: $messageCompanyId, our companyId: $_companyId');
        
        if (messageCompanyId != _companyId) {
          debugPrint('⚠️ Received message for different company, ignoring');
          return;
        }

        final messageData = json['message'] as Map<String, dynamic>;
        debugPrint('📨 Message data: $messageData');
        
        final message = CompanyChatMessage.fromJson(messageData);
        debugPrint('💬 Parsed message: ${message.message} from ${message.senderType.displayName}');
        
        _messageController?.add(message);
        debugPrint('✅ Message added to stream');
      } else if (type == 'pong') {
        // Pong response - connection is alive
        debugPrint('🏓 Pong received');
      } else if (type == 'subscribed') {
        debugPrint('✅ Successfully subscribed to chat');
      } else {
        debugPrint('⚠️ Unknown message type: $type');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Error parsing Chat WebSocket message: $e');
      debugPrint('Stack trace: $stackTrace');
      debugPrint('Raw data: $data');
    }
  }

  // Handle errors
  void _onError(error) {
    debugPrint('❌ Chat WebSocket error: $error');
    _isConnected = false;
    _pingTimer?.cancel();
    _scheduleReconnect();
  }

  // Handle disconnection
  void _onDisconnected() {
    debugPrint('🔌 Chat WebSocket disconnected');
    _isConnected = false;
    _pingTimer?.cancel();
    _scheduleReconnect();
  }

  // Schedule reconnection
  void _scheduleReconnect() {
    if (!_shouldReconnect || _token == null) return;

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (!_isConnected && _shouldReconnect && _token != null && _companyId != null && _userId != null) {
        debugPrint('🔄 Attempting to reconnect Chat WebSocket...');
        connect(_token!, _companyId!, _userId!);
      }
    });
  }

  // Unsubscribe from chat
  void _unsubscribeFromChat() {
    if (_channel == null || _companyId == null) return;

    try {
      final unsubscribeMessage = jsonEncode({
        'type': 'unsubscribe_company_chat',
        'companyId': _companyId,
      });

      _channel!.sink.add(unsubscribeMessage);
      debugPrint('📡 Unsubscribed from company chat');
    } catch (e) {
      debugPrint('❌ Failed to unsubscribe: $e');
    }
  }

  // Disconnect
  void disconnect() {
    _unsubscribeFromChat();
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _pingTimer?.cancel();
    _channel?.sink.close();
    _isConnected = false;
    _token = null;
    _companyId = null;
    _userId = null;
    _wsUrl = null;
    debugPrint('🔌 Chat WebSocket disconnected manually');
  }

  // Check connection status
  bool get isConnected => _isConnected;

  void dispose() {
    disconnect();
    _messageController?.close();
  }
}
