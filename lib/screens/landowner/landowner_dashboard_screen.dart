import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../dashboard_screen.dart';

class LandownerDashboardScreen extends BaseDashboardScreen {
  const LandownerDashboardScreen({super.key});

  @override
  String get role => 'landowner';

  @override
  String get displayName => 'Datu Salise';

  @override
  String get displaySubtitle => 'Bukidnon Forest Reserve · 12.4 hectares';

  @override
  IconData get roleIcon => Icons.park;

  @override
  List<DashboardStat> get stats => const [
    DashboardStat(
      label: 'Carbon Absorbed',
      value: '1,240',
      unit: 'kg CO₂ this month',
      icon: Icons.air,
      accentColor: Color(0xFF8BAE66),
    ),
    DashboardStat(
      label: 'Active Sensors',
      value: '8',
      unit: 'of 10 online',
      icon: Icons.sensors,
      accentColor: Color(0xFF64B5F6),
    ),
    DashboardStat(
      label: 'Total Earnings',
      value: '₱48,200',
      unit: 'from credit sales',
      icon: Icons.account_balance_wallet,
      accentColor: Color(0xFFFFD54F),
    ),
  ];

  @override
  Widget buildRoleContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(title: 'My Forest Plots'),
        const SizedBox(height: 12),
        _PlotCard(
          plotId: '#2401',
          name: 'Northern Slope',
          area: '4.2 ha',
          absorbed: '520 kg',
          sensors: 3,
          status: 'Healthy',
        ),
        const SizedBox(height: 12),
        _PlotCard(
          plotId: '#2402',
          name: 'Riverside Grove',
          area: '3.8 ha',
          absorbed: '410 kg',
          sensors: 3,
          status: 'Healthy',
        ),
        const SizedBox(height: 12),
        _PlotCard(
          plotId: '#2403',
          name: 'Eastern Treeline',
          area: '4.4 ha',
          absorbed: '310 kg',
          sensors: 2,
          status: 'Sensor Offline',
          statusColor: Colors.orange,
        ),
        const SizedBox(height: 28),
        const _SectionHeader(title: 'Recent Activity'),
        const SizedBox(height: 12),
        _ActivityItem(
          icon: Icons.air,
          color: const Color(0xFF8BAE66),
          title: 'CO₂ Absorbed — Plot #2401',
          subtitle: '12 kg detected by sensor array',
          time: '2 hours ago',
        ),
        _ActivityItem(
          icon: Icons.sell,
          color: const Color(0xFFFFD54F),
          title: 'Credits Sold',
          subtitle: '25 credits to GreenCorp Industries',
          time: '2 days ago',
        ),
        _ActivityItem(
          icon: Icons.warning_amber,
          color: Colors.orange,
          title: 'Sensor Alert — Plot #2403',
          subtitle: 'Sensor ET-07 went offline',
          time: '3 days ago',
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => context.go('/wallet'),
            icon: const Icon(Icons.account_balance_wallet),
            label: const Text('View Carbon Wallet'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF628141),
              foregroundColor: const Color(0xFFEBD5AB),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: Color(0xFFEBD5AB),
      ),
    );
  }
}

class _PlotCard extends StatelessWidget {
  final String plotId, name, area, absorbed;
  final int sensors;
  final String status;
  final Color statusColor;

  const _PlotCard({
    required this.plotId,
    required this.name,
    required this.area,
    required this.absorbed,
    required this.sensors,
    required this.status,
    this.statusColor = const Color(0xFF8BAE66),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF232B21),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF628141).withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF628141).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  plotId,
                  style: const TextStyle(
                    color: Color(0xFF8BAE66),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: const TextStyle(
                  color: Color(0xFFEBD5AB),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _PlotStat(icon: Icons.straighten, label: area),
              const SizedBox(width: 16),
              _PlotStat(icon: Icons.air, label: absorbed),
              const SizedBox(width: 16),
              _PlotStat(icon: Icons.sensors, label: '$sensors sensors'),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlotStat extends StatelessWidget {
  final IconData icon;
  final String label;
  const _PlotStat({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF628141), size: 14),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Color(0xFF8BAE66), fontSize: 13)),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, subtitle, time;
  const _ActivityItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF232B21),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF628141).withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Color(0xFFEBD5AB),
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(color: Color(0xFF8BAE66), fontSize: 12)),
              ],
            ),
          ),
          Text(time,
              style: TextStyle(
                  color: const Color(0xFFEBD5AB).withOpacity(0.35), fontSize: 11)),
        ],
      ),
    );
  }
}