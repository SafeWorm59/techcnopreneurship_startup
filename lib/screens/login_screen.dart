import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../utils/auth_state.dart'; // FIXED: Imported globalAuth

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaxWidthContainer(
        maxWidth: 600,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.park, size: 80, color: AppTheme.primary),
              const SizedBox(height: 24),
              Text(
                'Welcome to EchoTrace',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Select your role to enter the prototype',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppTheme.textPrimary.withOpacity(0.6)),
              ),
              const SizedBox(height: 48),

              // Role Selection Buttons
              _RoleCard(
                title: 'Landowner',
                subtitle: 'Manage plots and track carbon absorption via sensors',
                icon: Icons.landscape,
                onTap: () {
                  globalAuth.login('landowner');
                  context.go('/dashboard/landowner');
                },
              ),
              const SizedBox(height: 16),
              _RoleCard(
                title: 'Corporate Buyer',
                subtitle: 'Purchase verified credits to offset carbon footprint',
                icon: Icons.business,
                onTap: () {
                  globalAuth.login('buyer');
                  context.go('/dashboard/buyer');
                },
              ),
              const SizedBox(height: 16),
              _RoleCard(
                title: 'Validator (DENR/NGO)',
                subtitle: 'Verify field data and approve carbon credits',
                icon: Icons.verified_user,
                onTap: () {
                  globalAuth.login('validator');
                  context.go('/dashboard/validator');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryDark.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: AppTheme.primary, size: 32),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textPrimary.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}