import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';
import '../theme/app_theme.dart';
import '../utils/auth_state.dart';

class EchoTraceNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentRoute;

  const EchoTraceNavBar({super.key, required this.currentRoute});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context) || Responsive.isTablet(context);

    // Listen to the global auth state dynamically
    return ValueListenableBuilder<String?>(
      valueListenable: globalAuth.currentRole,
      builder: (context, role, child) {
        final isAuthenticated = role != null;

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
                            gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.primaryDark]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.park, color: AppTheme.surface, size: 20),
                        ),
                        const SizedBox(width: 12),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppTheme.textPrimary, letterSpacing: -0.5),
                            children: [
                              TextSpan(text: 'Echo'),
                              TextSpan(text: 'Trace', style: TextStyle(color: AppTheme.primary)),
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
                    children: isAuthenticated ? _buildRoleSpecificNav(context, role) : _buildGuestNav(context),
                  ),
              ],
            ),
          ),
        );
      },
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
        child: const Text('Create Account'),
      ),
    ];
  }

  List<Widget> _buildRoleSpecificNav(BuildContext context, String role) {
    List<({String label, String route})> navItems = [];

    if (role == 'landowner') {
      navItems = [
        (label: 'Dashboard', route: '/dashboard/landowner'),
        (label: 'Sensors', route: '/sensors'),
        (label: 'Marketplace', route: '/marketplace'),
        (label: 'Wallet', route: '/wallet'),
      ];
    } else if (role == 'validator') {
      navItems = [
        (label: 'DENR Portal', route: '/dashboard/validator'),
        (label: 'Field Data', route: '/sensors'),
      ];
    } else { // buyer
      navItems = [
        (label: 'Portfolio', route: '/dashboard/buyer'),
        (label: 'Marketplace', route: '/marketplace'),
      ];
    }

    return [
      ...navItems.map((item) {
        final isActive = currentRoute == item.route || currentRoute.startsWith('${item.route}/');
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            onPressed: () => context.go(item.route),
            style: TextButton.styleFrom(
              foregroundColor: isActive ? AppTheme.primary : AppTheme.textPrimary.withOpacity(0.7),
              textStyle: TextStyle(fontWeight: isActive ? FontWeight.w800 : FontWeight.w500),
            ),
            child: Text(item.label),
          ),
        );
      }),
      const SizedBox(width: 16),
      OutlinedButton(
        onPressed: () {
          globalAuth.logout();
          context.go('/login');
        },
        child: const Text('Sign Out'),
      ),
    ];
  }
}

// FIXED: Added the smart, auth-aware EchoTraceDrawer
class EchoTraceDrawer extends StatelessWidget {
  final String currentRoute;

  const EchoTraceDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    // Wrap the drawer in the Auth listener so mobile users see the correct links
    return ValueListenableBuilder<String?>(
      valueListenable: globalAuth.currentRole,
      builder: (context, role, child) {
        final isAuthenticated = role != null;

        return Drawer(
          backgroundColor: AppTheme.background,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: AppTheme.surface),
                child: Text(
                  'EchoTrace',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              _buildDrawerItem(context, 'Home', Icons.home, '/'),

              if (!isAuthenticated) ...[
                _buildDrawerItem(context, 'Login', Icons.login, '/login'),
                _buildDrawerItem(context, 'Marketplace', Icons.store, '/marketplace'),
              ] else ...[
                if (role == 'landowner') ...[
                  _buildDrawerItem(context, 'Dashboard', Icons.dashboard, '/dashboard/landowner'),
                  _buildDrawerItem(context, 'Sensors', Icons.sensors, '/sensors'),
                  _buildDrawerItem(context, 'Marketplace', Icons.store, '/marketplace'),
                  _buildDrawerItem(context, 'Wallet', Icons.account_balance_wallet, '/wallet'),
                ] else if (role == 'validator') ...[
                  _buildDrawerItem(context, 'DENR Portal', Icons.admin_panel_settings, '/dashboard/validator'),
                  _buildDrawerItem(context, 'Field Data', Icons.sensors, '/sensors'),
                ] else ...[ // buyer
                  _buildDrawerItem(context, 'Portfolio', Icons.business, '/dashboard/buyer'),
                  _buildDrawerItem(context, 'Marketplace', Icons.store, '/marketplace'),
                ],
                const Divider(color: AppTheme.primaryDark),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text('Sign Out', style: TextStyle(color: Colors.redAccent)),
                  onTap: () {
                    globalAuth.logout();
                    context.go('/login');
                  },
                ),
              ],
            ],
          ),
        );
      },
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
        Navigator.pop(context); // Close the drawer automatically
        context.go(route);
      },
    );
  }
}