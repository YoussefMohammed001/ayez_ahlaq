import 'package:flutter/material.dart';
import '../../../../../../core/network/constants/endpoints.dart';
import '../../../../../../core/widgets/authorized_network_image.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../domain/entities/storefront_category.dart';

class StorefrontCategoryThumbnail extends StatelessWidget {
  final StorefrontCategory? category;
  final double size;
  final double? radius;

  const StorefrontCategoryThumbnail({
    super.key,
    required this.category,
    required this.size,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final corner = BorderRadius.circular(radius ?? 12);
    final category = this.category;

    if (category == null || !category.hasImage) {
      return _buildPlaceholder(context, corner);
    }

    return ClipRRect(
      borderRadius: corner,
      child: AuthorizedNetworkImage(
        endPoint: EndPoints.barberStorefrontCategoryImage(category.id),
        width: size,
        height: size,
        placeholderBuilder: (context) => _buildPlaceholder(context, corner),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context, BorderRadius corner) {
    final scheme = context.colorScheme;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: corner),
      child: Icon(Icons.category_outlined, size: size * 0.45, color: context.semantic.accentSoft),
    );
  }
}
