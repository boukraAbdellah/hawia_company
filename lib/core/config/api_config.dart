class ApiConfig {
  static const String baseUrl = 'https://hawiacom.com';
  // static const String baseUrl = 'http://10.118.44.175:3000';
  
  // WebSocket URL
  static const String websocketUrl = 'wss://hawiacom.com/ws';
  // static const String websocketUrl = 'ws://10.118.44.175:3000/ws';
  
  // API Endpoints
  static const String login = '/api/company/auth/admin/login';
  static const String sendVerification = '/api/company/send-verification';
  static const String verifyEmail = '/api/company/verify-email';
  static const String register = '/api/company/register';
  
  // Timeouts (reduced for faster response)
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
