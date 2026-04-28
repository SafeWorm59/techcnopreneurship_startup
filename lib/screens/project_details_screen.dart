import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/navbar.dart';
import '../utils/auth_state.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final String id;

  const ProjectDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    final project = {
      'id': id,
      'title': 'Mt. Kitanglad Buffer Zone Project',
      'location': 'Impasugong, Bukidnon',
      'owner': 'Datu Salise Family',
      'price': 15.50,
      'currency': 'USD',
      'creditsAvailable': 1200,
      'absorptionRate': '1.2 tons CO2/day',
      'verifiedBy': 'DENR & EchoTrace IoT',
      'image': 'https://images.unsplash.com/photo-1564496027516-78e6fc218e97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080',
      'tags': ['Pine Forest', 'Indigenous Owned'],
      'description': 'This project protects the buffer zone around Mt. Kitanglad, one of the Philippines\' most important biodiversity hotspots. The indigenous Datu Salise family has stewarded this land for generations, maintaining traditional forest management practices that preserve both biodiversity and carbon sequestration capacity.',
      'area': '45 hectares',
      'plantedDate': '2018',
      'lastAudit': 'December 2023',
    };

    return Scaffold(
      appBar: const EchoTraceNavBar(currentRoute: '/marketplace'),
      body: Container(
        color: AppTheme.background,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image
              Container(
                height: isDesktop ? 400 : 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(project['image'] as String),
                    fit: BoxFit.cover,
                  ),
                ),
              ).animate().fade(duration: 600.ms),

              Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project['title'] as String,
                          style: Theme.of(context).textTheme.displayMedium,
                        ).animate().fade(delay: 100.ms).slideY(begin: 0.1),
                        const SizedBox(height: 16),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final tag in project['tags'] as List)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryDark.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppTheme.primaryDark),
                                ),
                                child: Text(tag as String, style: const TextStyle(fontSize: 12, color: AppTheme.primary)),
                              ),
                          ],
                        ).animate().fade(delay: 200.ms),

                        const SizedBox(height: 32),

                        // Key metrics
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceLight,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppTheme.primaryDark.withOpacity(0.3)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  _buildMetric('Price per Credit', '\$${project['price']}', '/${project['currency']}'),
                                  _buildMetric('Credits Available', '${project['creditsAvailable']}', ''),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  _buildMetric('Absorption Rate', project['absorptionRate'] as String, ''),
                                  _buildMetric('Area', project['area'] as String, ''),
                                ],
                              ),
                            ],
                          ),
                        ).animate().fade(delay: 300.ms).scaleXY(begin: 0.95),

                        const SizedBox(height: 32),

                        // Dynamic CTA Section
                        ValueListenableBuilder<String?>(
                          valueListenable: globalAuth.currentRole,
                          builder: (context, role, child) {
                            String btnText = 'Purchase Carbon Credits';
                            IconData btnIcon = Icons.shopping_cart;
                            Color btnColor = AppTheme.primary;

                            if (role == 'landowner') {
                              btnText = 'Sell Carbon Credits';
                              btnIcon = Icons.sell;
                              btnColor = Colors.amber;
                            } else if (role == 'validator') {
                              btnText = 'Verify Project Data';
                              btnIcon = Icons.verified_user;
                              btnColor = Colors.blueAccent;
                            }

                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('$btnText action simulated successfully.'),
                                      backgroundColor: btnColor,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: btnColor,
                                  foregroundColor: AppTheme.background,
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                icon: Icon(btnIcon),
                                label: Text(btnText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ),
                            ).animate().fade(delay: 500.ms).slideY(begin: 0.2);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value, String unit) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppTheme.textPrimary)),
                if (unit.isNotEmpty) TextSpan(text: unit, style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}