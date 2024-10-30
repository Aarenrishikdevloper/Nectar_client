

class OrderProduct {
  String? id;
  String? name;
  int ?qty;
  String? unitName;
  String? unitValue;
  String ?image;
  double? price;



  OrderProduct({
    this.id,
    this.name,
    this.qty,
    this.unitName,
    this.unitValue,
    this.image,
    this.price,

  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      name: json['name'],
      qty:json['qty'],
      unitName: json['unit_name'],
      unitValue: json['unit_value'],
      image:  json['Image'],
      price: json['price'].toDouble(),

    );
  }
}
