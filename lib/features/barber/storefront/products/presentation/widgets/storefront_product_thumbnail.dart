import 'package:flutter/material.dart';
import '../../../../../../core/extensions/ext_theme.dart';

class StorefrontProductThumbnail extends StatelessWidget {
  final double size;
  final double? radius;

  const StorefrontProductThumbnail({super.key, required this.size, this.radius});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius ?? 12),
      ),
      child: Icon(
        Icons.inventory_2_outlined,
        size: size * 0.4,
        color: scheme.onSurfaceVariant,
      ),
    );
  }
}
