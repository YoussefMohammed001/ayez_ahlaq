import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../domain/entities/merchant_product.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class ProductDetailInfo extends StatelessWidget {
  final MerchantProduct product;

  const ProductDetailInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
            StatusBadge(
              label: product.isOutOfStock ? S().outOfStock : S().inStock,
              tone: product.isOutOfStock ? BadgeTone.danger : BadgeTone.open,
            ),
          ],
        ),
        SizedBox(height: 14.h),
        InfoRow(
          icon: Icons.sell_outlined,
          label: S().unitPrice,
          value: S().currencyEgp(product.effectivePrice),
        ),
        if (product.brand != null && product.brand!.isNotEmpty)
          InfoRow(
            icon: Icons.branding_watermark_outlined,
            label: S().brand,
            value: product.brand!,
          ),
        if (product.categoryName != null)
          InfoRow(
            icon: Icons.category_outlined,
            label: S().category,
            value: product.categoryName!,
          ),
        InfoRow(
          icon: Icons.inventory_2_outlined,
          label: S().stockQuantity,
          value: '${product.totalStock}',
        ),
        InfoRow(
          icon: Icons.shopping_basket_outlined,
          label: S().minOrderQty,
          value: '${product.minOrderQty}',
        ),
        if (product.activeDiscount != null)
          InfoRow(
            icon: Icons.local_offer_outlined,
            label: S().activeDiscount,
            value: product.activeDiscount!.name,
          ),
        if (product.description != null && product.description!.isNotEmpty) ...[
          SectionTitle(title: S().productDescription),
          Text(
            product.description!,
            style: TextStyle(
              fontSize: 12.5.sp,
              height: 1.8,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
