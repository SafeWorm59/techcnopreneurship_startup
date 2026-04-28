import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/navbar.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

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
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: const EchoTraceNavBar(currentRoute: '/marketplace'),
      drawer: isDesktop ? null : EchoTraceDrawer(currentRoute: '/marketplace'), // FIXED: Removed 'const'
      body: Column(
        children: [
          // Animated Hero Header
          Container(
            width: double.infinity,
            color: AppTheme.surfaceLight,
            padding: EdgeInsets.fromLTRB(24, isDesktop ? 64 : 40, 24, 48),
            child: Column(
              children: [
                Text(
                  'Verified Carbon Credit\nMarketplace',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ).animate().fade(duration: 600.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 16),
                const Text(
                  'Directly purchase scientifically-backed carbon offsets\nfrom Bukidnon landowners. Verified by DENR.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppTheme.primary, height: 1.6),
                ).animate().fade(delay: 200.ms),
                const SizedBox(height: 32),

                // Search Bar
                MaxWidthContainer(
                  maxWidth: 600,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Search by location, owner, or project name...',
                      prefixIcon: const Icon(Icons.search, color: AppTheme.primary),
                    ),
                  ).animate().fade(delay: 300.ms).scaleXY(begin: 0.9, end: 1.0),
                ),
              ],
            ),
          ),

          // Listings Grid
          Expanded(
            child: Container(
              color: AppTheme.background,
              child: _filteredListings.isEmpty
                  ? Center(child: Text('No projects found.', style: Theme.of(context).textTheme.titleLarge))
                  : MaxWidthContainer(
                child: GridView.builder(
                  padding: EdgeInsets.all(isDesktop ? 32 : 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isDesktop ? 2 : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    mainAxisExtent: 200,
                  ),
                  itemCount: _filteredListings.length,
                  itemBuilder: (context, index) {
                    return _ListingCard(listing: _filteredListings[index])
                        .animate(delay: (100 * index).ms)
                        .fade()
                        .slideY(begin: 0.1, end: 0);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListingCard extends StatelessWidget {
  final MarketplaceListing listing;

  const _ListingCard({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.go('/project/${listing.id}'),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  listing.image,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 140,
                    height: 140,
                    color: AppTheme.primaryDark.withOpacity(0.2),
                    child: const Icon(Icons.forest, color: AppTheme.primary, size: 40),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listing.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: AppTheme.primary),
                        const SizedBox(width: 4),
                        Text(listing.location, style: const TextStyle(fontSize: 13, color: AppTheme.primary)),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${listing.price.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppTheme.primary),
                            ),
                            Text('${listing.creditsAvailable} credits left', style: TextStyle(fontSize: 12, color: AppTheme.textPrimary.withOpacity(0.6))),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => context.go('/project/${listing.id}'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: const Text('View'),
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
    );
  }
}