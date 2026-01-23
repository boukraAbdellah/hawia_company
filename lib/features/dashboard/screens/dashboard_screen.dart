import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/container_stats_card.dart';
import '../widgets/order_stats_card.dart';
import '../widgets/driver_stats_card.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch dashboard stats on screen load
    Future.microtask(
        () => ref.read(dashboardProvider.notifier).fetchDashboardStats());
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            tooltip: 'FCM Debug',
            onPressed: () => context.push('/fcm-debug'),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(dashboardProvider.notifier).refresh(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
        child: dashboardState.isLoading && dashboardState.stats == null
            ? const Center(child: CircularProgressIndicator())
            : dashboardState.error != null && dashboardState.stats == null
                ? _ErrorView(
                    error: dashboardState.error!,
                    onRetry: () => ref
                        .read(dashboardProvider.notifier)
                        .fetchDashboardStats(),
                  )
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        if (dashboardState.stats?.containerStats != null)
                          ContainerStatsCard(
                              stats: dashboardState.stats!.containerStats),
                        const SizedBox(height: 16),
                        if (dashboardState.stats?.orderStats != null)
                          OrderStatsCard(
                              stats: dashboardState.stats!.orderStats),
                        const SizedBox(height: 16),
                        if (dashboardState.stats?.driverStats != null)
                          DriverStatsCard(
                              stats: dashboardState.stats!.driverStats),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'خطأ في تحميل البيانات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}
