class Product {
  String? id;
  String? name;

  String? unitName;
  String? unitValue;
  List<String>? image;
  double? price;
  DateTime? createdAt;
  DateTime? updatedAt;


  Product({
     this.id,
     this.name,

     this.unitName,
     this.unitValue,
     this.image,
     this.price,
     this.createdAt,
     this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],

      unitName: json['unit_name'],
      unitValue: json['unit_value'],
      image:  List<String>.from(json['Image']),
      price: json['price'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
