import '../../domain/entities/service_catalog_item.dart';

class ServiceCatalogItemModel extends ServiceCatalogItem {
  const ServiceCatalogItemModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory ServiceCatalogItemModel.fromJson(Map<String, dynamic> json) {
    return ServiceCatalogItemModel(
      id: (json['serviceTypeId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
}
