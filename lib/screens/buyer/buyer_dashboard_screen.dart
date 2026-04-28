import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../dashboard_screen.dart';

class BuyerDashboardScreen extends BaseDashboardScreen {
  const BuyerDashboardScreen({super.key});

  @override
  String get role => 'buyer';

  @override
  String get displayName => 'Global Airlines Inc.';

  @override
  String get displaySubtitle => 'Corporate Carbon Offset Portfolio';

  @override
  IconData get roleIcon => Icons.business;

  @override
  List<DashboardStat> get stats => const [
    DashboardStat(
      label: 'Total Invested',
      value: '\$42,800',
      unit: 'in carbon credits',
      icon: Icons.trending_up,
      accentColor: Color(0xFFFFD54F),
    ),
    DashboardStat(
      label: 'Active Projects',
      value: '6',
      unit: 'forests supported',
      icon: Icons.forest,
      accentColor: Color(0xFF8BAE66),
    ),
    DashboardStat(
      label: 'CO₂ Offset',
      value: '2,596',
      unit: 'tons offset to date',
      icon: Icons.air,
      accentColor: Color(0xFF64B5F6),
    ),
  ];

  @override
  Widget buildRoleContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(title: 'Active Forest Projects'),
        const SizedBox(height: 12),
        _ProjectCard(
          name: 'Bukidnon Northern Reserve',
          landowner: 'Datu Salise',
          credits: 240,
          invested: '\$3,960',
          offset: '240 tons CO₂',
          progress: 0.72,
        ),
        const SizedBox(height: 12),
        _ProjectCard(
          name: 'Davao Highland Forest',
          landowner: 'Maria Santos',
          credits: 180,
          invested: '\$2,970',
          offset: '180 tons CO₂',
          progress: 0.55,
        ),
        const SizedBox(height: 12),
        _ProjectCard(
          name: 'Palawan Mangrove Belt',
          landowner: 'Pedro Reyes',
          credits: 320,
          invested: '\$5,280',
          offset: '320 tons CO₂',
          progress: 0.88,
        ),
        const SizedBox(height: 28),
        const _SectionHeader(title: 'ESG Impact Summary'),
        const SizedBox(height: 12),
        _EsgCard(),
        const SizedBox(height: 28),
        const _SectionHeader(title: 'Recent Transactions'),
        const SizedBox(height: 12),
        _TxItem(
          icon: Icons.shopping_cart,
          color: Color(0xFF8BAE66),
          title: 'Credits Purchased',
          subtitle: '50 credits from Bukidnon Reserve',
          amount: '-\$825',
          time: '3 days ago',
        ),
        _TxItem(
          icon: Icons.verified,
          color: Color(0xFF64B5F6),
          title: 'Verification Completed',
          subtitle: 'Palawan Mangrove — Q1 audit passed',
          amount: '+320t',
          time: '1 week ago',
        ),
        _TxItem(
          icon: Icons.shopping_cart,
          color: Color(0xFF8BAE66),
          title: 'Credits Purchased',
          subtitle: '100 credits from Davao Highland',
          amount: '-\$1,650',
          time: '2 weeks ago',
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => context.go('/marketplace'),
            icon: const Icon(Icons.store),
            label: const Text('Browse Marketplace'),
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

class _ProjectCard extends StatelessWidget {
  final String name, landowner, invested, offset;
  final int credits;
  final double progress;

  const _ProjectCard({
    required this.name,
    required this.landowner,
    required this.credits,
    required this.invested,
    required this.offset,
    required this.progress,
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
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF628141).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.forest, color: Color(0xFF8BAE66), size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                          color: Color(0xFFEBD5AB),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                    Text('by $landowner',
                        style: const TextStyle(color: Color(0xFF8BAE66), fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF8BAE66).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$credits credits',
                  style: const TextStyle(
                      color: Color(0xFF8BAE66), fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF628141).withOpacity(0.15),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8BAE66)),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Invested: $invested',
                  style: const TextStyle(color: Color(0xFF8BAE66), fontSize: 12)),
              Text('Offset: $offset',
                  style: const TextStyle(color: Color(0xFF64B5F6), fontSize: 12)),
              Text('${(progress * 100).toInt()}% verified',
                  style: TextStyle(
                      color: const Color(0xFFEBD5AB).withOpacity(0.5), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _EsgCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A3329), Color(0xFF1B211A)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _EsgStat(value: '2,596', label: 'Tons Offset', color: const Color(0xFF8BAE66)),
              _EsgDivider(),
              _EsgStat(value: '6', label: 'Forests\nSupported', color: const Color(0xFF64B5F6)),
              _EsgDivider(),
              _EsgStat(value: 'A+', label: 'ESG\nRating', color: const Color(0xFFFFD54F)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF628141).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.verified, color: Color(0xFF8BAE66), size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'All offsets independently verified by EchoTrace sensor network',
                    style: TextStyle(color: Color(0xFF8BAE66), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EsgStat extends StatelessWidget {
  final String value, label;
  final Color color;
  const _EsgStat({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w900, color: color)),
        const SizedBox(height: 4),
        Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: const Color(0xFFEBD5AB).withOpacity(0.5),
                fontSize: 11,
                height: 1.3)),
      ],
    );
  }
}

class _EsgDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40, width: 1, color: const Color(0xFF628141).withOpacity(0.3));
  }
}

class _TxItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, subtitle, amount, time;
  const _TxItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.amount,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: TextStyle(
                      color: color, fontSize: 13, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(time,
                  style: TextStyle(
                      color: const Color(0xFFEBD5AB).withOpacity(0.35),
                      fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}