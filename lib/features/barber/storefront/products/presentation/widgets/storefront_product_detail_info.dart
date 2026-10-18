import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/badge_tone.dart';
import '../../../../../../core/widgets/info_row.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../core/widgets/status_badge.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_product.dart';
import 'active_discount_label.dart';

class StorefrontProductDetailInfo extends StatelessWidget {
  final StorefrontProduct product;
  final VoidCallback? onEditStock;

  const StorefrontProductDetailInfo({
    super.key,
    required this.product,
    this.onEditStock,
  });

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
        if (product.hasDiscount)
          _buildDiscountedPriceRow(context)
        else
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
        GestureDetector(
          onTap: onEditStock,
          child: InfoRow(
            icon: Icons.inventory_2_outlined,
            label: S().stockQuantity,
            value: '${product.stock}',
          ),
        ),
        InfoRow(
          icon: Icons.shopping_basket_outlined,
          label: S().minOrderQty,
          value: '${product.minOrderQty}',
        ),
        if (product.activeDiscount != null)
          InfoRow(
            icon: Icons.local_offer_outlined,
            label: product.activeDiscount!.name,
            value: product.activeDiscount!.valueLabel,
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

  Widget _buildDiscountedPriceRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.colorScheme.outline)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.sell_outlined,
            size: 18.r,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              S().unitPrice,
              style: TextStyle(
                fontSize: 12.5.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            children: [
              Text(
                S().currencyEgp(product.price),
                style: TextStyle(
                  fontSize: 11.sp,
                  color: context.colorScheme.onSurfaceVariant,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 6.w),
              Icon(
                Icons.arrow_back,
                size: 13.r,
                color: context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 6.w),
              Text(
                S().currencyEgp(product.effectivePrice),
                style: TextStyle(
                  fontSize: 12.5.sp,
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
