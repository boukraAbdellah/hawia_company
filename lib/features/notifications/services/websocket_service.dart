import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/notification_models.dart';
import '../../../core/config/api_config.dart';

// ==================== WebSocket Service ====================

class WebsocketService {
  static final WebsocketService _instance = WebsocketService._internal();
  static WebsocketService get instance => _instance;
  factory WebsocketService() => _instance;
  WebsocketService._internal();

  WebSocketChannel? _channel;
  StreamController<CompanyNotification>? _notificationController;
  Stream<CompanyNotification>? _notificationStream;

  Timer? _reconnectTimer;
  Timer? _pingTimer;
  bool _isConnected = false;
  bool _shouldReconnect = true;
  String? _token;
  String? _wsUrl;

  // Get notification stream
  Stream<CompanyNotification> get notificationStream {
    _notificationController ??= StreamController<CompanyNotification>.broadcast();
    _notificationStream ??= _notificationController!.stream;
    return _notificationStream!;
  }

  // Connect to WebSocket
  Future<void> connect(String token) async {
    _token = token;
    _wsUrl = ApiConfig.websocketUrl;
    _shouldReconnect = true;

    try {
      // Build WebSocket URL as string to avoid Uri parsing issues
      final wsUrl = '$_wsUrl?token=$token&role=company';
      debugPrint('🔌 Connecting to WebSocket: $wsUrl');

      _channel = WebSocketChannel.connect(
        Uri.parse(wsUrl),
      );

      _isConnected = true;
      debugPrint('✅ WebSocket connected');

      // Start ping timer to keep connection alive
      _startPingTimer();

      // Listen to messages
      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDisconnected,
        cancelOnError: false,
      );
    } catch (e) {
      debugPrint('❌ WebSocket connection failed: $e');
      _isConnected = false;
      _scheduleReconnect();
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
      final json = jsonDecode(data as String) as Map<String, dynamic>;
      final type = json['type'] as String?;

      if (type == 'new_notification') {
        final notificationData = json['notification'] as Map<String, dynamic>;
        final notification = CompanyNotification.fromJson(notificationData);
        _notificationController?.add(notification);
        debugPrint('📬 New notification received: ${notification.title}');
      } else if (type == 'pong') {
        // Pong response - connection is alive
        debugPrint('🏓 Pong received');
      }
    } catch (e) {
      debugPrint('❌ Error parsing WebSocket message: $e');
    }
  }

  // Handle errors
  void _onError(error) {
    debugPrint('❌ WebSocket error: $error');
    _isConnected = false;
    _pingTimer?.cancel();
    _scheduleReconnect();
  }

  // Handle disconnection
  void _onDisconnected() {
    debugPrint('🔌 WebSocket disconnected');
    _isConnected = false;
    _pingTimer?.cancel();
    _scheduleReconnect();
  }

  // Schedule reconnection
  void _scheduleReconnect() {
    if (!_shouldReconnect || _token == null) return;

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (!_isConnected && _shouldReconnect && _token != null) {
        debugPrint('🔄 Attempting to reconnect WebSocket...');
        connect(_token!);
      }
    });
  }

  // Disconnect
  void disconnect() {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _pingTimer?.cancel();
    _channel?.sink.close();
    _isConnected = false;
    _token = null;
    _wsUrl = null;
    debugPrint('🔌 WebSocket disconnected manually');
  }

  // Check connection status
  bool get isConnected => _isConnected;

  void dispose() {
    disconnect();
    _notificationController?.close();
  }
}
