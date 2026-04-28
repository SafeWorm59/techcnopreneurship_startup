import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _error = 'Please enter your email and password.');
      return;
    }
    setState(() {
      _isLoading = true;
      _error = null;
    });
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() => _isLoading = false);
    if (mounted) {
      // Replace with real auth logic; using landowner as default
      _loginAs('landowner');
    }
  }

  void _loginAs(String role) {
    // Store role in your auth provider here, then navigate
    if (role == 'landowner') {
      context.go('/dashboard/landowner');
    } else {
      context.go('/dashboard/buyer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B211A),
      body: Stack(
        children: [
          // Background glows
          Positioned(
            top: -80,
            left: MediaQuery.of(context).size.width * 0.1,
            child: _buildGlow(350, const Color(0xFF628141), 0.12),
          ),
          Positioned(
            bottom: -60,
            right: MediaQuery.of(context).size.width * 0.05,
            child: _buildGlow(280, const Color(0xFF628141), 0.07),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF8BAE66), Color(0xFF628141)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF628141).withOpacity(0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.park,
                          color: Color(0xFF1B211A),
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFEBD5AB),
                            letterSpacing: -0.5,
                          ),
                          children: [
                            TextSpan(text: 'Echo'),
                            TextSpan(
                              text: 'Trace',
                              style: TextStyle(color: Color(0xFF8BAE66)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 36),

                  // Card
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B211A).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: const Color(0xFF628141).withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 40,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Live badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF628141).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF628141).withOpacity(0.25),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (_, __) => Opacity(
                                  opacity: _pulseAnimation.value,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF8BAE66),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Live Carbon Verification Network',
                                style: TextStyle(
                                  color: Color(0xFF8BAE66),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Sign in to your\naccount',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFEBD5AB),
                            height: 1.15,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Access your carbon credit dashboard and portfolio.',
                          style: TextStyle(
                            color: Color(0xFF8BAE66),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Email field
                        _buildFieldLabel('Email Address'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _emailController,
                          hint: 'you@example.com',
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 18),

                        // Password field
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFieldLabel('Password'),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Color(0xFF8BAE66),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _passwordController,
                          hint: '••••••••',
                          obscure: true,
                        ),

                        if (_error != null) ...[
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.red.withOpacity(0.2),
                              ),
                            ),
                            child: Text(
                              _error!,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],

                        const SizedBox(height: 22),

                        // Sign In button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8BAE66), Color(0xFF628141)],
                              ),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF628141).withOpacity(0.35),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                foregroundColor: const Color(0xFF1B211A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Color(0xFF1B211A),
                                ),
                              )
                                  : const Text(
                                'Sign In →',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: const Color(0xFF628141).withOpacity(0.2),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'or try a demo account',
                                style: TextStyle(
                                  color: Color(0xFF8BAE66),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: const Color(0xFF628141).withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Demo buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildDemoButton(
                                icon: Icons.park,
                                label: 'Landowner',
                                sublabel: 'Datu Salise · Bukidnon',
                                iconBg: const Color(0xFF628141).withOpacity(0.25),
                                iconColor: const Color(0xFF8BAE66),
                                onTap: () => _loginAs('landowner'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDemoButton(
                                icon: Icons.business,
                                label: 'Corporate Buyer',
                                sublabel: 'Global Airlines Inc.',
                                iconBg: const Color(0xFFEBD5AB).withOpacity(0.1),
                                iconColor: const Color(0xFFEBD5AB),
                                onTap: () => _loginAs('corporate'),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Register link
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: Color(0xFF8BAE66),
                                fontSize: 13,
                              ),
                              children: [
                                const TextSpan(text: "Don't have an account? "),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () => context.go('/register'),
                                    child: const Text(
                                      'Register here',
                                      style: TextStyle(
                                        color: Color(0xFF8BAE66),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Color(0xFF8BAE66),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Secured by
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_user,
                              size: 13,
                              color: Color(0xFF628141),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Secured by EchoTrace network',
                              style: TextStyle(
                                color: Color(0xFF628141),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlow(double size, Color color, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(opacity),
      ),
      child: BackdropFilter(
        filter: ColorFilter.mode(
          color.withOpacity(opacity),
          BlendMode.srcOver,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        color: Color(0xFFEBD5AB),
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      style: const TextStyle(
        color: Color(0xFFEBD5AB),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: const Color(0xFF8BAE66).withOpacity(0.35),
          fontSize: 14,
        ),
        filled: true,
        fillColor: const Color(0xFFEBD5AB).withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: const Color(0xFF628141).withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF8BAE66),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildDemoButton({
    required IconData icon,
    required String label,
    required String sublabel,
    required Color iconBg,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEBD5AB).withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFF628141).withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFEBD5AB),
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sublabel,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF8BAE66),
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}