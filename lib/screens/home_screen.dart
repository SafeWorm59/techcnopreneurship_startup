import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/navbar.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: const EchoTraceNavBar(currentRoute: '/'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Rich Hero Section
            Container(
              constraints: BoxConstraints(minHeight: isDesktop ? 650 : 550),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1684853693031-ab9e3f8c9d5e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhZXJpYWwlMjBmb3Jlc3QlMjBidWtpZG5vbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.background.withOpacity(0.4),
                      AppTheme.background,
                    ],
                  ),
                ),
                child: Center(
                  child: MaxWidthContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryDark.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppTheme.primary.withOpacity(0.5)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _PulseDot(),
                                SizedBox(width: 8),
                                Text(
                                  'Live Carbon Verification in Bukidnon',
                                  style: TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ).animate().fade().slideY(begin: -0.2),
                          const SizedBox(height: 32),
                          Text(
                            'Turn Standing Trees Into\nVerifiable Green Capital.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayLarge,
                          ).animate().fade(delay: 200.ms).slideY(begin: 0.1, end: 0),
                          const SizedBox(height: 24),
                          Text(
                            'Sensors for landowners. Real-time proof for corporate buyers.\nKeep trees standing. Get paid.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: AppTheme.textPrimary.withOpacity(0.8), height: 1.5),
                          ).animate().fade(delay: 400.ms),
                          const SizedBox(height: 48),
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => context.go('/login'),
                                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20)),
                                icon: const Icon(Icons.rocket_launch),
                                label: const Text('Enter Prototype'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => context.go('/marketplace'),
                                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20)),
                                icon: const Icon(Icons.store),
                                label: const Text('Explore Marketplace'),
                              ),
                            ],
                          ).animate().fade(delay: 600.ms).slideY(begin: 0.2, end: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Value Props Grid Section
            Container(
              color: AppTheme.surface,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
              child: MaxWidthContainer(
                child: Column(
                  children: [
                    Text(
                      'Bridging the gap between\nBukidnon and Global Net-Zero',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ).animate().fade().slideY(),
                    const SizedBox(height: 64),
                    // FIXED: Dynamic Layout to avoid GridView constraint crashes on Mobile
                    if (isMobile)
                      Column(
                        children: [
                          _buildFeatureCard(
                            icon: Icons.analytics,
                            title: 'EchoTrace IoT Sensors',
                            description: 'Automated tracking of CO2 absorption replaces manual logs. We offer a low-barrier entry via an affordable equipment lease (₱1,500/mo), opening a long-term pathway to turn land into income.',
                            delay: 100,
                          ),
                          const SizedBox(height: 24),
                          _buildFeatureCard(
                            icon: Icons.verified,
                            title: 'Verified Legitimacy',
                            description: 'DENR cross-validation provides the objective proof that global buyers demand. Say goodbye to opaque carbon offsets.',
                            delay: 200,
                          ),
                          const SizedBox(height: 24),
                          _buildFeatureCard(
                            icon: Icons.forest,
                            title: 'Earn Without Cutting',
                            description: 'Trees now have cash value while standing. Landowners gain profit, avoiding the pressure to cut for agriculture.',
                            delay: 300,
                          ),
                        ],
                      )
                    else
                      GridView.count(
                        crossAxisCount: isDesktop ? 3 : 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 32,
                        childAspectRatio: isDesktop ? 0.85 : 1.0,
                        children: [
                          _buildFeatureCard(
                            icon: Icons.analytics,
                            title: 'EchoTrace IoT Sensors',
                            description: 'Automated tracking of CO2 absorption replaces manual logs. We offer a low-barrier entry via an affordable equipment lease (₱1,500/mo), opening a long-term pathway to turn land into income.',
                            delay: 100,
                          ),
                          _buildFeatureCard(
                            icon: Icons.verified,
                            title: 'Verified Legitimacy',
                            description: 'DENR cross-validation provides the objective proof that global buyers demand. Say goodbye to opaque carbon offsets.',
                            delay: 200,
                          ),
                          _buildFeatureCard(
                            icon: Icons.forest,
                            title: 'Earn Without Cutting',
                            description: 'Trees now have cash value while standing. Landowners gain profit, avoiding the pressure to cut for agriculture.',
                            delay: 300,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FIXED: Removed the dangerous "Expanded" widget around text to prevent Height Overflows
  Widget _buildFeatureCard({required IconData icon, required String title, required String description, required int delay}) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryDark.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 36),
          ),
          const SizedBox(height: 24),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
          const SizedBox(height: 16),
          Text(description, style: const TextStyle(fontSize: 15, color: AppTheme.textSecondary, height: 1.6)),
        ],
      ),
    ).animate().fade(delay: delay.ms).scaleXY(begin: 0.95);
  }
}

class _PulseDot extends StatefulWidget {
  const _PulseDot();
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
        ),
      ),
    );
  }
}