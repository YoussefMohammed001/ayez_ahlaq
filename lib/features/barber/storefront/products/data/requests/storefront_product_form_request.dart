import 'package:dio/dio.dart';

class StorefrontProductFormRequest {
  final String name;
  final int price;
  final int stock;
  final int minOrderQty;
  final String? brand;
  final int? categoryId;
  final String? description;
  final List<String> imagePaths;

  const StorefrontProductFormRequest({
    required this.name,
    required this.price,
    required this.stock,
    required this.minOrderQty,
    this.brand,
    this.categoryId,
    this.description,
    this.imagePaths = const [],
  });

  Map<String, dynamic> toFormMap() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
      'minOrderQty': minOrderQty,
      if (brand != null && brand!.isNotEmpty) 'brand': brand,
      if (categoryId != null) 'categoryId': categoryId,
      if (description != null && description!.isNotEmpty)
        'description': description,
      if (imagePaths.isNotEmpty)
        'images': imagePaths
            .map((path) => MultipartFile.fromFileSync(path))
            .toList(),
    };
  }
}
