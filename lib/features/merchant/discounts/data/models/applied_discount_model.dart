import '../../domain/entities/applied_discount.dart';

class AppliedDiscountModel extends AppliedDiscount {
  const AppliedDiscountModel({
    required super.id,
    required super.name,
    required super.scope,
    required super.benefit,
  });

  factory AppliedDiscountModel.fromJson(Map<String, dynamic> json) {
    return AppliedDiscountModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      scope: json['scope'] as String? ?? '',
      benefit: json['benefit'] as String? ?? '',
    );
  }
}
