import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/services/api_service.dart';
import '../models/profile_models.dart';
import '../services/profile_api_service.dart';

// API Service Provider
final profileApiServiceProvider = Provider<ProfileApiService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ProfileApiService(apiService);
});

// Profile State Provider
final profileProvider =
    FutureProvider.autoDispose<ProfileResponse>((ref) async {
  final apiService = ref.watch(profileApiServiceProvider);
  return apiService.getProfile();
});
