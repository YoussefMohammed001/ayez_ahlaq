import '../../domain/entities/storefront_delivery_settings.dart';

class StorefrontDeliverySettingsModel extends StorefrontDeliverySettings {
  const StorefrontDeliverySettingsModel({
    required super.offered,
    required super.fee,
    super.freeOver,
  });

  factory StorefrontDeliverySettingsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return StorefrontDeliverySettingsModel(
      offered: json['offered'] as bool? ?? false,
      fee: (json['fee'] as num?)?.toInt() ?? 0,
      freeOver: (json['freeOver'] as num?)?.toInt(),
    );
  }

  static Map<String, dynamic> toJson(StorefrontDeliverySettings settings) {
    return {
      'offered': settings.offered,
      'fee': settings.offered ? settings.fee : 0,
      'freeOver': settings.offered && settings.hasFreeThreshold
          ? settings.freeOver
          : null,
    };
  }
}
