// Define the Payment class
class Payment {
  String id;
  String name;
  String cardno;
  String month;
  String year;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;

  Payment({
    this.id = '',
    this.name = '',
    this.cardno = '',
    this.month = '',
    this.year = '',
    this.userId = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : this.createdAt = createdAt ?? DateTime.now(),
        this.updatedAt = updatedAt ?? DateTime.now();

  // Factory method to create a Payment instance from a JSON object
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      cardno: json['cardno'] ?? '',
      month: json['month'] ?? '',
      year: json['year'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // Method to convert a Payment instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cardno': cardno,
      'month': month,
      'year': year,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}


