import 'package:dio/dio.dart';

class CategoryFormRequest {
  final String name;
  final int sortOrder;
  final bool active;
  final String? imagePath;
  final bool removeImage;

  const CategoryFormRequest({
    required this.name,
    this.sortOrder = 0,
    this.active = true,
    this.imagePath,
    this.removeImage = false,
  });

  Map<String, dynamic> toFormMap() {
    return {
      'name': name,
      'sortOrder': sortOrder,
      'active': active,
      if (removeImage) 'removeImage': true,
      if (imagePath != null) 'image': MultipartFile.fromFileSync(imagePath!),
    };
  }
}
