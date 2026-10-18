import '../../domain/entities/store_category.dart';

class StoreCategoryModel extends StoreCategory {
  const StoreCategoryModel({required super.id, required super.name});

  factory StoreCategoryModel.fromJson(Map<String, dynamic> json) {
    return StoreCategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
