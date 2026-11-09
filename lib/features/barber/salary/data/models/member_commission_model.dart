import '../../domain/entities/member_commission.dart';

class MemberCommissionModel extends MemberCommission {
  const MemberCommissionModel({required super.enabled, required super.percent});

  factory MemberCommissionModel.fromJson(Map<String, dynamic> json) {
    return MemberCommissionModel(
      enabled: json['enabled'] as bool? ?? false,
      percent: (json['percent'] as num?)?.toDouble(),
    );
  }
}
