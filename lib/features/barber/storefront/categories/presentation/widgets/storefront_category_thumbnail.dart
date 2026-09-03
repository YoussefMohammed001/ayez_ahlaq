import 'package:flutter/material.dart';
import '../../../../../../core/extensions/ext_theme.dart';

class StorefrontCategoryThumbnail extends StatelessWidget {
  final double size;
  final double? radius;

  const StorefrontCategoryThumbnail({
    super.key,
    required this.size,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(radius ?? 12),
      ),
      child: Icon(
        Icons.category_outlined,
        size: size * 0.45,
        color: context.semantic.accentSoft,
      ),
    );
  }
}
