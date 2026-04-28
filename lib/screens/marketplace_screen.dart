import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/navbar.dart';
import '../data/mock_data.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<MarketplaceListing> get _filteredListings {
    if (_searchQuery.isEmpty) return MockData.listings;
    final query = _searchQuery.toLowerCase();
    return MockData.listings.where((l) {
      return l.title.toLowerCase().contains(query) ||
          l.location.toLowerCase().contains(query) ||
          l.owner.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      backgroundColor: const Color(0xFF1B211A),
      appBar: const EchoTraceNavBar(
        currentRoute: '/marketplace',
        isAuthenticated: false, // ← swap to true once user is logged in
      ),
      drawer: isDesktop ? null : EchoTraceDrawer(currentRoute: '/marketplace'), // FIXED: Removed 'const'
      body: Column(
        children: [
          // Hero header
          Container(
            color: const Color(0xFF1B211A),
            padding: EdgeInsets.fromLTRB(24, isDesktop ? 64 : 40, 24, 48),
            child: Column(
              children: [
                Text(
                  'Verified Carbon Credit\nMarketplace',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isDesktop ? 44 : 28,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFEBD5AB),
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Directly purchase scientifically-backed carbon offsets\nfrom Bukidnon landowners. Real data. Real impact.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF8BAE66),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                // Search bar
                Container(
                  constraints:
                  BoxConstraints(maxWidth: isDesktop ? 580 : double.infinity),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: const TextStyle(color: Color(0xFFEBD5AB)),
                    decoration: InputDecoration(
                      hintText: 'Search by location, owner, or project name...',
                      hintStyle: TextStyle(
                          color: const Color(0xFF8BAE66).withOpacity(0.5),
                          fontSize: 14),
                      prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF8BAE66)),
                      filled: true,
                      fillColor: const Color(0xFF232B21),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Color(0xFF628141), width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Color(0xFF628141), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Color(0xFF8BAE66), width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Result count
                Text(
                  '${_filteredListings.length} project${_filteredListings.length == 1 ? '' : 's'} available',
                  style: TextStyle(
                    color: const Color(0xFF8BAE66).withOpacity(0.7),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Listings
          Expanded(
            child: Container(
              color: const Color(0xFFEBD5AB),
              child: _filteredListings.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: EdgeInsets.all(isDesktop ? 32 : 16),
                itemCount: _filteredListings.length,
                itemBuilder: (context, index) {
                  return _ListingCard(
                    listing: _filteredListings[index],
                    isDesktop: isDesktop,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.forest_outlined,
              size: 64, color: const Color(0xFF628141).withOpacity(0.4)),
          const SizedBox(height: 16),
          const Text(
            'No projects found',
            style: TextStyle(
              color: Color(0xFF1B211A),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try a different search term.',
            style: TextStyle(color: Color(0xFF628141), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _ListingCard extends StatelessWidget {
  final MarketplaceListing listing;
  final bool isDesktop;

  const _ListingCard({required this.listing, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B211A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF628141).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.go('/project/${listing.id}'),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      listing.image,
                      width: isDesktop ? 180 : 100,
                      height: isDesktop ? 130 : 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: isDesktop ? 180 : 100,
                        height: isDesktop ? 130 : 80,
                        color: const Color(0xFF628141).withOpacity(0.2),
                        child: const Icon(Icons.forest,
                            color: Color(0xFF8BAE66), size: 32),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listing.title,
                          style: TextStyle(
                            fontSize: isDesktop ? 20 : 16,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFEBD5AB),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 13, color: Color(0xFF8BAE66)),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                listing.location,
                                style: const TextStyle(
                                    fontSize: 13, color: Color(0xFF8BAE66)),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'by ${listing.owner}',
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFFEBD5AB).withOpacity(0.45),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${listing.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF8BAE66),
                              ),
                            ),
                            const Text(
                              ' / credit',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF628141)),
                            ),
                          ],
                        ),
                        Text(
                          '${listing.creditsAvailable} credits available',
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFFEBD5AB).withOpacity(0.45),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Divider(color: Color(0xFF628141), height: 1),
              const SizedBox(height: 14),

              // Tags
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: listing.tags
                    .map((tag) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF628141).withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color:
                        const Color(0xFF8BAE66).withOpacity(0.3)),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF8BAE66),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ))
                    .toList(),
              ),

              const SizedBox(height: 12),

              // Stats row
              Row(
                children: [
                  const Icon(Icons.air, size: 14, color: Color(0xFF628141)),
                  const SizedBox(width: 4),
                  Text(listing.absorptionRate,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF8BAE66))),
                  const SizedBox(width: 12),
                  const Icon(Icons.verified,
                      size: 14, color: Color(0xFF628141)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Verified by ${listing.verifiedBy}',
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF8BAE66)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // CTA
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () => context.go('/project/${listing.id}'),
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('View Details'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEBD5AB),
                    foregroundColor: const Color(0xFF1B211A),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.w700),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}