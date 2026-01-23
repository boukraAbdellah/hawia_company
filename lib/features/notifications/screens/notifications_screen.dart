import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/notification_models.dart';
import '../providers/notification_providers.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'الطلبات', icon: Icon(Icons.shopping_cart, size: 20)),
            Tab(text: 'الرسائل والتقييمات', icon: Icon(Icons.message, size: 20)),
          ],
          onTap: (index) {
            // Load data when tab is tapped if not loaded yet
            if (index == 0) {
              final state = ref.read(adminNotificationsProvider);
              if (state.notifications.isEmpty && !state.isLoading) {
                ref.read(adminNotificationsProvider.notifier).loadNotifications();
              }
            } else {
              final state = ref.read(generalNotificationsProvider);
              if (state.notifications.isEmpty && !state.isLoading) {
                ref.read(generalNotificationsProvider.notifier).loadNotifications();
              }
            }
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _OrderNotificationsTab(),
          _GeneralNotificationsTab(),
        ],
      ),
    );
  }
}

// ==================== Order Notifications Tab ====================

class _OrderNotificationsTab extends ConsumerStatefulWidget {
  const _OrderNotificationsTab();

  @override
  ConsumerState<_OrderNotificationsTab> createState() => _OrderNotificationsTabState();
}

class _OrderNotificationsTabState extends ConsumerState<_OrderNotificationsTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load data on init AND refresh unread count
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adminNotificationsProvider.notifier).loadNotifications();
      // ⚠️ CRITICAL: Refresh unread count when entering screen
      ref.read(unreadCountProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      ref.read(adminNotificationsProvider.notifier).loadMore();
    }
  }

  Future<void> _onRefresh() async {
    await ref.read(adminNotificationsProvider.notifier).loadNotifications(refresh: true);
    ref.read(unreadCountProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminNotificationsProvider);

    if (state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                state.error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => ref.read(adminNotificationsProvider.notifier).loadNotifications(),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.notifications.isEmpty && !state.isLoading) {
      return _buildEmptyState('لا توجد إشعارات طلبات');
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: state.notifications.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.notifications.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final notification = state.notifications[index];
          return _OrderNotificationCard(
            notification: notification,
            onTap: () => _onNotificationTap(notification),
            onDelete: () => _onNotificationDelete(notification.id),
          );
        },
      ),
    );
  }

  void _onNotificationTap(CompanyNotification notification) async {
    if (!notification.isRead) {
      await ref.read(adminNotificationsProvider.notifier).markAsRead(notification.id);
      ref.read(unreadCountProvider.notifier).decrementCount();
    }

    if (notification.globalOrderId != null) {
      context.push('/orders/${notification.globalOrderId}');
    }
  }

  void _onNotificationDelete(String notificationId) async {
    await ref.read(adminNotificationsProvider.notifier).deleteNotification(notificationId);
  }
}

// ==================== General Notifications Tab ====================

class _GeneralNotificationsTab extends ConsumerStatefulWidget {
  const _GeneralNotificationsTab();

  @override
  ConsumerState<_GeneralNotificationsTab> createState() => _GeneralNotificationsTabState();
}

class _GeneralNotificationsTabState extends ConsumerState<_GeneralNotificationsTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(generalNotificationsProvider.notifier).loadNotifications();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      ref.read(generalNotificationsProvider.notifier).loadMore();
    }
  }

  Future<void> _onRefresh() async {
    await ref.read(generalNotificationsProvider.notifier).loadNotifications(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(generalNotificationsProvider);

    if (state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                state.error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => ref.read(generalNotificationsProvider.notifier).loadNotifications(),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.notifications.isEmpty && !state.isLoading) {
      return _buildEmptyState('لا توجد رسائل أو تقييمات');
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: state.notifications.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.notifications.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final notification = state.notifications[index];
          return _GeneralNotificationCard(
            notification: notification,
          );
        },
      ),
    );
  }
}

Widget _buildEmptyState(String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.notifications_none_outlined,
          size: 80,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 16),
        Text(
          message,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ستظهر الإشعارات الجديدة هنا',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
      ],
    ),
  );
}

// ==================== Order Notification Card Widget ====================

class _OrderNotificationCard extends StatelessWidget {
  final CompanyNotification notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _OrderNotificationCard({
    required this.notification,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final typeInfo = notification.typeInfo;
    final isUnread = !notification.isRead;

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUnread ? typeInfo.color.withOpacity(0.05) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isUnread ? typeInfo.color.withOpacity(0.3) : Colors.grey[300]!,
              width: isUnread ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: typeInfo.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  notification.subOrderIcon,
                  color: typeInfo.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.subOrderDisplayName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isUnread ? FontWeight.w600 : FontWeight.w500,
                              color: typeInfo.color,
                            ),
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: typeInfo.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.message,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                    if (notification.globalOrder != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (notification.globalOrder!.orderNumber != null) ...[
                              Row(
                                children: [
                                  Icon(Icons.receipt_long, size: 14, color: Colors.grey[700]),
                                  const SizedBox(width: 4),
                                  Text(
                                    'طلب #${notification.globalOrder!.orderNumber}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (notification.globalOrder!.containerType != null || 
                                notification.globalOrder!.containerSize != null) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.inventory_2_outlined, size: 14, color: Colors.grey[700]),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${notification.globalOrder!.containerType ?? ''} - ${notification.globalOrder!.containerSize ?? ''}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (notification.globalOrder!.deliveryLocation != null) ...[
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[700]),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      notification.globalOrder!.deliveryLocation!.address,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      _formatDateTime(notification.createdAt),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) {
      return 'الآن';
    } else if (diff.inHours < 1) {
      return 'منذ ${diff.inMinutes} دقيقة';
    } else if (diff.inDays < 1) {
      return 'منذ ${diff.inHours} ساعة';
    } else if (diff.inDays == 1) {
      return 'أمس';
    } else if (diff.inDays < 7) {
      return 'منذ ${diff.inDays} أيام';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}

// ==================== General Notification Card Widget ====================

class _GeneralNotificationCard extends StatelessWidget {
  final AdminNotification notification;

  const _GeneralNotificationCard({
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final typeInfo = notification.typeInfo;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: typeInfo.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              typeInfo.icon,
              color: typeInfo.color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatDateTime(notification.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) {
      return 'الآن';
    } else if (diff.inHours < 1) {
      return 'منذ ${diff.inMinutes} دقيقة';
    } else if (diff.inDays < 1) {
      return 'منذ ${diff.inHours} ساعة';
    } else if (diff.inDays == 1) {
      return 'أمس';
    } else if (diff.inDays < 7) {
      return 'منذ ${diff.inDays} أيام';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
