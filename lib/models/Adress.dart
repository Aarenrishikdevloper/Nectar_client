
class Address {
  String? state;
  String? city;

  Address({required this.state, required this.city});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      state: json['state'] ?? '',
      city: json['city'] ?? '',
    );
  }

}