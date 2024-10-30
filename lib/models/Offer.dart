import 'Product.dart';

class Offer {
  final String id;
  final String productId;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  Product? product;

  Offer({
    required this.id,
    required this.productId,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    this.product,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      startDate: DateTime.parse(json['start_date'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['end_date'] ?? DateTime.now().toIso8601String()),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}