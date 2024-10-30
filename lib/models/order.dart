import 'Product.dart';

class Orders {
  String id;
  String userId;
  int discount;
  double totalPrice;
  String deliveryType;
  double userPayPrice;
  double deliveryPrice;
  String paymentType;
  String paymentStatus;
  String orderStatus;
  String? addressId;
 List<String>Items;
 String Image;

  DateTime createdAt;
  DateTime updatedAt;

  Orders({
    required this.id,
    required this.userId,
    required this.discount,
    required this.totalPrice,
    required this.deliveryType,
    required this.userPayPrice,
    required this.deliveryPrice,
    required this.paymentType,
    required this.paymentStatus,
    required this.orderStatus,
    this.addressId,
   required this.Image,

    required this.Items,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: json['id'],
      userId: json['userId'],
      discount:json['discountPrice'],
      totalPrice: json['total_price'].toDouble(),
      deliveryType: json['delivery_type'],
      userPayPrice: json['user_pay_price'].toDouble(),
      deliveryPrice: json['delivery_price'].toDouble(),
      paymentType: json['payment_type'],
      paymentStatus: json['payment_status'],
      orderStatus: json['order_status'],
      addressId: json['address_id'],
      Image :json['firstproductImages'],

      Items:  List<String>.from(json['productnames']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }


}

