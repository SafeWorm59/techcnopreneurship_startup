import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../dashboard_screen.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart'; // NEW

class BuyerDashboard extends BaseDashboardScreen {
  const BuyerDashboard({super.key});

  @override
  String get role => 'buyer';
  @override
  String get displayName => 'TechCorp Global';
  @override
  String get displaySubtitle => 'Sustainability Division';
  @override
  IconData get roleIcon => Icons.business;

  @override
  List<DashboardStat> get stats => const [
    DashboardStat(label: 'Credits Purchased', value: '2,500', unit: 'Tokens', icon: Icons.shopping_cart),
    DashboardStat(label: 'Offset Goal', value: '85%', unit: 'Progress', icon: Icons.track_changes, accentColor: Colors.blueAccent),
    DashboardStat(label: 'Supported Farms', value: '12', unit: 'Bukidnon', icon: Icons.favorite, accentColor: Colors.redAccent),
  ];

  @override
  Widget buildRoleContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Active Offset Portfolio',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
        ),
        const SizedBox(height: 24),
        _buildPortfolioItem(context, 'Bukidnon Northern Reserve', '1,200 Credits', 0),
        const SizedBox(height: 16),
        _buildPortfolioItem(context, 'Kalatungan Range Reforestation', '850 Credits', 1),
        const SizedBox(height: 16),
        _buildPortfolioItem(context, 'Talakag Agroforestry Belt', '450 Credits', 2),
      ],
    );
  }

  // FIXED: Replaced rigid ListTile with a responsive Column/Row setup
  Widget _buildPortfolioItem(BuildContext context, String title, String credits, int index) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryDark.withOpacity(0.4)),
      ),
      padding: const EdgeInsets.all(24),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.forest, color: AppTheme.primary, size: 36),
              const SizedBox(width: 16),
              Expanded(child: Text(title, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 18))),
            ],
          ),
          const SizedBox(height: 12),
          Text('$credits • Verified by DENR • IoT Active', style: const TextStyle(color: AppTheme.textSecondary)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
                onPressed: () => _showImpactReport(context, title, credits),
                icon: const Icon(Icons.picture_as_pdf, size: 18),
                label: const Text('View Impact Report')
            ),
          ),
        ],
      )
          : Row(
        children: [
          const Icon(Icons.forest, color: AppTheme.primary, size: 36),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 18)),
                const SizedBox(height: 4),
                Text('$credits • Verified by DENR • IoT Active', style: const TextStyle(color: AppTheme.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
              onPressed: () => _showImpactReport(context, title, credits),
              icon: const Icon(Icons.picture_as_pdf, size: 18),
              label: const Text('View Impact Report')
          ),
        ],
      ),
    ).animate().fade(delay: (100 * index).ms).slideX(begin: 0.05);
  }

  void _showImpactReport(BuildContext context, String project, String credits) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFFF4F4F4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 550,
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified, color: Colors.green, size: 64),
              const SizedBox(height: 16),
              const Text('CERTIFICATE OF OFFSET', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black87, letterSpacing: 2), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              const Text('Issued to TechCorp Global', style: TextStyle(fontSize: 16, color: Colors.black54)),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Divider(color: Colors.black26),
              ),
              _reportRow('Project Location:', '$project, Philippines'),
              _reportRow('Beneficiary:', 'Local Bukidnon Landowner'),
              _reportRow('Tons CO2 Offset:', credits.replaceAll(' Credits', ' Metric Tons')),
              _reportRow('Validation Protocol:', 'EchoTrace IoT + DENR Manual Audit'),
              _reportRow('Date Retired:', 'April 28, 2026'),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black87),
                      foregroundColor: Colors.black87
                  ),
                  child: const Text('Download PDF'),
                ),
              )
            ],
          ),
        ),
      ).animate().scale(curve: Curves.easeOutBack),
    );
  }

  Widget _reportRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(width: 16),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.black54), textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}