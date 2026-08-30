class RegisterRequest {
  final String businessName;
  final String ownerName;
  final String phoneNumber;
  final String password;
  final String? email;

  const RegisterRequest({
    required this.businessName,
    required this.ownerName,
    required this.phoneNumber,
    required this.password,
    this.email,
  });

  Map<String, dynamic> toJson() => {
    'businessName': businessName,
    'ownerName': ownerName,
    'phoneNumber': phoneNumber,
    'password': password,
    'userName': null,
    'email': email,
  };
}
