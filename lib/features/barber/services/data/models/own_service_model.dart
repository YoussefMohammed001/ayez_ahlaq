import '../../domain/entities/own_service.dart';

class OwnServiceModel extends OwnService {
  const OwnServiceModel({
    required super.id,
    required super.name,
    required super.description,
    required super.active,
  });

  factory OwnServiceModel.fromJson(Map<String, dynamic> json) {
    return OwnServiceModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      active: json['active'] as bool? ?? true,
    );
  }

  static Map<String, dynamic> toCreateJson(String name, String description) {
    return {'name': name, 'description': description};
  }
}
