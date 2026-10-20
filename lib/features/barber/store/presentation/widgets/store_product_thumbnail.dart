import 'package:flutter/material.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/widgets/network_image_with_app_icon_fallback.dart';
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
    return NetworkImageWithAppIconFallback(
      endPoint: EndPoints.barberStoreMerchantProductImage(merchantId, product.id),
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(radius ?? 10),
    );
  }
}
