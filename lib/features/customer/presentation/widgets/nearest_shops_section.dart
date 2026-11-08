import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/widgets/list_skeleton.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../generated/l10n.dart';
import '../../shops/presentation/manager/customer_shops_cubit.dart';
import '../../shops/presentation/manager/customer_shops_state.dart';
import '../../shops/presentation/widgets/shop_row.dart';
import '../../shops/presentation/widgets/shops_area_selector.dart';
import '../../../../shared/location/presentation/widgets/nearby_location_banner.dart';
import 'dashboard_empty_hint.dart';

class NearestShopsSection extends StatelessWidget {
  const NearestShopsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerShopsCubit, CustomerShopsState>(
      builder: (context, state) {
        final nearest = state.shops.take(3).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: S().nearestShopsTitle,
              actionLabel: S().seeAll,
              onAction: () => context.push(Routes.customerBrowseShopsScreen),
            ),
            ShopsAreaSelector(padding: EdgeInsets.symmetric(vertical: 8.h)),
            if (state.usesDeviceLocation)
              NearbyLocationBanner(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                locationResolved:
                    state.sortedByDistance ||
                    state.status != CustomerShopsStatus.success,
                onEnabled: context.read<CustomerShopsCubit>().loadShops,
              ),
            if (state.status == CustomerShopsStatus.loading &&
                state.shops.isEmpty)
              const ListSkeleton(itemCount: 3)
            else if (nearest.isEmpty)
              DashboardEmptyHint(message: S().noShopsYet)
            else
              ...nearest.map(
                (shop) => ShopRow(
                  shop: shop,
                  onTap: () => context.push(
                    Routes.customerShopDetailScreen,
                    extra: shop.id,
                  ),
                  onShopTap: () => context.push(
                    Routes.customerStoreProductsScreen,
                    extra: shop.id,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
