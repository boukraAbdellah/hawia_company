import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import '../../../core/config/app_theme.dart';
import '../providers/chat_providers.dart';
import '../models/company_chat_message.dart';

class SupportScreen extends ConsumerStatefulWidget {
  const SupportScreen({super.key});

  @override
  ConsumerState<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends ConsumerState<SupportScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _shouldScrollToBottom = true;
  bool _isLoadingMore = false;
  bool _isInitialized = false; // ← NEW: prevents load-more on initial render

  double? _previousMaxScrollExtent;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);

    // Initial jump to bottom + mark as initialized after positioning
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        if (mounted) {
          setState(() {
            _isInitialized =
                true; // ← NEW: now allow loading more when scrolling up
          });
        }
      }
    });
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;

    final pos = _scrollController.position;
    final nearBottom = pos.pixels >= pos.maxScrollExtent - 150;
    final nearTop = pos.pixels <= pos.minScrollExtent + 300;

    // Update auto-scroll flag
    if (nearBottom != _shouldScrollToBottom) {
      setState(() => _shouldScrollToBottom = nearBottom);
    }

    // Prevent loading more until after initial positioning
    if (!_isInitialized) return;

    final chatNotifier = ref.read(chatProvider.notifier);
    if (nearTop && !_isLoadingMore && chatNotifier.state.hasMorePages) {
      _isLoadingMore = true;
      _previousMaxScrollExtent = pos.maxScrollExtent;

      chatNotifier.loadMoreMessages().whenComplete(() {
        if (mounted) {
          _isLoadingMore = false;
          _adjustScrollAfterLoadMore();
        }
      });
    }
  }

  void _adjustScrollAfterLoadMore() {
    if (!_scrollController.hasClients || _previousMaxScrollExtent == null)
      return;

    final newMax = _scrollController.position.maxScrollExtent;
    final addedHeight = newMax - _previousMaxScrollExtent!;

    if (addedHeight > 0) {
      _scrollController.jumpTo(_scrollController.offset + addedHeight);
    }

    _previousMaxScrollExtent = null;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom({bool animate = true}) {
    if (!_scrollController.hasClients) return;

    final target = _scrollController.position.maxScrollExtent;

    if (animate) {
      _scrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.jumpTo(target);
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();

    try {
      await ref.read(chatProvider.notifier).sendMessage(text);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تعذر إرسال الرسالة')));
    }
  }

  String _formatMessageTime(DateTime time) {
    return intl.DateFormat('HH:mm', 'ar').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);

    // Auto-scroll on new messages (only if user was near bottom)
    ref.listen(chatProvider, (previous, next) {
      if (previous == null) return;

      if (next.messages.length > previous.messages.length &&
          _shouldScrollToBottom) {
        _scrollToBottom(animate: true);
      }
    });

    final showLoadingHeader = chatState.hasMorePages && chatState.isLoadingMore;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('الدعم الفني', style: TextStyle(fontSize: 18)),
      ),
      body:
          chatState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      itemCount:
                          chatState.messages.length +
                          (showLoadingHeader ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (showLoadingHeader && index == 0) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final msgIndex = showLoadingHeader ? index - 1 : index;
                        if (msgIndex >= chatState.messages.length) {
                          return const SizedBox.shrink();
                        }

                        final msg = chatState.messages[msgIndex];
                        final isSupport =
                            msg.senderType == SenderType.superAdmin;

                        return _MessageBubble(
                          message: msg,
                          isSupport: isSupport,
                          time: _formatMessageTime(msg.createdAt),
                        );
                      },
                    ),
                  ),
                  _buildInputBar(chatState.isSendingMessage),
                ],
              ),
    );
  }

  Widget _buildInputBar(bool isSending) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                textDirection: TextDirection.rtl,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'اكتب رسالتك...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: const Color(0xFFF7F9FC),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Material(
              color:
                  isSending
                      ? AppColors.primary.withOpacity(0.5)
                      : AppColors.primary,
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                onTap: isSending ? null : _sendMessage,
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  child:
                      isSending
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final CompanyChatMessage message;
  final bool isSupport;
  final String time;

  const _MessageBubble({
    required this.message,
    required this.isSupport,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isSupport ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isSupport) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(
                Icons.support_agent,
                size: 16,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isSupport ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                if (isSupport)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      'الدعم الفني',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSupport ? const Color(0xFFE4E6EB) : AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    message.message,
                    style: TextStyle(
                      color: isSupport ? Colors.black87 : Colors.white,
                      fontSize: 14,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
