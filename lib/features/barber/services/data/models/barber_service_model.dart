import '../../domain/entities/barber_service.dart';

class BarberServiceModel extends BarberService {
  const BarberServiceModel({
    required super.id,
    required super.catalogId,
    required super.name,
    required super.description,
    required super.price,
    required super.durationMinutes,
    required super.popular,
    required super.active,
  });

  factory BarberServiceModel.fromJson(Map<String, dynamic> json) {
    return BarberServiceModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      catalogId: (json['serviceTypeId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
      popular: json['popular'] as bool? ?? false,
      active: json['active'] as bool? ?? true,
    );
  }

  static Map<String, dynamic> toCreateJson(BarberService service) {
    return {
      'serviceTypeId': service.catalogId,
      'price': service.price,
      'durationMinutes': service.durationMinutes,
      'popular': service.popular,
    };
  }

  static Map<String, dynamic> toUpdateJson(BarberService service) {
    return {
      'price': service.price,
      'durationMinutes': service.durationMinutes,
      'popular': service.popular,
      'active': service.active,
    };
  }
}
