import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/landing_screen.dart';
import '../../features/auth/screens/sign_in_screen.dart';
import '../../features/auth/screens/sign_up_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/orders/screens/orders_main_screen.dart';
import '../../features/drivers/screens/drivers_list_screen.dart';
import '../../features/drivers/screens/driver_details_screen.dart';
import '../../features/containers/screens/containers_summary_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/notifications/screens/fcm_debug_screen.dart';
import '../../features/support/screens/support_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../layout/main_layout.dart';

// Router Provider
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // Check if user is authenticated
      final isAuthenticated = authState.isAuthenticated;
      
      final isGoingToAuth = state.matchedLocation == '/' ||
          state.matchedLocation == '/signin' ||
          state.matchedLocation == '/signup';

      final isProtectedRoute = state.matchedLocation.startsWith('/dashboard') ||
          state.matchedLocation.startsWith('/orders') ||
          state.matchedLocation.startsWith('/drivers') ||
          state.matchedLocation.startsWith('/containers') ||
          state.matchedLocation.startsWith('/notifications') ||
          state.matchedLocation.startsWith('/support') ||
          state.matchedLocation.startsWith('/profile');

      // If authenticated and trying to access auth screens, redirect to dashboard
      if (isAuthenticated && isGoingToAuth) {
        return '/dashboard';
      }

      // If not authenticated and trying to access protected routes, redirect to landing
      if (!isAuthenticated && isProtectedRoute) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const MainLayout(
          currentIndex: 0,
          child: DashboardScreen(),
        ),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const MainLayout(
          currentIndex: 1,
          child: OrdersMainScreen(),
        ),
      ),
      GoRoute(
        path: '/drivers',
        builder: (context, state) => const MainLayout(
          currentIndex: 2,
          child: DriversListScreen(),
        ),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return DriverDetailsScreen(driverId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/containers',
        builder: (context, state) => const MainLayout(
          currentIndex: 3,
          child: ContainersSummaryScreen(),
        ),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/fcm-debug',
        builder: (context, state) => const FCMDebugScreen(),
      ),
      GoRoute(
        path: '/support',
        builder: (context, state) => const SupportScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});
