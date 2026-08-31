import '../../domain/entities/delivery_settings.dart';

class DeliverySettingsModel extends DeliverySettings {
  const DeliverySettingsModel({
    required super.offered,
    required super.fee,
    super.freeOver,
  });

  factory DeliverySettingsModel.fromJson(Map<String, dynamic> json) {
    return DeliverySettingsModel(
      offered: json['offered'] as bool? ?? false,
      fee: (json['fee'] as num?)?.toInt() ?? 0,
      freeOver: (json['freeOver'] as num?)?.toInt(),
    );
  }

  static Map<String, dynamic> toJson(DeliverySettings settings) {
    return {
      'offered': settings.offered,
      'fee': settings.offered ? settings.fee : 0,
      'freeOver': settings.offered && settings.hasFreeThreshold
          ? settings.freeOver
          : null,
    };
  }
}
