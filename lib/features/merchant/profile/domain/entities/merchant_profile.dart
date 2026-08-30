import 'package:equatable/equatable.dart';

class MerchantProfile extends Equatable {
  final int id;
  final String businessName;
  final String ownerName;
  final String phoneNumber;
  final String? phoneE164;
  final String? email;
  final String? userName;
  final bool active;
  final bool mustChangePassword;
  final int categoryLimit;
  final DateTime? createdAt;

  const MerchantProfile({
    required this.id,
    required this.businessName,
    required this.ownerName,
    required this.phoneNumber,
    required this.active,
    required this.mustChangePassword,
    required this.categoryLimit,
    this.phoneE164,
    this.email,
    this.userName,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, businessName, ownerName, phoneNumber, active];
}
