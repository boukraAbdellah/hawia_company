import 'package:dio/dio.dart';
import '../../../core/services/api_service.dart';
import '../models/profile_models.dart';

class ProfileApiService {
  final ApiService _apiService;

  ProfileApiService(this._apiService);

  Future<ProfileResponse> getProfile() async {
    try {
      final response = await _apiService.dio.get('/api/company/profile');
      return ProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'فشل في تحميل معلومات الحساب',
      );
    }
  }
}
