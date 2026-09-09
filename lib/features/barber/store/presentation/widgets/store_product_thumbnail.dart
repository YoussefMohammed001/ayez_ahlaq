import 'package:flutter/material.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/widgets/authorized_network_image.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../domain/entities/store_product.dart';

class StoreProductThumbnail extends StatelessWidget {
  final int merchantId;
  final StoreProduct product;
  final double size;
  final double? radius;

  const StoreProductThumbnail({
    super.key,
    required this.merchantId,
    required this.product,
    required this.size,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final corner = BorderRadius.circular(radius ?? 10);

    if (!product.hasImage) {
      return _buildPlaceholder(context, corner);
    }

    return ClipRRect(
      borderRadius: corner,
      child: AuthorizedNetworkImage(
        endPoint: EndPoints.barberStoreMerchantProductImage(merchantId, product.id),
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
      decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: corner),
      child: Icon(Icons.inventory_2_outlined, size: size * 0.5, color: scheme.onSurfaceVariant),
    );
  }
}
