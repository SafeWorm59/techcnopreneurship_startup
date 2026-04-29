class MarketplaceListing {
  final int id;
  final String title;
  final String location;
  final String owner;
  final double price;
  final String currency;
  final double creditsAvailable; // NEW: Changed from int to double
  final String absorptionRate;
  final String verifiedBy;
  final String image;
  final List<String> tags;

  const MarketplaceListing({
    required this.id,
    required this.title,
    required this.location,
    required this.owner,
    required this.price,
    required this.currency,
    required this.creditsAvailable,
    required this.absorptionRate,
    required this.verifiedBy,
    required this.image,
    required this.tags,
  });
}

class MockData {
  MockData._(); // prevent instantiation

  static const List<MarketplaceListing> listings = [
    MarketplaceListing(
      id: 1,
      title: 'Mt. Kitanglad Buffer Zone Project',
      location: 'Impasugong, Bukidnon',
      owner: 'Datu Salise Family',
      price: 15.50,
      currency: 'USD',
      creditsAvailable: 1200.50, // Updated
      absorptionRate: '1.2 tons CO₂/day',
      verifiedBy: 'DENR & EchoTrace IoT',
      image: 'https://images.unsplash.com/photo-1564496027516-78e6fc218e97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcm9uZSUyMHNob3QlMjBmb3Jlc3QlMjBncmVlbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080',
      tags: ['Pine Forest', 'Indigenous Owned'],
    ),
    MarketplaceListing(
      id: 2,
      title: 'Kalatungan Range Reforestation',
      location: 'Pangantucan, Bukidnon',
      owner: 'Talakag Farmers Coop',
      price: 18.00,
      currency: 'USD',
      creditsAvailable: 850.75, // Updated
      absorptionRate: '0.9 tons CO₂/day',
      verifiedBy: 'EchoTrace IoT',
      image: 'https://images.unsplash.com/photo-1684853693031-ab9e3f8c9d5e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhZXJpYWwlMjBmb3Jlc3QlMjBidWtpZG5vbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080',
      tags: ['Mahogany', 'Community Coop'],
    ),
    MarketplaceListing(
      id: 3,
      title: 'Manolo Fortich Canopy Cover',
      location: 'Manolo Fortich, Bukidnon',
      owner: 'Araneta Estate',
      price: 14.20,
      currency: 'USD',
      creditsAvailable: 3400.00, // Updated
      absorptionRate: '3.5 tons CO₂/day',
      verifiedBy: 'EchoTrace IoT & Local LGU',
      image: 'https://images.unsplash.com/photo-1564496027516-78e6fc218e97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcm9uZSUyMHNob3QlMjBmb3Jlc3QlMjBncmVlbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080',
      tags: ['Mixed Dipterocarp', 'Private'],
    ),
    MarketplaceListing(
      id: 4,
      title: 'Lantapan Watershed Reserve',
      location: 'Lantapan, Bukidnon',
      owner: 'LGU Lantapan',
      price: 16.80,
      currency: 'USD',
      creditsAvailable: 2100.25, // Updated
      absorptionRate: '2.1 tons CO₂/day',
      verifiedBy: 'EchoTrace IoT & DENR',
      image: 'https://images.unsplash.com/photo-1448375240586-882707db888b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080',
      tags: ['Watershed', 'Government'],
    ),
    MarketplaceListing(
      id: 5,
      title: 'Talakag Agroforestry Belt',
      location: 'Talakag, Bukidnon',
      owner: 'Higaonon Tribe Council',
      price: 13.50,
      currency: 'USD',
      creditsAvailable: 670.00, // Updated
      absorptionRate: '0.7 tons CO₂/day',
      verifiedBy: 'EchoTrace IoT',
      image: 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080',
      tags: ['Agroforestry', 'Indigenous Owned'],
    ),
  ];

  /// Find a single listing by id - returns null if not found
  static MarketplaceListing? getListingById(int id) {
    try {
      return listings.firstWhere((l) => l.id == id);
    } catch (_) {
      return null;
    }
  }
}