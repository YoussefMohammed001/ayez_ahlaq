import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_card.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_product.dart';
import 'storefront_product_thumbnail.dart';

class StorefrontProductRow extends StatelessWidget {
  final StorefrontProduct product;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const StorefrontProductRow({
    super.key,
    required this.product,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          StorefrontProductThumbnail(size: 54.r),
          SizedBox(width: 12.w),
          Expanded(child: _buildInfo(context)),
          GestureDetector(
            onTap: onRemove,
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: Icon(
                Icons.delete_outline,
                size: 20.r,
                color: context.semantic.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13.sp,
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          S().productMetaLine(product.price, product.stock, product.minOrderQty),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10.5.sp,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
