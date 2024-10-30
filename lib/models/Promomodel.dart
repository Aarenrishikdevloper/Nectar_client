import 'dart:convert';

class Promo {
  String id;
  String promoCode;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  String type;
  double offerPrice;
  double minOrderPrice;
  double maxDiscountAmount;
  String userId;

  Promo({
     this.id='',
     this.promoCode='',
     this.title='',
     this.description='',

     this.type='',
     this.offerPrice=0,
     this.minOrderPrice=0,
     this.maxDiscountAmount=0,
     this.userId="",
    DateTime? startDate,
    DateTime? endDate
  }) : this.startDate = startDate ?? DateTime.now(),
        this.endDate = endDate ?? DateTime.now();

  // Factory constructor to create a Promo object from a JSON map
  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json['id'],
      promoCode: json['PromoCode'],
      title: json['Title'],
      description: json['Description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      type: json['type'],
      offerPrice: json['Offerprice'].toDouble(),
      minOrderPrice: json['min_order_price'].toDouble(),
      maxDiscountAmount: json['Max_Discount_amount'].toDouble(),
      userId: json['userId'],
    );
  }
}