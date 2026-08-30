import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/toggle_switch.dart';
import '../../domain/entities/merchant_product.dart';
import 'product_thumbnail.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class ProductRow extends StatelessWidget {
  final MerchantProduct product;
  final VoidCallback onToggle;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const ProductRow({
    super.key,
    required this.product,
    required this.onToggle,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: product.active ? 1 : 0.5,
      child: AppCard(
        onTap: onTap,
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 10.h),
        child: Row(
          children: [
            ProductThumbnail(product: product, size: 54.r),
            SizedBox(width: 12.w),
            Expanded(child: _buildInfo(context)),
            Column(
              children: [
                ToggleSwitch(value: product.active, onTap: onToggle),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: onRemove,
                  child: Icon(
                    Icons.delete_outline,
                    size: 18.r,
                    color: context.semantic.warning,
                  ),
                ),
              ],
            ),
          ],
        ),
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
          S().productMetaLine(product.price, product.totalStock, product.minOrderQty),
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
