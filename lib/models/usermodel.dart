import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  String? mobileNumber;
  String? countryCode;
  UserModel(
      {required this.name,
      required this.email,
      this.mobileNumber,
      this.countryCode});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        mobileNumber: json['mobileNumber'],
        countryCode: json['countryCode']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'countryCode': countryCode
    };
  }
}
