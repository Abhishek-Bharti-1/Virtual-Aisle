class BuildingAddress {
  final String name;
  final String address;
  final String imageUrl;

  BuildingAddress({
    required this.name,
    required this.address,
    required this.imageUrl,
  });

  @override
  String toString() {
    return '$name, $address';
  }
}

// Create a list of BuildingAddress objects
final List<BuildingAddress> buildingAddresses1 = [
  BuildingAddress(
    name: 'Greenleaf Towers',
    address: '12 Indiranagar Main Rd, Indiranagar, Bangalore 560038',
    imageUrl: 'https://example.com/greenleaf_towers.jpg',
  ),
  BuildingAddress(
    name: 'Prestige Plaza',
    address: '45 Residency Rd, Shanthala Nagar, Ashok Nagar, Bangalore 560025',
    imageUrl: 'https://example.com/prestige_plaza.jpg',
  ),
  BuildingAddress(
    name: 'Sunflower Heights',
    address: '789 Koramangala 4th Block, Koramangala, Bangalore 560034',
    imageUrl: 'https://example.com/sunflower_heights.jpg',
  ),
  BuildingAddress(
    name: 'Metro Point',
    address: '101 MG Road, Shanthala Nagar, Ashok Nagar, Bangalore 560001',
    imageUrl: 'https://example.com/metro_point.jpg',
  ),
  BuildingAddress(
    name: 'Brigade Arcade',
    address: '202 Brigade Rd, Shanthala Nagar, Ashok Nagar, Bangalore 560025',
    imageUrl: 'https://example.com/brigade_arcade.jpg',
  ),
  BuildingAddress(
    name: 'Lavelle Square',
    address: '34 Lavelle Rd, Ashok Nagar, Bangalore 560001',
    imageUrl: 'https://example.com/lavelle_square.jpg',
  ),
  BuildingAddress(
    name: 'Cunningham Court',
    address: '567 Cunningham Rd, Vasanth Nagar, Bangalore 560052',
    imageUrl: 'https://example.com/cunningham_court.jpg',
  ),
  BuildingAddress(
    name: 'Church Street Plaza',
    address: '89 Church St, Shanthala Nagar, Ashok Nagar, Bangalore 560001',
    imageUrl: 'https://example.com/church_street_plaza.jpg',
  ),
  BuildingAddress(
    name: 'Vittal Mallya Center',
    address: '23 Vittal Mallya Rd, KG Halli, D\' Souza Layout, Bangalore 560001',
    imageUrl: 'https://example.com/vittal_mallya_center.jpg',
  ),
  BuildingAddress(
    name: 'Indiranagar Hub',
    address: '456 100 Feet Rd, HAL 2nd Stage, Indiranagar, Bangalore 560038',
    imageUrl: 'https://example.com/indiranagar_hub.jpg',
  ),
];