import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/navbar.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: const EchoTraceNavBar(currentRoute: '/wallet'),
      drawer: isDesktop ? null : const EchoTraceDrawer(currentRoute: '/wallet'),
      body: SingleChildScrollView(
        child: MaxWidthContainer(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Carbon Credits',
                  style: Theme.of(context).textTheme.displayMedium,
                ).animate().fade().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 8),
                const Text(
                  'Track your earned credits and redemption history',
                  style: TextStyle(fontSize: 16, color: AppTheme.primary),
                ).animate().fade(delay: 100.ms),
                const SizedBox(height: 32),

                // Balance card
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.surfaceLight, AppTheme.surface],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppTheme.primaryDark.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Available Credits',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '127',
                        style: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.primary,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Equivalent to 127 tons CO₂ absorbed',
                        style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => context.go('/marketplace'),
                              child: const Text('Sell Credits'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _showQrDialog(context), // <--- Trigger QR
                              icon: const Icon(Icons.qr_code_2),
                              label: const Text('Share QR'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fade(delay: 200.ms).scaleXY(begin: 0.95, end: 1.0),

                const SizedBox(height: 48),

                // Transaction history
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                ).animate().fade(delay: 300.ms),
                const SizedBox(height: 16),
                _buildTransactionItem(type: 'earned', title: 'CO₂ Absorption', subtitle: 'Plot #2401 - 12kg absorbed', amount: '+12', date: '2 days ago')
                    .animate().fade(delay: 400.ms).slideX(begin: 0.05, end: 0),
                _buildTransactionItem(type: 'sold', title: 'Credit Sale', subtitle: 'Sold 25 credits to TechCorp', amount: '-25', date: '1 week ago')
                    .animate().fade(delay: 500.ms).slideX(begin: 0.05, end: 0),
                _buildTransactionItem(type: 'earned', title: 'CO₂ Absorption', subtitle: 'Plot #2402 - 8kg absorbed', amount: '+8', date: '5 days ago')
                    .animate().fade(delay: 600.ms).slideX(begin: 0.05, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- NEW: The Interactive QR Dialog ---
  void _showQrDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Proof of Impact', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  IconButton(icon: const Icon(Icons.close, color: AppTheme.textSecondary), onPressed: () => Navigator.pop(ctx)),
                ],
              ),
              const Divider(color: AppTheme.primaryDark),
              const SizedBox(height: 24),

              // Simulated QR Code Graphic
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.qr_code_2, size: 200, color: Colors.black87),
              ).animate().scale(curve: Curves.easeOutBack, duration: 400.ms),

              const SizedBox(height: 24),
              const Text(
                'Scan to view public portfolio',
                style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'Share this code with stakeholders or customers so they can independently verify your carbon offset data.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Link copied to clipboard!'), backgroundColor: AppTheme.primary),
                    );
                  },
                  icon: const Icon(Icons.link),
                  label: const Text('Copy Public Link'),
                ),
              )
            ],
          ),
        ),
      ).animate().fade(),
    );
  }

  Widget _buildTransactionItem({required String type, required String title, required String subtitle, required String amount, required String date}) {
    final isEarned = type == 'earned';
    final color = isEarned ? AppTheme.primary : Colors.redAccent;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
              child: Icon(isEarned ? Icons.add : Icons.remove, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(amount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
                const SizedBox(height: 4),
                Text(date, style: TextStyle(fontSize: 12, color: AppTheme.textPrimary.withOpacity(0.5))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}