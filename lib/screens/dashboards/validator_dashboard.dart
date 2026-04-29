import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../dashboard_screen.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart'; // NEW

class ValidatorDashboard extends BaseDashboardScreen {
  const ValidatorDashboard({super.key});

  @override
  String get role => 'validator';
  @override
  String get displayName => 'Dir. Maria Santos';
  @override
  String get displaySubtitle => 'DENR Region 10 - Bukidnon Field Office';
  @override
  IconData get roleIcon => Icons.verified_user;

  @override
  List<DashboardStat> get stats => const [
    DashboardStat(label: 'Pending MOAs', value: '3', unit: 'Projects', icon: Icons.gavel, accentColor: Colors.orange),
    DashboardStat(label: 'DBH Field Checks', value: '12', unit: 'Awaiting', icon: Icons.straighten),
    DashboardStat(label: 'DENR Revenue (10%)', value: '₱142k', unit: 'Allocated', icon: Icons.account_balance, accentColor: Colors.blueAccent),
  ];

  @override
  Widget buildRoleContent(BuildContext context) {
    return const _ValidationQueue();
  }
}

class _ValidationQueue extends StatefulWidget {
  const _ValidationQueue();
  @override
  State<_ValidationQueue> createState() => _ValidationQueueState();
}

class _ValidationQueueState extends State<_ValidationQueue> {
  List<Map<String, String>> pendingQueue = [
    {'id': 'B-04', 'title': 'Impasugong Sector 4', 'dbh': '42cm', 'biomass': '45kg'},
    {'id': 'P-12', 'title': 'Kalatungan Range Reserve', 'dbh': '15cm', 'biomass': '12kg'},
    {'id': 'D-09', 'title': 'Talakag Agroforestry Belt', 'dbh': '38cm', 'biomass': '38kg'},
  ];

  void _handleAction(int index, bool isApproved) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator(color: AppTheme.primary)),
    );
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) Navigator.pop(context);

    setState(() {
      pendingQueue.removeAt(index);
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isApproved ? 'Project Successfully Validated.' : 'Project Data Declined.'),
          backgroundColor: isApproved ? Colors.green : Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: Text('National Greening Program (NGP) Cross-Check', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary))),
            const SizedBox(width: 16),
            Text('${pendingQueue.length} Pending', style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 24),
        if (pendingQueue.isEmpty)
          Container(
            padding: const EdgeInsets.all(40),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppTheme.surfaceLight, borderRadius: BorderRadius.circular(20)),
            child: const Text('All field checks completed. Queue is empty.', style: TextStyle(color: AppTheme.primary, fontSize: 18)),
          ).animate().fade()
        else
          ...pendingQueue.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;

            // FIXED: Broken row buttons forced this text to squish. Made it responsive.
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primaryDark.withOpacity(0.3)),
              ),
              padding: const EdgeInsets.all(24),
              child: isMobile
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.assignment_late, color: Colors.orange, size: 36),
                      const SizedBox(width: 16),
                      Expanded(child: Text('Verify DBH Data: ${item['title']}', style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 18))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('IoT reported DBH: ${item['dbh']}. Manual field check required to authorize carbon token minting.', style: const TextStyle(color: AppTheme.textSecondary, height: 1.5)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () => _handleAction(idx, false),
                        icon: const Icon(Icons.close, color: Colors.redAccent),
                        label: const Text('Decline', style: TextStyle(color: Colors.redAccent)),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () => _handleAction(idx, true),
                        icon: const Icon(Icons.check),
                        label: const Text('Approve'),
                      ),
                    ],
                  ),
                ],
              )
                  : Row(
                children: [
                  const Icon(Icons.assignment_late, color: Colors.orange, size: 36),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Verify DBH Data: ${item['title']}', style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 18)),
                        const SizedBox(height: 8),
                        Text('IoT reported DBH: ${item['dbh']}. Manual field check required to authorize carbon token minting.', style: const TextStyle(color: AppTheme.textSecondary, height: 1.5)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton.icon(
                        onPressed: () => _handleAction(idx, false),
                        icon: const Icon(Icons.close, color: Colors.redAccent),
                        label: const Text('Decline', style: TextStyle(color: Colors.redAccent)),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () => _handleAction(idx, true),
                        icon: const Icon(Icons.check),
                        label: const Text('Approve'),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fade(delay: (100 * idx).ms).slideX(begin: 0.05);
          }),
      ],
    );
  }
}