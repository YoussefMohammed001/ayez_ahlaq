import 'package:flutter/material.dart';
import 'authorized_network_image.dart';
import '../extensions/ext_theme.dart';

class NetworkImageWithAppIconFallback extends StatelessWidget {
  final String endPoint;
  final bool hasImage;
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const NetworkImageWithAppIconFallback({
    super.key,
    required this.endPoint,
    this.hasImage = true,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final corner = borderRadius ?? BorderRadius.circular(10);

    if (!hasImage) {
      return _buildFallback(context, corner);
    }

    return ClipRRect(
      borderRadius: corner,
      child: AuthorizedNetworkImage(
        endPoint: endPoint,
        width: width,
        height: height,
        placeholderBuilder: (context) => _buildFallback(context, corner),
      ),
    );
  }

  Widget _buildFallback(BuildContext context, BorderRadius corner) {
    final scheme = context.colorScheme;
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: corner),
      child: Icon(Icons.inventory_2_outlined, size: 32, color: scheme.onSurfaceVariant),
    );
  }
}
