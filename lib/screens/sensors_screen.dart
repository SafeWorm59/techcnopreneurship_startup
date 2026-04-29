import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/navbar.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: const EchoTraceNavBar(currentRoute: '/sensors'),
      drawer: isDesktop ? null : const EchoTraceDrawer(currentRoute: '/sensors'),
      body: SingleChildScrollView(
        child: MaxWidthContainer(
          child: Padding(
            padding: EdgeInsets.all(Responsive.isMobile(context) ? 20 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'IoT Sensor Network',
                  style: Theme.of(context).textTheme.displayMedium,
                ).animate().fade().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 8),
                const Text(
                  'Monitor real-time carbon absorption across your forest plots',
                  style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
                ).animate().fade(delay: 100.ms),
                const SizedBox(height: 32),

                // Sensor status overview
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceLight,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppTheme.primaryDark.withOpacity(0.3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // FIXED: Align top for multi-line text
                    children: [
                      _buildStatusItem(icon: Icons.sensors, label: 'Active Sensors', value: '24', color: AppTheme.primary),
                      _buildStatusItem(icon: Icons.warning, label: 'Maintenance Due', value: '3', color: Colors.orange),
                      _buildStatusItem(icon: Icons.battery_alert, label: 'Low Battery', value: '1', color: Colors.redAccent),
                    ],
                  ),
                ).animate().fade(delay: 200.ms).scaleXY(begin: 0.95, end: 1.0),

                const SizedBox(height: 48),

                // Sensor list
                const Text(
                  'Sensor Locations',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                ).animate().fade(delay: 300.ms),
                const SizedBox(height: 16),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return _buildSensorCard(context, index + 1)
                        .animate(delay: (400 + (100 * index)).ms)
                        .fade()
                        .slideX(begin: 0.05, end: 0);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem({required IconData icon, required String label, required String value, required Color color}) {
    // FIXED: Wrapped in Expanded so elements share horizontal space equally without overflowing
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50, // Slightly smaller for mobile safety
              height: 50,
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: color)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard(BuildContext context, int sensorId) {
    final statuses = ['Online', 'Online', 'Maintenance', 'Online', 'Low Battery', 'Online'];
    final status = statuses[sensorId - 1];
    final isOnline = status == 'Online';
    final cardColor = isOnline ? AppTheme.primary : Colors.orange;
    final nodeTitle = 'Node #${sensorId.toString().padLeft(3, '0')}';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: cardColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.sensors, color: cardColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nodeTitle,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text('Plot $sensorId - Impasugong Sector', style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                  const SizedBox(height: 12),
                  // FIXED: Replaced Row with Wrap to prevent the badge from pushing text off-screen
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: cardColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: cardColor.withOpacity(0.5)),
                        ),
                        child: Text(status, style: TextStyle(fontSize: 11, color: cardColor, fontWeight: FontWeight.w800)),
                      ),
                      const Text('CO₂ : 1.2 kg/day', style: TextStyle(fontSize: 13, color: AppTheme.textPrimary)),
                    ],
                  ),
                ],
              ),
            ),
            // Interactive 3-Dot Menu
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppTheme.textSecondary),
              onPressed: () => _showSensorActionMenu(context, sensorId, nodeTitle, status),
            ),
          ],
        ),
      ),
    );
  }

  // --- Bottom Sheet Menu Logic ---
  void _showSensorActionMenu(BuildContext context, int sensorId, String nodeTitle, String status) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: AppTheme.primaryDark, borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 24),
              Text('Manage $nodeTitle', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 24),
              _MenuActionTile(
                icon: Icons.bar_chart,
                title: 'View Live Telemetry',
                color: AppTheme.primary,
                onTap: () {
                  Navigator.pop(ctx);
                  _showTelemetryDialog(context, nodeTitle);
                },
              ),
              _MenuActionTile(
                icon: Icons.build,
                title: 'Run Remote Diagnostics',
                color: Colors.blueAccent,
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Diagnostics requested. Node will ping shortly.')));
                },
              ),
              if (status != 'Online')
                _MenuActionTile(
                  icon: Icons.support_agent,
                  title: 'Request Physical Maintenance',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Maintenance ticket sent to EchoTrace Ops.')));
                  },
                ),
              const Divider(color: AppTheme.primaryDark),
              _MenuActionTile(
                icon: Icons.power_settings_new,
                title: 'Reboot Sensor',
                color: Colors.redAccent,
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sensor reboot command sent.'), backgroundColor: Colors.redAccent));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Telemetry Dialog Logic ---
  void _showTelemetryDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('Live Telemetry: $title', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary), overflow: TextOverflow.ellipsis),
                  ),
                  IconButton(icon: const Icon(Icons.close, color: AppTheme.textSecondary), onPressed: () => Navigator.pop(ctx)),
                ],
              ),
              const Divider(color: AppTheme.primaryDark),
              const SizedBox(height: 24),
              const Text('Biomass & DBH Growth (Last 6 Months)', style: TextStyle(color: AppTheme.textSecondary)),
              const SizedBox(height: 16),
              // Simulated Bar Chart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _mockBar(60, 'Jan'), _mockBar(75, 'Feb'), _mockBar(85, 'Mar'),
                  _mockBar(110, 'Apr'), _mockBar(130, 'May'), _mockBar(160, 'Jun', isActive: true),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data exported successfully.'), backgroundColor: AppTheme.primary));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: AppTheme.background),
                  child: const Text('Export Telemetry Data'),
                ),
              )
            ],
          ),
        ),
      ).animate().scale(curve: Curves.easeOutBack),
    );
  }

  Widget _mockBar(double height, String label, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 30,
          height: height,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primary : AppTheme.primaryDark.withOpacity(0.3),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: isActive ? AppTheme.textPrimary : AppTheme.textSecondary, fontSize: 12)),
      ],
    );
  }
}

class _MenuActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _MenuActionTile({required this.icon, required this.title, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}