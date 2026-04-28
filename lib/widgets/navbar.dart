import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EchoTraceNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentRoute;
  final bool isAuthenticated;

  const EchoTraceNavBar({
    super.key,
    required this.currentRoute,
    this.isAuthenticated = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return AppBar(
      backgroundColor: const Color(0xFF1B211A),
      foregroundColor: const Color(0xFFEBD5AB),
      elevation: 0,
      automaticallyImplyLeading: isAuthenticated,
      title: GestureDetector(
        onTap: () => context.go('/'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF8BAE66), Color(0xFF628141)],
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF628141).withOpacity(0.4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(Icons.park, color: Color(0xFF1B211A), size: 18),
            ),
            const SizedBox(width: 10),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFEBD5AB),
                  letterSpacing: -0.5,
                ),
                children: [
                  TextSpan(text: 'Echo'),
                  TextSpan(
                    text: 'Trace',
                    style: TextStyle(color: Color(0xFF8BAE66)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: isAuthenticated
          ? (isDesktop ? _buildAuthDesktopNav(context) : null)
          : _buildGuestNav(context),
    );
  }

  /// Guest: only Login + Create Account
  List<Widget> _buildGuestNav(BuildContext context) {
    return [
      TextButton(
        onPressed: () => context.go('/login'),
        child: const Text(
          'Login',
          style: TextStyle(color: Color(0xFF8BAE66), fontWeight: FontWeight.w600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 12, left: 4),
        child: ElevatedButton(
          onPressed: () => context.go('/register'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF628141),
            foregroundColor: const Color(0xFFEBD5AB),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            elevation: 0,
          ),
          child: const Text(
            'Create Account',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ),
      ),
    ];
  }

  /// Authenticated desktop: full nav links + sign out
  List<Widget> _buildAuthDesktopNav(BuildContext context) {
    final navItems = [
      (label: 'Home', route: '/'),
      (label: 'Marketplace', route: '/marketplace'),
      (label: 'Dashboard', route: '/dashboard'),
      (label: 'Sensors', route: '/sensors'),
      (label: 'Wallet', route: '/wallet'),
    ];

    return [
      ...navItems.map((item) {
        final isActive = currentRoute == item.route;
        return TextButton(
          onPressed: () => context.go(item.route),
          child: Text(
            item.label,
            style: TextStyle(
              color: isActive
                  ? const Color(0xFF8BAE66)
                  : const Color(0xFFEBD5AB).withOpacity(0.7),
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        );
      }),
      const SizedBox(width: 8),
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: OutlinedButton(
          onPressed: () => context.go('/'),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF628141)),
            foregroundColor: const Color(0xFF8BAE66),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          child: const Text(
            'Sign Out',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ),
      ),
    ];
  }
}

/// Mobile drawer — only used when authenticated
class EchoTraceDrawer extends StatelessWidget {
  final String currentRoute;

  const EchoTraceDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final navItems = [
      (label: 'Home', route: '/', icon: Icons.home),
      (label: 'Marketplace', route: '/marketplace', icon: Icons.store),
      (label: 'Dashboard', route: '/dashboard', icon: Icons.dashboard),
      (label: 'Sensors', route: '/sensors', icon: Icons.sensors),
      (label: 'Wallet', route: '/wallet', icon: Icons.account_balance_wallet),
    ];

    return Drawer(
      backgroundColor: const Color(0xFF1B211A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF1B211A),
              border: Border(
                bottom: BorderSide(color: Color(0xFF628141), width: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8BAE66), Color(0xFF628141)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.park, color: Color(0xFF1B211A), size: 20),
                    ),
                    const SizedBox(width: 10),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFEBD5AB),
                        ),
                        children: [
                          TextSpan(text: 'Echo'),
                          TextSpan(
                            text: 'Trace',
                            style: TextStyle(color: Color(0xFF8BAE66)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Live Carbon Verification Network',
                  style: TextStyle(color: Color(0xFF628141), fontSize: 11),
                ),
              ],
            ),
          ),
          ...navItems.map((item) {
            final isActive = currentRoute == item.route;
            return ListTile(
              leading: Icon(
                item.icon,
                color: isActive
                    ? const Color(0xFF8BAE66)
                    : const Color(0xFF628141).withOpacity(0.6),
              ),
              title: Text(
                item.label,
                style: TextStyle(
                  color: isActive ? const Color(0xFF8BAE66) : const Color(0xFFEBD5AB),
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
              tileColor: isActive ? const Color(0xFF628141).withOpacity(0.1) : null,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onTap: () {
                Navigator.pop(context);
                context.go(item.route);
              },
            );
          }),
          const Divider(color: Color(0xFF628141), height: 32, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                context.go('/');
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF628141)),
                foregroundColor: const Color(0xFF8BAE66),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}