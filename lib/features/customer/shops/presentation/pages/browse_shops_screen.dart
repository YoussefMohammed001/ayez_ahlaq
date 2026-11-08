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
import '../../domain/entities/shops_search.dart';
import '../manager/customer_shops_cubit.dart';
import '../manager/customer_shops_state.dart';
import '../widgets/shop_row.dart';
import '../widgets/shops_area_selector.dart';

class BrowseShopsScreen extends StatefulWidget {
  const BrowseShopsScreen({super.key});

  @override
  State<BrowseShopsScreen> createState() => _BrowseShopsScreenState();
}

class _BrowseShopsScreenState extends State<BrowseShopsScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    context.read<CustomerShopsCubit>().loadShops();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().shopsTitle),
      body: Column(
        children: [
          ShopsAreaSelector(
            searchController: _searchController,
            onSearchChanged: (value) => setState(() => _query = value),
          ),
          BlocBuilder<CustomerShopsCubit, CustomerShopsState>(
            buildWhen: (previous, current) =>
                previous.sortedByDistance != current.sortedByDistance ||
                previous.status != current.status ||
                previous.area != current.area,
            builder: (context, state) => !state.usesDeviceLocation
                ? const SizedBox.shrink()
                : NearbyLocationBanner(
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

        final shops = ShopsSearch.filter(state.shops, _query);

        if (shops.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadShops,
            child: AppEmptyState(
              icon: Icons.search_off_rounded,
              title: S().noShopsMatch,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: cubit.loadShops,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            itemCount: shops.length,
            itemBuilder: (_, index) {
              final shop = shops[index];
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
