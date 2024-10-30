import 'nutritionmodel.dart';

class ProductDetails {
  String name;
  List<String> image;
  double price;
  String details;
  String unitvalue;
  String unitname;
  String id;
  bool status;
  String? cartid;
  String averageRating;
  String?nutritionweight;
  final List<Nutrition>? nutritionlist;

  ProductDetails({
    required this.name,
    required this.image,
    required this.price,
    required this.details,
    required this.unitname,
    required this.unitvalue,
    required this.id,
    required this.status,
    this.cartid,
    required this.averageRating,
    this.nutritionweight,
    this.nutritionlist

  });

  // Factory method to create a ProductDetails from JSON
  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
        name: json['name'],
        image: List<String>.from(json['image'] ?? []), // Convert image to List<String>
        price: (json['price'] as num).toDouble(),  // Ensure price is a double
        details: json['details'],
        unitname: json['unitname'],
        unitvalue: json['unitvalue'],
        id: json['id'],
        status: json['status'],
        cartid: json['cart_id'] ?? "",  // Handle nullable cartid with fallback
        averageRating: json['averageRating'],
        nutritionweight: json['nutritionweight']?? "",
        nutritionlist: (json['nutritions'] as List<dynamic>).cast<Map<String,dynamic>>().map((e)=>Nutrition.fromJson(e)).toList(),

    );
  }

  // Method to convert ProductDetails to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'details': details,
      'unitvalue': unitvalue,
      'unitname': unitname,
      'id': id,
      'status': status,
      'cartid': cartid,
      'averageRating': averageRating,
      'nutritionweight':nutritionweight
    };
  }
}

