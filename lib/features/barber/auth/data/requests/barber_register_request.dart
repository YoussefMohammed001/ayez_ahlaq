class BarberRegisterRequest {
  final String name;
  final String phoneNumber;
  final String password;
  final String shopName;
  final String area;
  final String address;
  final double? latitude;
  final double? longitude;

  const BarberRegisterRequest({
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.shopName,
    required this.area,
    required this.address,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'phoneNumber': phoneNumber,
    'password': password,
    'shopName': shopName,
    'area': area,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
  };
}
