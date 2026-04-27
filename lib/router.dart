import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/marketplace_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/project_details_screen.dart';
import 'screens/sensors_screen.dart';
import 'screens/wallet_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/marketplace',
      builder: (BuildContext context, GoRouterState state) {
        return const MarketplaceScreen();
      },
    ),
    GoRoute(
      path: '/dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardScreen();
      },
    ),
    GoRoute(
      path: '/project/:id',
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id']!;
        return ProjectDetailsScreen(id: id);
      },
    ),
    GoRoute(
      path: '/sensors',
      builder: (BuildContext context, GoRouterState state) {
        return const SensorsScreen();
      },
    ),
    GoRoute(
      path: '/wallet',
      builder: (BuildContext context, GoRouterState state) {
        return const WalletScreen();
      },
    ),
  ],
);