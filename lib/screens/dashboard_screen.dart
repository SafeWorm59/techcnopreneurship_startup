import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // <--- Added Animations
import '../widgets/navbar.dart';
import '../utils/responsive.dart';
import '../theme/app_theme.dart';

abstract class BaseDashboardScreen extends StatelessWidget {
  const BaseDashboardScreen({super.key});

  String get role;
  String get displayName;
  String get displaySubtitle;
  IconData get roleIcon;
  List<DashboardStat> get stats;
  Widget buildRoleContent(BuildContext context);

  // FIXED: Proper badge logic for all 3 roles
  String get badgeLabel {
    if (role == 'landowner') return 'Bukidnon Landowner';
    if (role == 'validator') return 'Official Validator';
    return 'Corporate Buyer';
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: EchoTraceNavBar(currentRoute: '/dashboard/$role'),
      body: SingleChildScrollView(
        child: MaxWidthContainer(
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 40 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 32),
                _buildStatsGrid(context),
                const SizedBox(height: 40),
                buildRoleContent(context),
              ],
            ).animate() // <--- Pro UI Entrance Animation
                .fade(duration: 500.ms)
                .slideY(begin: 0.05, end: 0, curve: Curves.easeOutQuart),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.surfaceLight, AppTheme.surface],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primaryDark.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.primaryDark]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(roleIcon, color: AppTheme.surface, size: 36),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppTheme.textPrimary),
                ),
                const SizedBox(height: 6),
                Text(displaySubtitle, style: const TextStyle(fontSize: 15, color: AppTheme.primary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryDark.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppTheme.primaryDark.withOpacity(0.4)),
            ),
            child: Text(
              badgeLabel,
              style: const TextStyle(color: AppTheme.primary, fontSize: 13, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            mainAxisExtent: 160,
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) => _StatCard(stat: stats[index])
              .animate(delay: (100 * index).ms) // Staggered card animations
              .fade()
              .scaleXY(begin: 0.95, end: 1.0, curve: Curves.easeOutBack),
        );
      },
    );
  }
}

class DashboardStat {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color accentColor;

  const DashboardStat({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    this.accentColor = AppTheme.primary,
  });
}

class _StatCard extends StatelessWidget {
  final DashboardStat stat;
  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: stat.accentColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(stat.icon, color: stat.accentColor, size: 24),
                ),
                Text(
                  stat.unit,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textPrimary.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              stat.value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: stat.accentColor,
                height: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              stat.label,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}