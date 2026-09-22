import '../../domain/entities/home_service_adjustment.dart';

class HomeServiceAdjustmentModel extends HomeServiceAdjustment {
  const HomeServiceAdjustmentModel({
    required super.id,
    required super.label,
    required super.amount,
  });

  factory HomeServiceAdjustmentModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceAdjustmentModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      label: json['label'] as String? ?? '',
      amount: json['amount'] as num? ?? 0,
    );
  }
}
