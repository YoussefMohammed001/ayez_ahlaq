class CustomerRegisterRequest {
  final String userName;
  final String phoneNumber;
  final String password;
  final String? email;

  const CustomerRegisterRequest({
    required this.userName,
    required this.phoneNumber,
    required this.password,
    this.email,
  });

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'phoneNumber': phoneNumber,
    'password': password,
    'email': email,
  };
}
