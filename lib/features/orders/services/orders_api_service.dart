import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/order_models.dart';

final ordersApiServiceProvider = Provider<OrdersApiService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OrdersApiService(apiService);
});

class OrdersApiService {
  final ApiService _apiService;

  OrdersApiService(this._apiService);

  // ==================== Pending Orders ====================

  Future<PendingOrdersResponse> getPendingOrders() async {
    final response = await _apiService.get('/api/company/orders/pending');
    return PendingOrdersResponse.fromJson(response.data);
  }

  // ==================== Submit Offer ====================

  Future<OfferResponse> submitOffer(SubmitOfferRequest request) async {
    // Manually construct the data to ensure proper formatting
    final data = {
      'globalOrderId': request.globalOrderId,
      'price': request.price.toString(), // Send as string
      if (request.rentalDuration != null) 'rentalDuration': request.rentalDuration,
    };
    
    final response = await _apiService.post(
      '/api/company/offers',
      data: data,
    );
    return OfferResponse.fromJson(response.data);
  }

  // ==================== Accepted Orders ====================

  Future<AcceptedOrdersResponse> getAcceptedOrders() async {
    final response = await _apiService.get('/api/company/orders/accepted');
    return AcceptedOrdersResponse.fromJson(response.data);
  }

  // ==================== Assign Driver to Order ====================

  Future<AssignDriverResponse> assignDriver({
    required String orderId,
    required AssignDriverRequest request,
  }) async {
    final response = await _apiService.patch(
      '/api/company/orders/$orderId/assign-driver',
      data: request.toJson(),
    );
    return AssignDriverResponse.fromJson(response.data);
  }

  // ==================== Sub-orders ====================

  Future<SubOrdersResponse> getSubOrders() async {
    final response = await _apiService.get('/api/company/orders/sub-orders');
    return SubOrdersResponse.fromJson(response.data);
  }

  // ==================== Assign Driver to Sub-order ====================

  Future<AssignSubOrderDriverResponse> assignSubOrderDriver({
    required String subOrderId,
    required AssignSubOrderDriverRequest request,
  }) async {
    final response = await _apiService.patch(
      '/api/company/sub-orders/$subOrderId/assign-driver',
      data: {
        'driverId': request.driverId,
        'deliveryDate': request.deliveryDate.toIso8601String(),
      },
    );
    return AssignSubOrderDriverResponse.fromJson(response.data);
  }

  // ==================== Completed Orders ====================

  Future<CompletedOrdersResponse> getCompletedOrders({
    String? containerType,
    String? containerSize,
    String? city,
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int limit = 20,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (containerType != null) queryParams['containerType'] = containerType;
    if (containerSize != null) queryParams['containerSize'] = containerSize;
    if (city != null) queryParams['city'] = city;
    if (startDate != null) {
      queryParams['startDate'] = startDate.toIso8601String();
    }
    if (endDate != null) queryParams['endDate'] = endDate.toIso8601String();

    final response = await _apiService.get(
      '/api/company/orders/completed',
      queryParameters: queryParams,
    );
    return CompletedOrdersResponse.fromJson(response.data);
  }

  // ==================== Cancelled Orders ====================

  Future<CancelledOrdersResponse> getCancelledOrders() async {
    final response = await _apiService.get('/api/company/orders/cancelled');
    return CancelledOrdersResponse.fromJson(response.data);
  }
}
