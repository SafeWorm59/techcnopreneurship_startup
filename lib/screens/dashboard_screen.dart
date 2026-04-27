import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFF1B211A),
        foregroundColor: const Color(0xFFEBD5AB),
      ),
      drawer: _buildDrawer(context),
      body: Container(
        color: const Color(0xFFEBD5AB),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF628141),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.forest,
                      color: Color(0xFF1B211A),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'EcoTrace',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B211A),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 16,
                            color: Color(0xFF8BAE66),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Bukidnon Certified',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8BAE66),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // CO2 Absorption Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A3329), Color(0xFF1B211A)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total CO₂ Absorbed',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFEBD5AB),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '482',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF8BAE66),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'kg',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFEBD5AB),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.green.withOpacity(0.3)),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.arrow_upward, size: 14, color: Colors.green),
                              SizedBox(width: 4),
                              Text(
                                '12%',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFF628141), width: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.eco,
                                size: 16,
                                color: Color(0xFF628141),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Eqv. 12 cars off road',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFEBD5AB),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () => context.go('/wallet'),
                            child: const Row(
                              children: [
                                Text(
                                  'Redeem',
                                  style: TextStyle(
                                    color: Color(0xFF8BAE66),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Color(0xFF8BAE66),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Recent Activity
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B211A),
                ),
              ),
              const SizedBox(height: 16),
              _buildActivityItem(
                icon: Icons.verified,
                title: 'Sensor Validation',
                subtitle: 'Plot #2401 verified 2 days ago',
                time: '2d ago',
              ),
              _buildActivityItem(
                icon: Icons.eco,
                title: 'CO₂ Absorption',
                subtitle: 'Peak absorption recorded: 28kg',
                time: '1d ago',
              ),
              _buildActivityItem(
                icon: Icons.attach_money,
                title: 'Credit Generated',
                subtitle: '12 new carbon credits available',
                time: '3d ago',
              ),

              const SizedBox(height: 32),

              // Quick Actions
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B211A),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      icon: Icons.sensors,
                      label: 'View Sensors',
                      onTap: () => context.go('/sensors'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildQuickActionButton(
                      icon: Icons.store,
                      label: 'Marketplace',
                      onTap: () => context.go('/marketplace'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B211A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF628141).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF628141).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF8BAE66),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEBD5AB),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8BAE66),
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8BAE66),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1B211A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: const Color(0xFF8BAE66),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFEBD5AB),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1B211A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1B211A),
            ),
            child: Text(
              'EchoTrace',
              style: TextStyle(
                color: Color(0xFFEBD5AB),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFF8BAE66)),
            title: const Text('Home', style: TextStyle(color: Color(0xFFEBD5AB))),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.store, color: Color(0xFF8BAE66)),
            title: const Text('Marketplace', style: TextStyle(color: Color(0xFFEBD5AB))),
            onTap: () {
              Navigator.pop(context);
              context.go('/marketplace');
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Color(0xFF8BAE66)),
            title: const Text('Dashboard', style: TextStyle(color: Color(0xFFEBD5AB))),
            onTap: () {
              Navigator.pop(context);
              context.go('/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.sensors, color: Color(0xFF8BAE66)),
            title: const Text('Sensors', style: TextStyle(color: Color(0xFFEBD5AB))),
            onTap: () {
              Navigator.pop(context);
              context.go('/sensors');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet, color: Color(0xFF8BAE66)),
            title: const Text('Wallet', style: TextStyle(color: Color(0xFFEBD5AB))),
            onTap: () {
              Navigator.pop(context);
              context.go('/wallet');
            },
          ),
        ],
      ),
    );
  }
}