import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('IoT Sensors'),
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
              const Text(
                'IoT Sensor Network',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B211A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Monitor real-time carbon absorption across your forest plots',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8BAE66),
                ),
              ),
              const SizedBox(height: 32),

              // Sensor status overview
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B211A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatusItem(
                          icon: Icons.sensors,
                          label: 'Active Sensors',
                          value: '24',
                          color: const Color(0xFF8BAE66),
                        ),
                        _buildStatusItem(
                          icon: Icons.warning,
                          label: 'Maintenance Due',
                          value: '3',
                          color: Colors.orange,
                        ),
                        _buildStatusItem(
                          icon: Icons.battery_alert,
                          label: 'Low Battery',
                          value: '1',
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Sensor list
              const Text(
                'Sensor Locations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B211A),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildSensorCard(index + 1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF8BAE66),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSensorCard(int sensorId) {
    final statuses = ['Online', 'Online', 'Maintenance', 'Online', 'Low Battery', 'Online'];
    final status = statuses[sensorId - 1];
    final isOnline = status == 'Online';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B211A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isOnline ? const Color(0xFF8BAE66).withOpacity(0.2) : Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.sensors,
              color: isOnline ? const Color(0xFF8BAE66) : Colors.orange,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sensor #${sensorId.toString().padLeft(3, '0')}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEBD5AB),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Plot ${sensorId} - Mt. Kitanglad Area',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8BAE66),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isOnline ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isOnline ? Colors.green.withOpacity(0.3) : Colors.orange.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          color: isOnline ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'CO₂: 1.2 kg/day',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFEBD5AB),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF8BAE66),
            ),
            onPressed: () {
              // Show sensor details
            },
          ),
        ],
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