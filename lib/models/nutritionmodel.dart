
class Nutrition {
  final String id;
  final String nutrionName;
  final String nutritionValue;
  final String productId;

  Nutrition({
    required this.id,
    required this.nutrionName,
    required this.nutritionValue,
    required this.productId,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      id: json['id'] as String,
      nutrionName: json['nutrionName'] as String,
      nutritionValue: json['nutritionValue'] as String,
      productId: json['productId'] as String,
    );
  }
}