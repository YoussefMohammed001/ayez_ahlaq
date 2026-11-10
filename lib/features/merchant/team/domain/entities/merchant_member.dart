import 'package:equatable/equatable.dart';
import 'merchant_member_permissions.dart';

class MerchantMember extends Equatable {
  final int id;
  final int merchantId;
  final String name;
  final String phoneNumber;
  final bool active;
  final bool mustChangePassword;
  final double? salary;
  final MerchantMemberPermissions permissions;
  final DateTime? createdAt;

  const MerchantMember({
    required this.id,
    required this.merchantId,
    required this.name,
    required this.phoneNumber,
    required this.active,
    required this.mustChangePassword,
    required this.permissions,
    this.salary,
    this.createdAt,
  });

  bool get canManageProducts => permissions.canManageProducts;

  bool get canSell => permissions.canSell;

  @override
  List<Object?> get props => [
    id,
    merchantId,
    name,
    phoneNumber,
    active,
    mustChangePassword,
    salary,
    permissions,
    createdAt,
  ];
}
