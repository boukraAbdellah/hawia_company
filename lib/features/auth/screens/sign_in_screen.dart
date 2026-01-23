import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../models/auth_state.dart';
import '../models/ban_details.dart';
import '../widgets/custom_text_field.dart';
import '../../../shared/widgets/loading_button.dart';
import '../../../core/config/app_theme.dart';
import '../../../core/services/storage_service.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _domainController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _hasSavedCredentials = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final savedDomain = await StorageService.getData('saved_domain');
    final savedEmail = await StorageService.getData('saved_email');
    final savedPassword = await StorageService.getData('saved_password');
    final rememberMe = await StorageService.getData('remember_me');

    if (rememberMe == 'true' && savedDomain != null && savedEmail != null && savedPassword != null) {
      // Pre-fill the form with saved credentials (like Facebook)
      setState(() {
        _domainController.text = savedDomain;
        _emailController.text = savedEmail;
        _passwordController.text = savedPassword;
        _rememberMe = true;
        _hasSavedCredentials = true;
      });
    }
  }

  void _clearSavedCredentials() {
    setState(() {
      _domainController.clear();
      _emailController.clear();
      _passwordController.clear();
      _rememberMe = false;
      _hasSavedCredentials = false;
    });
  }

  @override
  void dispose() {
    _domainController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      // Save credentials if remember me is checked
      if (_rememberMe) {
        await StorageService.saveData('saved_domain', _domainController.text.trim());
        await StorageService.saveData('saved_email', _emailController.text.trim());
        await StorageService.saveData('saved_password', _passwordController.text);
        await StorageService.saveData('remember_me', 'true');
      } else {
        // Clear saved credentials if not checked
        await StorageService.deleteData('saved_domain');
        await StorageService.deleteData('saved_email');
        await StorageService.deleteData('saved_password');
        await StorageService.deleteData('remember_me');
      }
      
      await ref.read(authProvider.notifier).login(
            _domainController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isAuthenticated) {
        context.go('/dashboard');
      } else if (next.error != null && next.banDetails == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!, textDirection: TextDirection.rtl),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // Title
                const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                
                const SizedBox(height: 8),
                
                const Text(
                  'مرحباً بك مرة أخرى',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                
                const SizedBox(height: 40),
                
                // Saved Account Indicator
                if (_hasSavedCredentials)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.account_circle, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'حساب محفوظ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                _emailController.text,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: _clearSavedCredentials,
                          child: const Text(
                            'استخدام حساب آخر',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // Ban Details Card (if banned)
                if (authState.banDetails != null)
                  _BanDetailsCard(banDetails: authState.banDetails!),
                
                // Domain Field
                CustomTextField(
                  label: 'الرقم التعريفي للشركة',
                  hint: '0123456789',
                  controller: _domainController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الرقم التعريفي';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Email Field
                CustomTextField(
                  label: 'البريد الإلكتروني للمسؤول',
                  hint: 'أدخل البريد الإلكتروني',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال البريد الإلكتروني';
                    }
                    if (!value.contains('@')) {
                      return 'الرجاء إدخال بريد إلكتروني صحيح';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Password Field
                CustomTextField(
                  label: 'كلمة سر المسؤول',
                  hint: 'أدخل كلمة المرور',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال كلمة المرور';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Remember Me Checkbox
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() => _rememberMe = value ?? false);
                      },
                      activeColor: AppColors.primary,
                    ),
                    const Text(
                      'حفظ معلومات الدخول',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Sign In Button
                LoadingButton(
                  text: 'تسجيل الدخول',
                  isLoading: authState.isLoading,
                  onPressed: _handleSignIn,
                ),
                
                const SizedBox(height: 24),
                
                // Sign Up Link
                Center(
                  child: GestureDetector(
                    onTap: () => context.go('/signup'),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        children: [
                          TextSpan(text: 'ليس لديك حساب؟ '),
                          TextSpan(
                            text: 'إنشاء حساب جديد',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Ban Details Card Widget
class _BanDetailsCard extends StatelessWidget {
  final BanDetails banDetails;

  const _BanDetailsCard({required this.banDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: banDetails.isPermanent ? Colors.red[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: banDetails.isPermanent ? Colors.red : Colors.orange,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with ban icon
          Row(
            children: [
              Icon(
                Icons.block,
                color: banDetails.isPermanent ? Colors.red : Colors.orange,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                banDetails.isPermanent ? 'حظر دائم' : 'حظر مؤقت',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: banDetails.isPermanent ? Colors.red[900] : Colors.orange[900],
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Duration (if temporary)
          if (!banDetails.isPermanent && banDetails.expiryMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                banDetails.expiryMessage!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),

          // Reason
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'سبب الحظر:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 4),
              Text(
                banDetails.reason,
                style: const TextStyle(fontSize: 14),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
