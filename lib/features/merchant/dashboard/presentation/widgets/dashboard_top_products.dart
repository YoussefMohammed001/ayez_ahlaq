import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../products/domain/entities/product_insights.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../products/presentation/manager/merchant_products_state.dart';
import '../../../products/presentation/widgets/product_thumbnail.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardTopProducts extends StatelessWidget {
  const DashboardTopProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, state) {
        final top = state.products.mostStocked;

        if (top.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: S().topProducts),
            for (final product in top)
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
                        color: context.semantic.accentSoft,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
