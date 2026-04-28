import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/marketplace_screen.dart';
import 'screens/project_details_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/sensors_screen.dart';
import 'screens/dashboards/landowner_dashboard.dart';
import 'screens/dashboards/buyer_dashboard.dart'; // Ensure this is imported
import 'screens/dashboards/validator_dashboard.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/marketplace', builder: (context, state) => const MarketplaceScreen()),
    GoRoute(
      path: '/project/:id',
      builder: (context, state) => ProjectDetailsScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(path: '/wallet', builder: (context, state) => const WalletScreen()),
    GoRoute(path: '/sensors', builder: (context, state) => const SensorsScreen()),
    GoRoute(path: '/dashboard/landowner', builder: (context, state) => const LandownerDashboard()),
    GoRoute(path: '/dashboard/buyer', builder: (context, state) => const BuyerDashboard()),
    GoRoute(path: '/dashboard/validator', builder: (context, state) => const ValidatorDashboard()),
  ],
);