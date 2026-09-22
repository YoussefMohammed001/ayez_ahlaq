import '../../domain/entities/home_service_settings.dart';

class HomeServiceSettingsModel extends HomeServiceSettings {
  const HomeServiceSettingsModel({
    required super.enabled,
    required super.price,
    required super.note,
  });

  factory HomeServiceSettingsModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceSettingsModel(
      enabled: json['enabled'] as bool? ?? false,
      price: json['price'] as num?,
      note: json['note'] as String?,
    );
  }

  static Map<String, dynamic> toJson(HomeServiceSettings settings) {
    return {
      'enabled': settings.enabled,
      'price': settings.price,
      'note': settings.note,
    };
  }
}
