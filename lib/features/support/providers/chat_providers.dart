import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/company_chat_message.dart';
import '../models/chat_response.dart';
import '../services/chat_api_service.dart';
import '../services/chat_websocket_service.dart';

// ==================== Service Providers ====================

/// Chat API Service Provider
final chatApiServiceProvider = Provider<ChatApiService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ChatApiService(apiService.dio);
});

/// Chat WebSocket Service Provider  
final chatWebsocketServiceProvider = Provider<ChatWebsocketService>((ref) {
  return ChatWebsocketService.instance;
});

// ==================== Chat State ====================

/// Chat State Model
class ChatState {
  final List<CompanyChatMessage> messages;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isSendingMessage;
  final String? error;
  final int unreadCount;
  final bool isConnected;
  final ChatPagination? pagination;
  final int currentPage;
  final bool hasMorePages;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isSendingMessage = false,
    this.error,
    this.unreadCount = 0,
    this.isConnected = false,
    this.pagination,
    this.currentPage = 1,
    this.hasMorePages = false,
  });

  ChatState copyWith({
    List<CompanyChatMessage>? messages,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isSendingMessage,
    String? error,
    int? unreadCount,
    bool? isConnected,
    ChatPagination? pagination,
    int? currentPage,
    bool? hasMorePages,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSendingMessage: isSendingMessage ?? this.isSendingMessage,
      error: error,
      unreadCount: unreadCount ?? this.unreadCount,
      isConnected: isConnected ?? this.isConnected,
      pagination: pagination ?? this.pagination,
      currentPage: currentPage ?? this.currentPage,
      hasMorePages: hasMorePages ?? this.hasMorePages,
    );
  }
}

// ==================== Chat Notifier ====================

class ChatNotifier extends StateNotifier<ChatState> {
  final ChatApiService _apiService;
  final ChatWebsocketService _websocketService;
  final String _companyId;
  final String _userId;
  final String _token;
  StreamSubscription<CompanyChatMessage>? _messageSubscription;
  final Set<String> _processedMessageIds = {};
  bool _skipInitialization = false;

  ChatNotifier(
    this._apiService,
    this._websocketService,
    this._companyId,
    this._userId,
    this._token,
  ) : super(const ChatState()) {
    if (!_skipInitialization && _token.isNotEmpty) {
      _initialize();
    }
  }

  Future<void> _initialize() async {
    // Connect WebSocket
    await _connectWebSocket();

    // Load initial messages
    await loadMessages();

    // Mark messages as read
    await markAsRead();
  }

  Future<void> _connectWebSocket() async {
    try {
      print('🔌 Connecting chat WebSocket for company: $_companyId, user: $_userId');
      await _websocketService.connect(_token, _companyId, _userId);
      state = state.copyWith(isConnected: _websocketService.isConnected);
      print('✅ WebSocket connected: ${_websocketService.isConnected}');

      // Listen to WebSocket messages
      _messageSubscription?.cancel(); // Cancel previous subscription if any
      _messageSubscription = _websocketService.messageStream.listen(
        _handleWebSocketMessage,
        onError: (error) {
          print('❌ Chat WebSocket stream error: $error');
        },
        onDone: () {
          print('⚠️ Chat WebSocket stream closed');
        },
      );
      print('📡 Listening to WebSocket message stream');
    } catch (e) {
      print('❌ Failed to connect chat WebSocket: $e');
    }
  }

  void _handleWebSocketMessage(CompanyChatMessage message) {
    print('📥 Received WebSocket message: ${message.message} from ${message.senderType.displayName}');
    
    // Ignore our own messages from WebSocket - they're already added via API response
    if (message.senderType == SenderType.companyAdmin) {
      print('⚠️ Ignoring company admin message from WebSocket (already handled by API)');
      return;
    }
    
    // Prevent duplicate messages - use just the ID since companyId might be null
    final messageKey = message.id;
    if (_processedMessageIds.contains(messageKey)) {
      print('⚠️ Duplicate message detected (already processed), skipping: ${message.id}');
      return;
    }

    // Check if message already exists in state (before removing temps)
    final exists = state.messages.any((m) => m.id == message.id);
    if (exists) {
      print('⚠️ Message already exists in state, skipping: ${message.id}');
      return;
    }

    _processedMessageIds.add(messageKey);
    print('✅ Processing new message: ${message.id}');

    // Remove temp messages (if any)
    final updatedMessages = state.messages
        .where((m) => !m.id.startsWith('temp-'))
        .toList();

    print('➕ Adding message to state');
    
    // Fill in missing companyId if needed
    final completeMessage = message.companyId == null 
        ? message.copyWith(companyId: _companyId)
        : message;
    
    updatedMessages.add(completeMessage);
    updatedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    state = state.copyWith(messages: updatedMessages);
    print('✅ State updated with ${updatedMessages.length} messages');

    // Mark as read if from super admin
    if (message.senderType == SenderType.superAdmin) {
      markAsRead();
    }

    // Clear processed message after 10 seconds
    Future.delayed(const Duration(seconds: 10), () {
      _processedMessageIds.remove(messageKey);
    });
  }

  /// Load messages from API
  Future<void> loadMessages({int page = 1, int limit = 50}) async {
    if (page == 1) {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      final response = await _apiService.getChatMessages(page: page, limit: limit);
      
      final sortedMessages = List<CompanyChatMessage>.from(response.data.messages)
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

      final hasMore = response.data.pagination.page < response.data.pagination.totalPages;

      state = state.copyWith(
        messages: sortedMessages,
        pagination: response.data.pagination,
        currentPage: page,
        hasMorePages: hasMore,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'فشل تحميل الرسائل: ${e.toString()}',
      );
      print('❌ Error loading messages: $e');
    }
  }

  /// Load more (older) messages
  Future<void> loadMoreMessages() async {
    if (state.isLoadingMore || !state.hasMorePages) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final response = await _apiService.getChatMessages(page: nextPage, limit: 50);
      
      final newMessages = List<CompanyChatMessage>.from(response.data.messages);
      
      // Prepend older messages to the beginning
      final allMessages = [...newMessages, ...state.messages];
      allMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      final hasMore = response.data.pagination.page < response.data.pagination.totalPages;

      state = state.copyWith(
        messages: allMessages,
        pagination: response.data.pagination,
        currentPage: nextPage,
        hasMorePages: hasMore,
        isLoadingMore: false,
      );
      
      print('✅ Loaded page $nextPage, total messages: ${allMessages.length}, hasMore: $hasMore');
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
      );
      print('❌ Error loading more messages: $e');
    }
  }

  /// Send a message
  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    // Create temporary message for optimistic UI
    final tempMessage = CompanyChatMessage(
      id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
      companyId: _companyId,
      senderId: _userId,
      senderType: SenderType.companyAdmin,
      senderName: 'أنت',
      message: trimmed,
      isRead: false,
      readBy: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Add temp message to state
    final updatedMessages = [...state.messages, tempMessage];
    state = state.copyWith(
      messages: updatedMessages,
      isSendingMessage: true,
      error: null,
    );

    try {
      // Send via API and get the real message back
      final response = await _apiService.sendMessage(trimmed);
      final realMessage = response.data;
      
      // Mark as processed IMMEDIATELY to prevent WebSocket duplicate
      final messageKey = realMessage.id;
      _processedMessageIds.add(messageKey);
      
      // Replace temp message with real message
      final messagesWithoutTemp = state.messages
          .where((m) => m.id != tempMessage.id)
          .toList();
      
      messagesWithoutTemp.add(realMessage);
      messagesWithoutTemp.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      
      state = state.copyWith(
        messages: messagesWithoutTemp,
        isSendingMessage: false,
      );
      
      // Clear after 10 seconds
      Future.delayed(const Duration(seconds: 10), () {
        _processedMessageIds.remove(messageKey);
      });
    } catch (e) {
      // Remove temp message on error
      final messagesWithoutTemp = state.messages
          .where((m) => m.id != tempMessage.id)
          .toList();
      
      state = state.copyWith(
        messages: messagesWithoutTemp,
        isSendingMessage: false,
        error: 'فشل إرسال الرسالة: ${e.toString()}',
      );
      print('❌ Error sending message: $e');
      rethrow;
    }
  }

  /// Mark all messages as read
  Future<void> markAsRead() async {
    try {
      await _apiService.markAllAsRead();
      
      // Update unread count
      state = state.copyWith(unreadCount: 0);
    } catch (e) {
      print('❌ Error marking messages as read: $e');
    }
  }

  /// Load unread count
  Future<void> loadUnreadCount() async {
    try {
      final data = await _apiService.getUnreadCount();
      state = state.copyWith(unreadCount: data.unreadCount);
    } catch (e) {
      print('❌ Error loading unread count: $e');
    }
  }

  /// Refresh messages
  Future<void> refresh() async {
    await loadMessages(page: 1);
    await markAsRead();
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    _websocketService.disconnect();
    super.dispose();
  }
}

// ==================== Chat Provider ====================

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final authState = ref.watch(authProvider);

  // Return empty state if not authenticated
  if (!authState.isAuthenticated || 
      authState.user == null || 
      authState.company == null || 
      authState.token == null) {
    // Create a dummy notifier that won't initialize
    return ChatNotifier(
      ref.watch(chatApiServiceProvider),
      ref.watch(chatWebsocketServiceProvider),
      '', // empty company ID
      '', // empty user ID
      '', // empty token
    ).._skipInitialization = true;
  }

  return ChatNotifier(
    ref.watch(chatApiServiceProvider),
    ref.watch(chatWebsocketServiceProvider),
    authState.company!.id,
    authState.user!.id,
    authState.token!,
  );
});
