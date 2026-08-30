import '../../domain/entities/merchant_category.dart';

class MerchantCategoryModel extends MerchantCategory {
  const MerchantCategoryModel({
    required super.id,
    required super.name,
    required super.global,
    required super.sortOrder,
    required super.active,
    required super.hasImage,
  });

  factory MerchantCategoryModel.fromJson(Map<String, dynamic> json) {
    return MerchantCategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      global: json['global'] as bool? ?? false,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      active: json['active'] as bool? ?? true,
      hasImage: json['hasImage'] as bool? ?? false,
    );
  }
}
