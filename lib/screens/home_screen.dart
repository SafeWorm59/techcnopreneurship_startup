import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      backgroundColor: const Color(0xFF1B211A),
      // Guest navbar — only Login + Create Account visible
      appBar: const EchoTraceNavBar(
        currentRoute: '/',
        isAuthenticated: false,
      ),
      // No drawer on home — user is a guest
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: isDesktop ? 600 : 500,
              decoration: const BoxDecoration(
                color: Color(0xFF1B211A),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1684853693031-ab9e3f8c9d5e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhZXJpYWwlMjBmb3Jlc3QlMjBidWtpZG5vbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xFF1B211A)],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF628141).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xFF8BAE66).withOpacity(0.3)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _PulseDot(),
                              SizedBox(width: 8),
                              Text(
                                'Live Carbon Verification in Bukidnon',
                                style: TextStyle(
                                  color: Color(0xFFEBD5AB),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Turn Standing Trees Into\nVerifiable Green Capital.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isDesktop ? 48 : 32,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFEBD5AB),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Sensors for landowners. Real-time proof for corporate buyers.\nKeep trees standing. Get paid.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF8BAE66),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => context.go('/login'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEBD5AB),
                                foregroundColor: const Color(0xFF1B211A),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 8,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Explore Verified Credits',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () => context.go('/login'),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF8BAE66)),
                                backgroundColor: const Color(0xFF628141),
                                foregroundColor: const Color(0xFFEBD5AB),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'I am a Landowner',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Value Props Section
            Container(
              color: const Color(0xFFEBD5AB),
              padding:
              const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Bridging the gap between\nBukidnon and Global Net-Zero',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isDesktop ? 36 : 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B211A),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 64),
                  GridView.count(
                    crossAxisCount: isDesktop ? 3 : 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 32,
                    crossAxisSpacing: 32,
                    children: [
                      _buildFeatureCard(
                        icon: Icons.analytics,
                        title: 'EchoTrace IoT Sensors',
                        description:
                        'Automated tracking of CO2 absorption replaces manual logs. We install sensors for free; you pay only when credits are sold.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.verified,
                        title: 'Verified Legitimacy',
                        description:
                        'Sensor validation provides the objective proof that global buyers demand. Say goodbye to opaque carbon offsets.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.forest,
                        title: 'Earn Without Cutting',
                        description:
                        'Trees now have cash value while standing. Landowners gain profit, avoiding the pressure to cut for agriculture.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1B211A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF628141).withOpacity(0.2)),
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
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF628141),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFFEBD5AB), size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEBD5AB),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF8BAE66),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseDot extends StatefulWidget {
  const _PulseDot();

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF8BAE66),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}