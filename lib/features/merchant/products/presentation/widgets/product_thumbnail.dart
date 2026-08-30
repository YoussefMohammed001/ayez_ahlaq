import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/widgets/authorized_network_image.dart';
import '../../domain/entities/merchant_product.dart';
import '../../../../../core/extensions/ext_theme.dart';

class ProductThumbnail extends StatelessWidget {
  final MerchantProduct product;
  final double size;
  final double? radius;

  const ProductThumbnail({
    super.key,
    required this.product,
    required this.size,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final corner = BorderRadius.circular(radius ?? 12.r);

    if (!product.imageSource.hasImage) {
      return _buildPlaceholder(context, corner);
    }

    return ClipRRect(
      borderRadius: corner,
      child: AuthorizedNetworkImage(
        endPoint: EndPoints.merchantProductImage(product.id),
        width: size,
        height: size,
        placeholderBuilder: (context) => _buildPlaceholder(context, corner),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context, BorderRadius corner) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colorScheme.primary,
            context.colorScheme.primaryContainer,
          ],
        ),
        borderRadius: corner,
      ),
      child: Icon(
        Icons.inventory_2_outlined,
        size: size * 0.4,
        color: context.semantic.accentSoft,
      ),
    );
  }
}
