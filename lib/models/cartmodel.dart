

class CartModel {
  final String name;
  final String image;
  final String unitName;
  final String unitValue;
  final int qty;
  final double price;
  final String productid;
  final double originalprice;



  CartModel({
    required this.name,
    required this.image,
    required this.unitName,
    required this.unitValue,
    required this.qty,
    required this.productid,
    required this.originalprice,
    required double price,



  }) : price = double.parse(price.toStringAsFixed(2));

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      name: json['name'],
      image: json['image'],
      unitName: json['unit_name'],
      unitValue: json['unit_value'],
      qty: json['qty'],
      productid: json['prod_id'],
      price: json['price']?.toDouble() ?? 0.0,
        originalprice: json['original_price']?.toDouble() ?? 0.0,


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'unit_name': unitName,
      'unit_value': unitValue,
      'qty': qty,
      'price': price,
      'productid':productid,
       'originalprice':originalprice,

    };
  }
}