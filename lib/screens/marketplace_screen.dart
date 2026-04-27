import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _listings = [
    {
      'id': 1,
      'title': 'Mt. Kitanglad Buffer Zone Project',
      'location': 'Impasugong, Bukidnon',
      'owner': 'Datu Salise Family',
      'price': 15.50,
      'currency': 'USD',
      'creditsAvailable': 1200,
      'absorptionRate': '1.2 tons CO2/day',
      'verifiedBy': 'BENRO & EchoTrace IoT',
      'image': 'https://images.unsplash.com/photo-1564496027516-78e6fc218e97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcm9uZSUyMHNob3QlMjBmb3Jlc3QlMjBncmVlbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral',
      'tags': ['Pine Forest', 'Indigenous Owned'],
    },
    {
      'id': 2,
      'title': 'Kalatungan Range Reforestation',
      'location': 'Pangantucan, Bukidnon',
      'owner': 'Talakag Farmers Coop',
      'price': 18.00,
      'currency': 'USD',
      'creditsAvailable': 850,
      'absorptionRate': '0.9 tons CO2/day',
      'verifiedBy': 'EchoTrace IoT',
      'image': 'https://images.unsplash.com/photo-1684853693031-ab9e3f8c9d5e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhZXJpYWwlMjBmb3Jlc3QlMjBidWtpZG5vbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral',
      'tags': ['Mahogany', 'Community Coop'],
    },
    {
      'id': 3,
      'title': 'Manolo Fortich Canopy Cover',
      'location': 'Manolo Fortich, Bukidnon',
      'owner': 'Araneta Estate',
      'price': 14.20,
      'currency': 'USD',
      'creditsAvailable': 3400,
      'absorptionRate': '3.5 tons CO2/day',
      'verifiedBy': 'EchoTrace IoT & Local LGU',
      'image': 'https://images.unsplash.com/photo-1564496027516-78e6fc218e97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcm9uZSUyMHNob3QlMjBmb3Jlc3QlMjBncmVlbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral',
      'tags': ['Mixed Dipterocarp', 'Private'],
    },
  ];

  List<Map<String, dynamic>> get _filteredListings {
    if (_searchQuery.isEmpty) return _listings;
    return _listings.where((listing) {
      final query = _searchQuery.toLowerCase();
      return listing['title'].toLowerCase().contains(query) ||
             listing['location'].toLowerCase().contains(query) ||
             listing['owner'].toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        backgroundColor: const Color(0xFF1B211A),
        foregroundColor: const Color(0xFFEBD5AB),
        actions: isDesktop ? _buildDesktopNav(context) : null,
      ),
      drawer: isDesktop ? null : _buildDrawer(context),
      body: Container(
        color: const Color(0xFFEBD5AB),
        child: Column(
          children: [
            // Header
            Container(
              color: const Color(0xFF1B211A),
              padding: const EdgeInsets.fromLTRB(24, 100, 24, 80),
              child: Column(
                children: [
                  Text(
                    'Verified Carbon Credit Marketplace',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isDesktop ? 48 : 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFEBD5AB),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Directly purchase scientifically-backed carbon offsets from Bukidnon landowners. Real data. Real impact.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8BAE66),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    constraints: BoxConstraints(maxWidth: isDesktop ? 600 : double.infinity),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        hintText: 'Search by location, owner, or project name...',
                        hintStyle: const TextStyle(color: Color(0xFF8BAE66)),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF8BAE66)),
                        filled: true,
                        fillColor: const Color(0xFF1B211A),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Color(0xFF628141), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Color(0xFF628141), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Color(0xFF8BAE66), width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      ),
                      style: const TextStyle(color: Color(0xFFEBD5AB)),
                    ),
                  ),
                ],
              ),
            ),

            // Listings
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: _filteredListings.length,
                itemBuilder: (context, index) {
                  final listing = _filteredListings[index];
                  return _buildListingCard(listing, isDesktop);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListingCard(Map<String, dynamic> listing, bool isDesktop) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1B211A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.go('/project/${listing['id']}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and basic info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      listing['image'],
                      width: isDesktop ? 200 : 120,
                      height: isDesktop ? 150 : 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listing['title'],
                          style: TextStyle(
                            fontSize: isDesktop ? 24 : 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFEBD5AB),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Color(0xFF8BAE66)),
                            const SizedBox(width: 4),
                            Text(
                              listing['location'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8BAE66),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Owner: ${listing['owner']}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8BAE66),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              '\$${listing['price']}/${listing['currency']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEBD5AB),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '${listing['creditsAvailable']} credits available',
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
              const SizedBox(height: 24),

              // Tags and details
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in listing['tags'])
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF628141).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF8BAE66).withOpacity(0.3)),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFEBD5AB),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  const Icon(Icons.eco, size: 16, color: Color(0xFF8BAE66)),
                  const SizedBox(width: 4),
                  Text(
                    listing['absorptionRate'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8BAE66),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.verified, size: 16, color: Color(0xFF8BAE66)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Verified by ${listing['verifiedBy']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8BAE66),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => context.go('/project/${listing['id']}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEBD5AB),
                    foregroundColor: const Color(0xFF1B211A),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('View Details'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDesktopNav(BuildContext context) {
    return [
      TextButton(
        onPressed: () => context.go('/'),
        child: const Text('Home', style: TextStyle(color: Color(0xFFEBD5AB))),
      ),
      TextButton(
        onPressed: () => context.go('/marketplace'),
        child: const Text('Marketplace', style: TextStyle(color: Color(0xFFEBD5AB))),
      ),
      TextButton(
        onPressed: () => context.go('/dashboard'),
        child: const Text('Dashboard', style: TextStyle(color: Color(0xFFEBD5AB))),
      ),
      TextButton(
        onPressed: () => context.go('/sensors'),
        child: const Text('Sensors', style: TextStyle(color: Color(0xFFEBD5AB))),
      ),
      TextButton(
        onPressed: () => context.go('/wallet'),
        child: const Text('Wallet', style: TextStyle(color: Color(0xFFEBD5AB))),
      ),
    ];
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