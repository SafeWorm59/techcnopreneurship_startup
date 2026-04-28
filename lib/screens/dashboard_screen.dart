import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

/// Base dashboard that role-specific screens extend.
/// Override [role], [stats], and [buildBody] to customize per role.
abstract class BaseDashboardScreen extends StatelessWidget {
  const BaseDashboardScreen({super.key});

  /// Route string for active nav highlight
  String get role; // 'landowner' or 'buyer'

  String get displayName;
  String get displaySubtitle;
  IconData get roleIcon;

  /// The 3 stat cards to show at the top
  List<DashboardStat> get stats;

  /// Role-specific content below the stats
  Widget buildRoleContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      backgroundColor: const Color(0xFF1B211A),
      appBar: EchoTraceNavBar(currentRoute: '/dashboard', isAuthenticated: true),
      drawer: isDesktop ? null : const EchoTraceDrawer(currentRoute: '/dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2A3329), Color(0xFF1B211A)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8BAE66), Color(0xFF628141)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(roleIcon, color: const Color(0xFF1B211A), size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFEBD5AB),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          displaySubtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8BAE66),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF628141).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF628141).withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF8BAE66),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          role == 'landowner' ? 'Landowner' : 'Corporate Buyer',
                          style: const TextStyle(
                            color: Color(0xFF8BAE66),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Stat cards
            isDesktop
                ? Row(
              children: stats
                  .map((s) => Expanded(child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _StatCard(stat: s),
              )))
                  .toList(),
            )
                : Column(
              children: stats
                  .map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _StatCard(stat: s),
              ))
                  .toList(),
            ),

            const SizedBox(height: 28),

            // Role-specific content
            buildRoleContent(context),
          ],
        ),
      ),
    );
  }
}

/// Data class for a stat card
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
    this.accentColor = const Color(0xFF8BAE66),
  });
}

class _StatCard extends StatelessWidget {
  final DashboardStat stat;
  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF232B21),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF628141).withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: stat.accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(stat.icon, color: stat.accentColor, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            stat.value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: stat.accentColor,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.unit,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF8BAE66),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stat.label,
            style: TextStyle(
              fontSize: 13,
              color: const Color(0xFFEBD5AB).withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}