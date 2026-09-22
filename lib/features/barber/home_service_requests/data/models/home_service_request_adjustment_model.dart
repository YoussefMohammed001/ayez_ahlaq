import '../../domain/entities/home_service_request_adjustment.dart';

class HomeServiceRequestAdjustmentModel extends HomeServiceRequestAdjustment {
  const HomeServiceRequestAdjustmentModel({
    super.id,
    required super.label,
    required super.amount,
  });

  factory HomeServiceRequestAdjustmentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return HomeServiceRequestAdjustmentModel(
      id: (json['id'] as num?)?.toInt(),
      label: json['label'] as String? ?? '',
      amount: json['amount'] as num? ?? 0,
    );
  }

  static Map<String, dynamic> toJson(HomeServiceRequestAdjustment adjustment) {
    return {'label': adjustment.label, 'amount': adjustment.amount};
  }
}
