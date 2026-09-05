import 'package:equatable/equatable.dart';

class CustomerProfile extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  final String? email;
  final bool active;
  final bool otpVerified;
  final double rating;
  final int ratingCount;
  final DateTime createdAt;

  const CustomerProfile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.email,
    required this.active,
    required this.otpVerified,
    required this.rating,
    required this.ratingCount,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    phoneNumber,
    email,
    active,
    otpVerified,
    rating,
    ratingCount,
    createdAt,
  ];
}
