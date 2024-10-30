
// Model class for a single favorite item
class Favorite {
  final String id;
  final String name;
  final String details;
  final String unitName;
  final String unitValue;
  final List<String>? image; // renamed from imageUrl
  final double price;
  final String ProductId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Favorite({
    required this.id,
    required this.name,
    required this.details,
    required this.unitName,
    required this.unitValue,
    required this.image,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.ProductId,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      Favorite(
        id: json['id'] as String,
        name: json['name'] as String,
        details: json['details'] as String,
        unitName: json['unit_name'] as String,
        unitValue: json['unit_value'] as String,
        image: List<String>.from(json['Image'] ?? []),
        price: json['price'].toDouble(),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        ProductId: json['productId']
      );
}