import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';
import '../theme/app_theme.dart';

class EchoTraceNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentRoute;
  final bool isAuthenticated;

  const EchoTraceNavBar({
    super.key,
    required this.currentRoute,
    this.isAuthenticated = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context) || Responsive.isTablet(context);

    return AppBar(
      automaticallyImplyLeading: isAuthenticated && !isDesktop,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: AppTheme.primaryDark.withOpacity(0.2), height: 1),
      ),
      title: MaxWidthContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => context.go('/'),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primary, AppTheme.primaryDark],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.park, color: AppTheme.surface, size: 20),
                    ),
                    const SizedBox(width: 12),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.5,
                        ),
                        children: [
                          TextSpan(text: 'Echo'),
                          TextSpan(
                            text: 'Trace',
                            style: TextStyle(color: AppTheme.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isDesktop)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: isAuthenticated
                    ? _buildAuthDesktopNav(context)
                    : _buildGuestNav(context),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGuestNav(BuildContext context) {
    return [
      TextButton(
        onPressed: () => context.go('/login'),
        style: TextButton.styleFrom(foregroundColor: AppTheme.primary),
        child: const Text('Login'),
      ),
      const SizedBox(width: 16),
      ElevatedButton(
        onPressed: () => context.go('/register'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: const Text('Create Account'),
      ),
    ];
  }

  List<Widget> _buildAuthDesktopNav(BuildContext context) {
    final navItems = [
      (label: 'Marketplace', route: '/marketplace'),
      (label: 'Dashboard', route: '/dashboard'),
      (label: 'Sensors', route: '/sensors'),
      (label: 'Wallet', route: '/wallet'),
    ];

    return [
      ...navItems.map((item) {
        final isActive = currentRoute == item.route || currentRoute.startsWith('${item.route}/');
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            onPressed: () => context.go(item.route),
            style: TextButton.styleFrom(
              foregroundColor: isActive ? AppTheme.primary : AppTheme.textPrimary.withOpacity(0.7),
              textStyle: TextStyle(
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
            child: Text(item.label),
          ),
        );
      }),
      const SizedBox(width: 16),
      OutlinedButton(
        onPressed: () => context.go('/'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: const Text('Sign Out'),
      ),
    ];
  }
}

// FIXED: Included missing EchoTraceDrawer properly styled
class EchoTraceDrawer extends StatelessWidget {
  final String currentRoute;

  const EchoTraceDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.surface),
            child: Text(
              'EchoTrace',
              style: AppTheme.darkTheme.textTheme.displayMedium,
            ),
          ),
          _buildDrawerItem(context, 'Home', Icons.home, '/'),
          _buildDrawerItem(context, 'Marketplace', Icons.store, '/marketplace'),
          _buildDrawerItem(context, 'Dashboard', Icons.dashboard, '/dashboard'),
          _buildDrawerItem(context, 'Sensors', Icons.sensors, '/sensors'),
          _buildDrawerItem(context, 'Wallet', Icons.account_balance_wallet, '/wallet'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon, String route) {
    final isActive = currentRoute == route || (route != '/' && currentRoute.startsWith(route));
    return ListTile(
      leading: Icon(icon, color: isActive ? AppTheme.primary : AppTheme.textPrimary.withOpacity(0.5)),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? AppTheme.primary : AppTheme.textPrimary,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        context.go(route);
      },
    );
  }
}