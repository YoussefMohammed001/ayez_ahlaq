import '../../domain/entities/merchant_member.dart';
import '../../domain/entities/merchant_member_permissions.dart';

class MerchantMemberModel extends MerchantMember {
  const MerchantMemberModel({
    required super.id,
    required super.merchantId,
    required super.name,
    required super.phoneNumber,
    required super.active,
    required super.mustChangePassword,
    required super.permissions,
    super.salary,
    super.createdAt,
  });

  factory MerchantMemberModel.fromJson(Map<String, dynamic> json) {
    return MerchantMemberModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      merchantId: (json['merchantId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      active: json['active'] as bool? ?? true,
      mustChangePassword: json['mustChangePassword'] as bool? ?? false,
      salary: (json['salary'] as num?)?.toDouble(),
      permissions: MerchantMemberPermissions(
        canManageProducts: json['canManageProducts'] as bool? ?? false,
        canSell: json['canSell'] as bool? ?? false,
      ),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }
}
