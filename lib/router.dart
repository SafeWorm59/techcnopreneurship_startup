import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/marketplace_screen.dart';
import 'screens/landowner/landowner_dashboard_screen.dart';
import 'screens/buyer/buyer_dashboard_screen.dart';
import 'screens/sensors_screen.dart';
import 'screens/wallet_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/marketplace',
      builder: (context, state) => const MarketplaceScreen(),
    ),
    // Generic /dashboard redirects to login — role must be known first
    GoRoute(
      path: '/dashboard',
      redirect: (context, state) => '/login',
    ),
    GoRoute(
      path: '/dashboard/landowner',
      builder: (context, state) => const LandownerDashboardScreen(),
    ),
    GoRoute(
      path: '/dashboard/buyer',
      builder: (context, state) => const BuyerDashboardScreen(),
    ),
    GoRoute(
      path: '/sensors',
      builder: (context, state) => const SensorsScreen(),
    ),
    GoRoute(
      path: '/wallet',
      builder: (context, state) => const WalletScreen(),
    ),
  ],
);