import 'package:dio/dio.dart';

class ProductFormRequest {
  final String name;
  final int price;
  final String? brand;
  final int? categoryId;
  final String? description;
  final int? minOrderQty;
  final int? stock;
  final List<String> imagePaths;
  final List<int>? keepImageIds;

  const ProductFormRequest({
    required this.name,
    required this.price,
    this.brand,
    this.categoryId,
    this.description,
    this.minOrderQty,
    this.stock,
    this.imagePaths = const [],
    this.keepImageIds,
  });

  Map<String, dynamic> toFormMap() {
    return {
      'name': name,
      'price': price,
      if (brand != null && brand!.isNotEmpty) 'brand': brand,
      if (categoryId != null) 'categoryId': categoryId,
      if (description != null && description!.isNotEmpty)
        'description': description,
      if (minOrderQty != null) 'minOrderQty': minOrderQty,
      if (stock != null) 'stock': stock,
      if (keepImageIds != null && keepImageIds!.isNotEmpty)
        'keepImageIds': keepImageIds,
      if (keepImageIds != null && keepImageIds!.isEmpty) 'keepImageIds': '',
      if (imagePaths.isNotEmpty)
        'images': imagePaths
            .map((path) => MultipartFile.fromFileSync(path))
            .toList(),
    };
  }
}
