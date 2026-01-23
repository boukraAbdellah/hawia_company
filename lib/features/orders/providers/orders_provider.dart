import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_models.dart';
import '../services/orders_api_service.dart';

// ==================== Pending Orders Provider ====================

final pendingOrdersProvider =
    StateNotifierProvider<PendingOrdersNotifier, PendingOrdersState>((ref) {
  return PendingOrdersNotifier(ref);
});

class PendingOrdersState {
  final List<PendingOrder> orders;
  final bool isLoading;
  final String? error;

  PendingOrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  PendingOrdersState copyWith({
    List<PendingOrder>? orders,
    bool? isLoading,
    String? error,
  }) {
    return PendingOrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class PendingOrdersNotifier extends StateNotifier<PendingOrdersState> {
  final Ref _ref;

  PendingOrdersNotifier(this._ref) : super(PendingOrdersState()) {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final apiService = _ref.read(ordersApiServiceProvider);
      final response = await apiService.getPendingOrders();

      state = state.copyWith(
        orders: response.orders,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      debugPrint('❌ Error fetching pending orders: $e');
      debugPrint('Stack trace: $stackTrace');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> submitOffer(SubmitOfferRequest request) async {
    try {
      debugPrint('📤 Submitting offer with data:');
      debugPrint('   globalOrderId: ${request.globalOrderId}');
      debugPrint('   price: ${request.price}');
      debugPrint('   rentalDuration: ${request.rentalDuration}');
      debugPrint('   JSON: ${request.toJson()}');
      
      final apiService = _ref.read(ordersApiServiceProvider);
      await apiService.submitOffer(request);

      // Refresh pending orders to update applied status
      await fetchOrders();
      return true;
    } catch (e, stackTrace) {
      debugPrint('❌ Error submitting offer: $e');
      debugPrint('📋 Stack trace: $stackTrace');
      rethrow; // Re-throw to get the error in the dialog
    }
  }
}

// ==================== Accepted Orders Provider ====================

final acceptedOrdersProvider =
    StateNotifierProvider<AcceptedOrdersNotifier, AcceptedOrdersState>((ref) {
  return AcceptedOrdersNotifier(ref);
});

class AcceptedOrdersState {
  final List<AcceptedOrder> orders;
  final bool isLoading;
  final String? error;

  AcceptedOrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  AcceptedOrdersState copyWith({
    List<AcceptedOrder>? orders,
    bool? isLoading,
    String? error,
  }) {
    return AcceptedOrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<AcceptedOrder> get ordersWithoutDriver =>
      orders.where((o) => o.driverId == null).toList();

  List<AcceptedOrder> get ordersWithDriver =>
      orders.where((o) => o.driverId != null).toList();
}

class AcceptedOrdersNotifier extends StateNotifier<AcceptedOrdersState> {
  final Ref _ref;

  AcceptedOrdersNotifier(this._ref) : super(AcceptedOrdersState()) {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final apiService = _ref.read(ordersApiServiceProvider);
      final response = await apiService.getAcceptedOrders();

      state = state.copyWith(
        orders: response.orders,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      debugPrint('❌ Error fetching accepted orders: $e');
      debugPrint('Stack trace: $stackTrace');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> assignDriver({
    required String orderId,
    required String driverId,
  }) async {
    try {
      final apiService = _ref.read(ordersApiServiceProvider);
      await apiService.assignDriver(
        orderId: orderId,
        request: AssignDriverRequest(driverId: driverId),
      );

      // Refresh accepted orders
      await fetchOrders();
      return true;
    } catch (e) {
      debugPrint('❌ Error assigning driver: $e');
      return false;
    }
  }
}

// ==================== Sub-orders Provider ====================

final subOrdersProvider =
    StateNotifierProvider<SubOrdersNotifier, SubOrdersState>((ref) {
  return SubOrdersNotifier(ref);
});

class SubOrdersState {
  final List<SubOrder> subOrders;
  final bool isLoading;
  final String? error;

  SubOrdersState({
    this.subOrders = const [],
    this.isLoading = false,
    this.error,
  });

  SubOrdersState copyWith({
    List<SubOrder>? subOrders,
    bool? isLoading,
    String? error,
  }) {
    return SubOrdersState(
      subOrders: subOrders ?? this.subOrders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<SubOrder> get unloadOrders =>
      subOrders.where((s) => s.type == 'unload').toList();

  List<SubOrder> get returnOrders =>
      subOrders.where((s) => s.type == 'return').toList();
}

class SubOrdersNotifier extends StateNotifier<SubOrdersState> {
  final Ref _ref;

  SubOrdersNotifier(this._ref) : super(SubOrdersState()) {
    fetchSubOrders();
  }

  Future<void> fetchSubOrders() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final apiService = _ref.read(ordersApiServiceProvider);
      final response = await apiService.getSubOrders();

      state = state.copyWith(
        subOrders: response.subOrders,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      debugPrint('❌ Error fetching sub-orders: $e');
      debugPrint('Stack trace: $stackTrace');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> assignDriver({
    required String subOrderId,
    required String driverId,
    required DateTime deliveryDate,
  }) async {
    try {
      final apiService = _ref.read(ordersApiServiceProvider);
      await apiService.assignSubOrderDriver(
        subOrderId: subOrderId,
        request: AssignSubOrderDriverRequest(
          driverId: driverId,
          deliveryDate: deliveryDate,
        ),
      );

      // Refresh sub-orders
      await fetchSubOrders();
      return true;
    } catch (e) {
      debugPrint('❌ Error assigning driver to sub-order: $e');
      return false;
    }
  }
}

// ==================== Completed Orders Provider ====================

final completedOrdersProvider =
    StateNotifierProvider<CompletedOrdersNotifier, CompletedOrdersState>((ref) {
  return CompletedOrdersNotifier(ref);
});

class CompletedOrdersState {
  final List<CompletedOrder> orders;
  final PaginationInfo? pagination;
  final AvailableFilters? availableFilters;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final String? containerTypeFilter;
  final String? containerSizeFilter;
  final String? cityFilter;
  final DateTime? startDateFilter;
  final DateTime? endDateFilter;
  final int currentPage;
  final bool hasMorePages;

  CompletedOrdersState({
    this.orders = const [],
    this.pagination,
    this.availableFilters,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.containerTypeFilter,
    this.containerSizeFilter,
    this.cityFilter,
    this.startDateFilter,
    this.endDateFilter,
    this.currentPage = 1,
    this.hasMorePages = false,
  });

  CompletedOrdersState copyWith({
    List<CompletedOrder>? orders,
    PaginationInfo? pagination,
    AvailableFilters? availableFilters,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    String? containerTypeFilter,
    String? containerSizeFilter,
    String? cityFilter,
    DateTime? startDateFilter,
    DateTime? endDateFilter,
    int? currentPage,
    bool? hasMorePages,
  }) {
    return CompletedOrdersState(
      orders: orders ?? this.orders,
      pagination: pagination ?? this.pagination,
      availableFilters: availableFilters ?? this.availableFilters,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      containerTypeFilter: containerTypeFilter ?? this.containerTypeFilter,
      containerSizeFilter: containerSizeFilter ?? this.containerSizeFilter,
      cityFilter: cityFilter ?? this.cityFilter,
      startDateFilter: startDateFilter ?? this.startDateFilter,
      endDateFilter: endDateFilter ?? this.endDateFilter,
      currentPage: currentPage ?? this.currentPage,
      hasMorePages: hasMorePages ?? this.hasMorePages,
    );
  }
}

class CompletedOrdersNotifier extends StateNotifier<CompletedOrdersState> {
  final Ref _ref;

  CompletedOrdersNotifier(this._ref) : super(CompletedOrdersState()) {
    fetchOrders();
  }

  Future<void> fetchOrders({int page = 1}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final apiService = _ref.read(ordersApiServiceProvider);
      final response = await apiService.getCompletedOrders(
        containerType: state.containerTypeFilter,
        containerSize: state.containerSizeFilter,
        city: state.cityFilter,
        startDate: state.startDateFilter,
        endDate: state.endDateFilter,
        page: page,
      );

      final hasMore = response.pagination != null &&
          response.pagination!.currentPage < response.pagination!.totalPages;

      state = state.copyWith(
        orders: response.orders,
        pagination: response.pagination,
        availableFilters: response.availableFilters,
        currentPage: page,
        hasMorePages: hasMore,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      debugPrint('❌ Error fetching completed orders: $e');
      debugPrint('Stack trace: $stackTrace');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMoreOrders() async {
    if (state.isLoadingMore || !state.hasMorePages) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final apiService = _ref.read(ordersApiServiceProvider);
      final response = await apiService.getCompletedOrders(
        containerType: state.containerTypeFilter,
        containerSize: state.containerSizeFilter,
        city: state.cityFilter,
        startDate: state.startDateFilter,
        endDate: state.endDateFilter,
        page: nextPage,
      );

      final hasMore = response.pagination != null &&
          response.pagination!.currentPage < response.pagination!.totalPages;

      state = state.copyWith(
        orders: [...state.orders, ...response.orders],
        pagination: response.pagination,
        currentPage: nextPage,
        hasMorePages: hasMore,
        isLoadingMore: false,
      );
    } catch (e, stackTrace) {
      debugPrint('❌ Error loading more completed orders: $e');
      debugPrint('Stack trace: $stackTrace');
      state = state.copyWith(
        isLoadingMore: false,
      );
    }
  }

  void applyFilters({
    String? containerType,
    String? containerSize,
    String? city,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    state = CompletedOrdersState(
      orders: state.orders,
      pagination: state.pagination,
      availableFilters: state.availableFilters,
      isLoading: state.isLoading,
      error: state.error,
      containerTypeFilter: containerType,
      containerSizeFilter: containerSize,
      cityFilter: city,
      startDateFilter: startDate,
      endDateFilter: endDate,
    );
    fetchOrders();
  }

  void clearFilters() {
    state = CompletedOrdersState();
    fetchOrders();
  }
}

// ==================== Cancelled Orders Provider ====================

final cancelledOrdersProvider =
    StateNotifierProvider<CancelledOrdersNotifier, CancelledOrdersState>((ref) {
  return CancelledOrdersNotifier(ref);
});

class CancelledOrdersState {
  final List<CancelledOrder> orders;
  final bool isLoading;
  final String? error;

  CancelledOrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  CancelledOrdersState copyWith({
    List<CancelledOrder>? orders,
    bool? isLoading,
    String? error,
  }) {
    return CancelledOrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CancelledOrdersNotifier extends StateNotifier<CancelledOrdersState> {
  final Ref _ref;

  CancelledOrdersNotifier(this._ref) : super(CancelledOrdersState()) {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final apiService = _ref.read(ordersApiServiceProvider);
      final response = await apiService.getCancelledOrders();

      state = state.copyWith(
        orders: response.orders,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      debugPrint('❌ Error fetching cancelled orders: $e');
      debugPrint('Stack trace: $stackTrace');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
