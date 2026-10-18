import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/location/presentation/widgets/nearby_location_banner.dart';
import '../manager/customer_shops_cubit.dart';
import '../manager/customer_shops_state.dart';
import '../widgets/shop_row.dart';

class BrowseShopsScreen extends StatefulWidget {
  const BrowseShopsScreen({super.key});

  @override
  State<BrowseShopsScreen> createState() => _BrowseShopsScreenState();
}

class _BrowseShopsScreenState extends State<BrowseShopsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerShopsCubit>().loadShops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().shopsTitle),
      body: Column(
        children: [
          BlocBuilder<CustomerShopsCubit, CustomerShopsState>(
            buildWhen: (previous, current) =>
                previous.sortedByDistance != current.sortedByDistance ||
                previous.status != current.status,
            builder: (context, state) => NearbyLocationBanner(
              locationResolved:
                  state.sortedByDistance ||
                  state.status != CustomerShopsStatus.success,
              onEnabled: context.read<CustomerShopsCubit>().loadShops,
            ),
          ),
          Expanded(child: _buildShops()),
        ],
      ),
    );
  }

  Widget _buildShops() {
    return BlocBuilder<CustomerShopsCubit, CustomerShopsState>(
      builder: (context, state) {
        final cubit = context.read<CustomerShopsCubit>();

        if (state.status == CustomerShopsStatus.loading &&
            state.shops.isEmpty) {
          return const ListSkeleton();
        }

        if (state.status == CustomerShopsStatus.failure &&
            state.shops.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadShops,
            child: AppErrorState(
              message: state.errorMessage,
              onRetry: cubit.loadShops,
            ),
          );
        }

        if (state.shops.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadShops,
            child: AppEmptyState(
              icon: Icons.storefront_outlined,
              title: S().noShopsYet,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: cubit.loadShops,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            itemCount: state.shops.length,
            itemBuilder: (_, index) {
              final shop = state.shops[index];
              return ShopRow(
                shop: shop,
                onTap: () => context.push(
                  Routes.customerShopDetailScreen,
                  extra: shop.id,
                ),
                onShopTap: () => context.push(
                  Routes.customerStoreProductsScreen,
                  extra: shop.id,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
