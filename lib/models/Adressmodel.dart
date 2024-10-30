import 'dart:convert';

class AddressModel {
  String id;
  String name;
  String addressLine;
  String mobileNumber;
  String type;
  String? city;
  String? state;
  String? postalCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  AddressModel({
    this.id = '',
    this.name = '',
    this.addressLine = '',
    this.mobileNumber = '',
    this.type = '',
    this.city = '',
    this.state = '',
    this.postalCode,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create an Address instance from JSON
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      addressLine: json['adressline'] as String? ?? '',
      mobileNumber: json['mobilenumber'] as String? ?? '',
      type: json['type'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      postalCode: json['postalCode'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }

  // Method to convert Address instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'adressline': addressLine,
      'mobilenumber': mobileNumber,
      'type': type,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
