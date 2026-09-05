import '../../domain/entities/store_delivery.dart';

class StoreDeliveryModel extends StoreDelivery {
  const StoreDeliveryModel({required super.offered, required super.fee, super.freeOver});

  factory StoreDeliveryModel.fromJson(Map<String, dynamic> json) {
    return StoreDeliveryModel(
      offered: json['offered'] as bool? ?? false,
      fee: (json['fee'] as num?)?.toInt() ?? 0,
      freeOver: (json['freeOver'] as num?)?.toInt(),
    );
  }
}
