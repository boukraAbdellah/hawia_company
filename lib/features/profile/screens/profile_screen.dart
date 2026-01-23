import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/api_config.dart';
import '../../../core/config/app_theme.dart';
import '../providers/profile_providers.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        centerTitle: true,
        title: const Text(
          'الملف الشخصي',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            onPressed: () => _showLogoutDialog(context, ref),
          ),
        ],
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, _) => _ErrorState(
              message: error.toString().replaceAll('Exception: ', ''),
              onRetry: () => ref.refresh(profileProvider),
            ),
        data:
            (profile) => RefreshIndicator(
              onRefresh: () => ref.refresh(profileProvider.future),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // ───────────── Simple Header ─────────────
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.2),
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.grey.shade50,
                              backgroundImage: NetworkImage(
                                '${ApiConfig.baseUrl}${profile.company.logoUrl}',
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            profile.company.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _StatusBadge(status: profile.company.status),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ───────────── Info Sections ─────────────
                    _buildSectionTitle('بيانات المنشأة'),
                    _InfoCard(
                      children: [
                        _InfoRow(
                          icon:
                              Icons
                                  .fingerprint_rounded, // Better icon for identifier
                          label: 'معرف الشركة',
                          value: profile.company.domain,
                        ),
                        _Divider(),
                        _InfoRow(
                          icon: Icons.phone_android_rounded,
                          label: 'رقم التواصل',
                          value: profile.company.companyPhoneNumber,
                        ),
                        _Divider(),
                        _InfoRow(
                          icon: Icons.location_city_rounded,
                          label: 'المدينة',
                          value: profile.company.cityName,
                        ),
                      ],
                    ),

                    _buildSectionTitle('تفاصيل الحساب'),
                    _InfoCard(
                      children: [
                        _InfoRow(
                          icon: Icons.card_membership_rounded,
                          label: 'باقة الاشتراك',
                          value: _getPlanText(profile.company.plan),
                          valueColor: AppColors.primary,
                        ),
                        _Divider(),
                        _InfoRow(
                          icon: Icons.layers_outlined,
                          label: 'المستوى الحالي',
                          value: 'المستوى ${profile.company.level}',
                        ),
                        _Divider(),
                        _InfoRow(
                          icon: Icons.pie_chart_outline_rounded,
                          label: 'نسبة العمولة',
                          value: '${profile.company.commissionPercentage}%',
                        ),
                      ],
                    ),

                    _buildSectionTitle('المسؤول عن الحساب'),
                    _InfoCard(
                      children: [
                        _InfoRow(
                          icon: Icons.person_outline_rounded,
                          label: 'الاسم الكامل',
                          value: profile.adminUser.name,
                        ),
                        _Divider(),
                        _InfoRow(
                          icon: Icons.alternate_email_rounded,
                          label: 'البريد الإلكتروني',
                          value: profile.adminUser.email,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Logout Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _showLogoutDialog(context, ref),
                          icon: const Icon(Icons.logout_rounded, size: 20),
                          label: const Text(
                            'تسجيل الخروج',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text('تسجيل الخروج', textAlign: TextAlign.right),
            content: const Text(
              'هل أنت متأكد من تسجيل الخروج؟',
              textAlign: TextAlign.right,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                  Navigator.pop(context);
                },
                child: const Text('خروج', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  static String _getPlanText(String plan) {
    switch (plan) {
      case 'basic':
        return 'الأساسية';
      case 'premium':
        return 'المميزة';
      case 'enterprise':
        return 'الشركات';
      default:
        return plan;
    }
  }
}

// ─────────────────────────────────────────────
// UI Components
// ─────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = status == 'approved' ? Colors.teal : Colors.orange;
    final text = status == 'approved' ? 'موثق' : 'تحت المراجعة';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade400),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, color: Colors.grey.shade50, thickness: 1);
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.grey)),
          TextButton(onPressed: onRetry, child: const Text('إعادة المحاولة')),
        ],
      ),
    );
  }
}
