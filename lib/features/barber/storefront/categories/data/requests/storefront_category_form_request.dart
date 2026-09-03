import 'package:dio/dio.dart';

class StorefrontCategoryFormRequest {
  final String name;
  final bool active;
  final String? imagePath;

  const StorefrontCategoryFormRequest({
    required this.name,
    this.active = true,
    this.imagePath,
  });

  Map<String, dynamic> toFormMap() {
    return {
      'name': name,
      'active': active,
      if (imagePath != null) 'image': MultipartFile.fromFileSync(imagePath!),
    };
  }
}
