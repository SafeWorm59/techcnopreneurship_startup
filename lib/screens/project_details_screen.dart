import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final String id;

  const ProjectDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    // Mock data - in real app, fetch based on id
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
      'image': 'https://images.unsplash.com/photo-1564496027516-78e6fc218e97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcm9uZSUyMHNob3QlMjBmb3Jlc3QlMjBncmVlbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral',
      'tags': ['Pine Forest', 'Indigenous Owned'],
      'description': 'This project protects the buffer zone around Mt. Kitanglad, one of the Philippines\' most important biodiversity hotspots. The indigenous Datu Salise family has stewarded this land for generations, maintaining traditional forest management practices that preserve both biodiversity and carbon sequestration capacity.',
      'area': '45 hectares',
      'plantedDate': '2018',
      'lastAudit': 'December 2023',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        backgroundColor: const Color(0xFF1B211A),
        foregroundColor: const Color(0xFFEBD5AB),
      ),
      drawer: _buildDrawer(context),
      body: Container(
        color: const Color(0xFFEBD5AB),
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
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and tags
                    Text(
                      project['title'] as String,
                      style: TextStyle(
                        fontSize: isDesktop ? 32 : 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B211A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final tag in project['tags'] as List)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF628141).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF8BAE66).withOpacity(0.3)),
                            ),
                            child: Text(
                              tag as String,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF1B211A),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Key metrics
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B211A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildMetric(
                                label: 'Price per Credit',
                                value: '\$${project['price']}',
                                unit: '/${project['currency']}',
                              ),
                              _buildMetric(
                                label: 'Credits Available',
                                value: '${project['creditsAvailable']}',
                                unit: '',
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildMetric(
                                label: 'Absorption Rate',
                                value: project['absorptionRate'] as String,
                                unit: '',
                              ),
                              _buildMetric(
                                label: 'Area',
                                value: project['area'] as String,
                                unit: '',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Description
                    const Text(
                      'About This Project',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B211A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      project['description'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1B211A),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Verification
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Verified & Audited',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1B211A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Verified by ${project['verifiedBy']}. Last audit: ${project['lastAudit']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF1B211A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Owner info
                    const Text(
                      'Project Owner',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B211A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B211A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color(0xFF628141),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF1B211A),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project['owner'] as String,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFEBD5AB),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Color(0xFF8BAE66),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      project['location'] as String,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF8BAE66),
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
                    const SizedBox(height: 32),

                    // Purchase button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle purchase
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Purchase functionality coming soon!'),
                              backgroundColor: Color(0xFF628141),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B211A),
                          foregroundColor: const Color(0xFFEBD5AB),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Purchase Carbon Credits',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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

  Widget _buildMetric({
    required String label,
    required String value,
    required String unit,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8BAE66),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEBD5AB),
                  ),
                ),
                if (unit.isNotEmpty)
                  TextSpan(
                    text: unit,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8BAE66),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1B211A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1B211A),
            ),
            child: Text(
              'EchoTrace',
              style: TextStyle(
                color: Color(0xFFEBD5AB),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFF8BAE66)),
            title: const Text('Home', style: TextStyle(color: Color(0xFFEBD5AB))),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.store, color: Color(0xFF8BAE66)),
            title: const Text('Marketplace', style: TextStyle(color: Color(0xFFEBD5AB))),
            onTap: () {
              Navigator.pop(context);
              context.go('/marketplace');
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Color(0xFF8BAE66)),
            title: const Text('Dashboard', style: TextStyle(color: Color(0xFFEBD5AB))),
            onTap: () {
              Navigator.pop(context);
              context.go('/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.sensors, color: Color(0xFF8BAE66)),
            title: const Text('Sensors', style: TextStyle(color: Color(0xFFEBD5AB))),
            onTap: () {
              Navigator.pop(context);
              context.go('/sensors');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet, color: Color(0xFF8BAE66)),
            title: const Text('Wallet', style: TextStyle(color: Color(0xFFEBD5AB))),
            onTap: () {
              Navigator.pop(context);
              context.go('/wallet');
            },
          ),
        ],
      ),
    );
  }
}