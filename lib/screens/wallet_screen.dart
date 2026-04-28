import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/navbar.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      backgroundColor: const Color(0xFF1B211A),
      appBar: const EchoTraceNavBar(currentRoute: '/wallet', isAuthenticated: true),
      drawer: isDesktop ? null : EchoTraceDrawer(currentRoute: '/wallet'), // FIXED: Removed 'const'
      body: Container(
        color: const Color(0xFFEBD5AB),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Carbon Credits',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B211A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Track your earned credits and redemption history',
                style: TextStyle(fontSize: 16, color: Color(0xFF8BAE66)),
              ),
              const SizedBox(height: 32),

              // Balance card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A3329), Color(0xFF1B211A)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
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
                        color: Color(0xFFEBD5AB),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '127',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF8BAE66),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Equivalent to 127 tons CO₂ absorbed',
                      style: TextStyle(fontSize: 14, color: Color(0xFF8BAE66)),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => context.go('/marketplace'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8BAE66),
                              foregroundColor: const Color(0xFF1B211A),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Sell Credits'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              // Show QR code
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF8BAE66)),
                              foregroundColor: const Color(0xFF8BAE66),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Share QR'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Transaction history
              const Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B211A),
                ),
              ),
              const SizedBox(height: 16),
              _buildTransactionItem(
                type: 'earned',
                title: 'CO₂ Absorption',
                subtitle: 'Plot #2401 - 12kg absorbed',
                amount: '+12',
                date: '2 days ago',
              ),
              _buildTransactionItem(
                type: 'sold',
                title: 'Credit Sale',
                subtitle: 'Sold 25 credits to GreenCorp',
                amount: '-25',
                date: '1 week ago',
              ),
              _buildTransactionItem(
                type: 'earned',
                title: 'CO₂ Absorption',
                subtitle: 'Plot #2402 - 8kg absorbed',
                amount: '+8',
                date: '5 days ago',
              ),
              _buildTransactionItem(
                type: 'earned',
                title: 'CO₂ Absorption',
                subtitle: 'Plot #2401 - 15kg absorbed',
                amount: '+15',
                date: '1 week ago',
              ),
              const SizedBox(height: 32),

              // Market value
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B211A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Market Value',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEBD5AB),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Current market price:',
                            style: TextStyle(fontSize: 16, color: Color(0xFF8BAE66))),
                        Text('\$16.50/credit',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEBD5AB))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Your credits value:',
                            style: TextStyle(fontSize: 16, color: Color(0xFF8BAE66))),
                        Text('\$2,097.50',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8BAE66))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required String type,
    required String title,
    required String subtitle,
    required String amount,
    required String date,
  }) {
    final isEarned = type == 'earned';
    final color = isEarned ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B211A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF628141).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(isEarned ? Icons.add : Icons.remove, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFEBD5AB))),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF8BAE66))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 4),
              Text(date,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF8BAE66))),
            ],
          ),
        ],
      ),
    );
  }
}