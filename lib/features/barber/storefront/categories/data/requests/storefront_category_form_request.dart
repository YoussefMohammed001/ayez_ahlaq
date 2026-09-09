import 'package:dio/dio.dart';

class StorefrontCategoryFormRequest {
  final String name;
  final bool active;
  final int? sortOrder;
  final String? imagePath;
  final bool removeImage;

  const StorefrontCategoryFormRequest({
    required this.name,
    this.active = true,
    this.sortOrder,
    this.imagePath,
    this.removeImage = false,
  });

  Map<String, dynamic> toFormMap() {
    return {
      'name': name,
      'active': active,
      if (sortOrder != null) 'sortOrder': sortOrder,
      'removeImage': removeImage,
      if (imagePath != null) 'image': MultipartFile.fromFileSync(imagePath!),
    };
  }
}
