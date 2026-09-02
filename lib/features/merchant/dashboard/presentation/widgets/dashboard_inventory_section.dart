import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/stat_tile.dart';
import '../../../products/domain/entities/product_insights.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../products/presentation/manager/merchant_products_state.dart';
import 'dashboard_categories_row.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardInventorySection extends StatelessWidget {
  const DashboardInventorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, state) {
        final products = state.products;

        if (products.isEmpty) return const SizedBox.shrink();

        final outOfStock = products.outOfStock.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: S().inventoryTitle),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 2.4,
              children: [
                StatTile(
                  value: '${products.length}',
                  label: S().productsCount,
                ),
                StatTile(
                  value: '${products.totalStockUnits}',
                  label: S().totalStockUnits,
                ),
                StatTile(
                  value: '$outOfStock',
                  label: S().outOfStockShort,
                  valueColor: outOfStock > 0 ? context.colorScheme.error : null,
                ),
                StatTile(
                  value: '${products.discounted.length}',
                  label: S().discountedProducts,
                ),
              ],
            ),
            const DashboardCategoriesRow(),
          ],
        );
      },
    );
  }
}
