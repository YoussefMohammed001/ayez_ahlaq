import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../categories/presentation/manager/merchant_categories_cubit.dart';
import '../../../categories/presentation/manager/merchant_categories_state.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../products/presentation/manager/merchant_products_state.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardCategoriesRow extends StatelessWidget {
  const DashboardCategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, productsState) {
        return BlocBuilder<MerchantCategoriesCubit, MerchantCategoriesState>(
          builder: (context, categoriesState) {
            final used = productsState.usedCategoryIds;
            final categories = categoriesState.assignable
                .where((category) => used.contains(category.id))
                .toList();

            if (categories.isEmpty) return const SizedBox.shrink();

            return AppCard(
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final category in categories)
                    _buildChip(
                      context,
                      category.name,
                      productsState.products
                          .where((p) => p.categoryId == category.id)
                          .length,
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChip(BuildContext context, String name, int count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Text(
        '$name  $count',
        style: font11w600.copyWith(color: context.colorScheme.onSurface),
      ),
    );
  }
}
