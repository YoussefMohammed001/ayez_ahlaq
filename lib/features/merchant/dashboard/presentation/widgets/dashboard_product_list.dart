import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../products/domain/entities/merchant_product.dart';
import '../../../products/presentation/widgets/product_thumbnail.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardProductList extends StatelessWidget {
  final String title;
  final List<MerchantProduct> products;
  final Color? countColor;

  const DashboardProductList({
    super.key,
    required this.title,
    required this.products,
    this.countColor,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        for (final product in products)
          AppCard(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(10.w),
            onTap: () => context.push(
              Routes.merchantProductDetailsScreen,
              extra: product,
            ),
            child: Row(
              children: [
                ProductThumbnail(product: product, size: 40.r),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: font13w600.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                Text(
                  S().stockUnits(product.totalStock),
                  style: font12w600.copyWith(
                    color: countColor ?? context.semantic.accentSoft,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
