import 'Orderproducts.dart';

class OrderDetailModel{
  String? paymentType;
  String? orderStatus;
  String? paymentStatus;

  String? address;
  String? city;
  String? state;


  String? deliveryType;
  DateTime? createdAt;
  String? postalcode;
  List<OrderProduct>?product;


  OrderDetailModel({
    this.paymentType,
    this.orderStatus,
    this.paymentStatus,
    this.product,
    this.address,
    this.city,
    this.state,

    this.deliveryType,
    this.createdAt,
    this.postalcode,



  });

  // Factory constructor to create an Order object from JSON
  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      paymentType: json['payment_type'],
      orderStatus: json['order_status'],
      paymentStatus: json['payment_status'],

      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      product: (json['product'] as List<dynamic>?)?.map((item) => OrderProduct.fromJson(item)).toList() ?? [], // Fix this line
      deliveryType: json['deliverytype'],
      createdAt: DateTime.parse(json['createdAt']),
      postalcode: json['postalcode'],


    );
  }

  // Method to convert Order object to JSON

}