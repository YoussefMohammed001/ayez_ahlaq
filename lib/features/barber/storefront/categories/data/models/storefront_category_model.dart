import '../../domain/entities/storefront_category.dart';

class StorefrontCategoryModel extends StorefrontCategory {
  const StorefrontCategoryModel({
    required super.id,
    required super.name,
    required super.global,
    required super.active,
    required super.hasImage,
  });

  factory StorefrontCategoryModel.fromJson(Map<String, dynamic> json) {
    return StorefrontCategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      global: json['global'] as bool? ?? false,
      active: json['active'] as bool? ?? true,
      hasImage: json['hasImage'] as bool? ?? false,
    );
  }
}
