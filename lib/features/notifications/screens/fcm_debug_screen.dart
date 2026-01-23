import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/fcm_service.dart';
import '../providers/notification_providers.dart';

class FCMDebugScreen extends ConsumerStatefulWidget {
  const FCMDebugScreen({super.key});

  @override
  ConsumerState<FCMDebugScreen> createState() => _FCMDebugScreenState();
}

class _FCMDebugScreenState extends ConsumerState<FCMDebugScreen> {
  final List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _addLog('🔍 FCM Debug Screen Initialized');
    _checkFCMStatus();
  }

  void _addLog(String message) {
    setState(() {
      _logs.insert(0, '${DateTime.now().toString().split('.')[0]}: $message');
    });
    debugPrint(message);
  }

  Future<void> _checkFCMStatus() async {
    _addLog('📱 Checking FCM Token...');
    final token = FCMService().fcmToken;
    if (token != null) {
      _addLog('✅ FCM Token: ${token.substring(0, 20)}...');
    } else {
      _addLog('❌ FCM Token: NULL');
    }

    _addLog('📊 Checking Unread Count...');
    final count = ref.read(unreadCountProvider);
    _addLog('✅ Unread Count: $count');

    _addLog('📥 Checking Notifications...');
    final notifications = ref.read(adminNotificationsProvider);
    _addLog('✅ Notifications Loaded: ${notifications.notifications.length}');
  }

  Future<void> _refreshAll() async {
    _addLog('🔄 Refreshing all data...');
    await ref.read(adminNotificationsProvider.notifier).loadNotifications(refresh: true);
    await ref.read(unreadCountProvider.notifier).refresh();
    _addLog('✅ Refresh complete');
  }

  @override
  Widget build(BuildContext context) {
    final fcmToken = FCMService().fcmToken ?? 'Token not available';
    final unreadCount = ref.watch(unreadCountProvider);
    final notificationState = ref.watch(adminNotificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FCM Debug'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshAll,
          ),
        ],
      ),
      body: Column(
        children: [
          // Status Cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // FCM Token Card
                _buildStatusCard(
                  title: '📱 FCM Token',
                  content: fcmToken,
                  color: fcmToken.contains('not available') ? Colors.red : Colors.green,
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: fcmToken));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Token copied to clipboard')),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Unread Count Card
                _buildStatusCard(
                  title: '🔔 Unread Count',
                  content: unreadCount.toString(),
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),

                // Notifications Count Card
                _buildStatusCard(
                  title: '📥 Total Notifications',
                  content: notificationState.notifications.length.toString(),
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),

                // Instructions Card
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '📋 Test Instructions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('1. Copy FCM Token above'),
                        const Text('2. Give token to backend developer'),
                        const Text('3. Send test notification from server'),
                        const Text('4. Watch logs below for incoming messages'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _refreshAll,
                          child: const Text('Refresh Data'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Logs Section
                const Text(
                  '📜 Debug Logs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // Logs Display
          Container(
            height: 300,
            color: Colors.grey.shade900,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    _logs[index],
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String content,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Card(
      color: color.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: color.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              if (onTap != null)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Tap to copy',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
