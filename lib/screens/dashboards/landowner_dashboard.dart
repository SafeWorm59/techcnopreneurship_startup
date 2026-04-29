import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../dashboard_screen.dart';
import '../../theme/app_theme.dart';
import '../../utils/wallet_state.dart';
import '../../utils/responsive.dart'; // NEW

class LandownerDashboard extends BaseDashboardScreen {
  const LandownerDashboard({super.key});

  @override
  String get role => 'landowner';
  @override
  String get displayName => 'Juan Dela Cruz';
  @override
  String get displaySubtitle => 'Rubber Tree Farm, Bukidnon';
  @override
  IconData get roleIcon => Icons.landscape;

  @override
  List<DashboardStat> get stats => const [
    DashboardStat(label: 'Leased IoT Sensors', value: '4', unit: 'Active', icon: Icons.sensors),
    DashboardStat(label: 'Est. Total Biomass', value: '1,240', unit: 'kg', icon: Icons.forest, accentColor: Colors.greenAccent),
    DashboardStat(label: 'Projected 40% Share', value: '₱24,500', unit: 'PHP', icon: Icons.account_balance_wallet, accentColor: Colors.amber),
  ];

  @override
  Widget buildRoleContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sensor Telemetry & Health', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
        const SizedBox(height: 24),
        _buildInteractiveNodeCard(context, 'Node 01: Plot A (Rubber Trees)', 'DBH: 42cm', '45kg', true),
        const SizedBox(height: 16),
        _buildInteractiveNodeCard(context, 'Node 02: Plot B (Mahogany)', 'DBH: 38cm', '38kg', true),
        const SizedBox(height: 16),
        _buildInteractiveNodeCard(context, 'Node 03: Plot C (Pine)', 'DBH: --', '--', false),
      ],
    );
  }

  // FIXED: Converted hard ListTile into flexible Column for mobile
  Widget _buildInteractiveNodeCard(BuildContext context, String title, String dbh, String co2, bool isOnline) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isOnline ? AppTheme.primaryDark.withOpacity(0.4) : Colors.red.withOpacity(0.4)),
      ),
      padding: const EdgeInsets.all(24),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.router, color: isOnline ? AppTheme.primary : Colors.redAccent, size: 36),
              const SizedBox(width: 16),
              Expanded(child: Text(title, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 18))),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _StatusBadge(status: isOnline ? 'Online' : 'Offline', color: isOnline ? Colors.green : Colors.redAccent),
              Text('$dbh • Co2 Absorbed: $co2', style: const TextStyle(color: AppTheme.textSecondary)),
            ],
          ),
          if (isOnline) ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showTelemetryDialog(context, title),
                icon: const Icon(Icons.bar_chart, size: 18),
                label: const Text('View Data'),
              ),
            )
          ]
        ],
      )
          : Row(
        children: [
          Icon(Icons.router, color: isOnline ? AppTheme.primary : Colors.redAccent, size: 36),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 18)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _StatusBadge(status: isOnline ? 'Online' : 'Offline', color: isOnline ? Colors.green : Colors.redAccent),
                    const SizedBox(width: 12),
                    Expanded(child: Text('$dbh • Co2 Absorbed: $co2', style: const TextStyle(color: AppTheme.textSecondary), overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ],
            ),
          ),
          if (isOnline) ...[
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: () => _showTelemetryDialog(context, title),
              icon: const Icon(Icons.bar_chart, size: 18),
              label: const Text('View Data'),
            )
          ]
        ],
      ),
    ).animate().fade().slideX(begin: 0.05);
  }

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
                    globalWallet.addCredits(15.25);
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Successfully minted 15.25 Carbon Credits! Balance Updated.'),
                          backgroundColor: Colors.amber,
                        )
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                  child: const Text('Mint Data to Carbon Credit'),
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

class _StatusBadge extends StatelessWidget {
  final String status;
  final Color color;
  const _StatusBadge({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.5))),
      child: Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)),
    );
  }
}