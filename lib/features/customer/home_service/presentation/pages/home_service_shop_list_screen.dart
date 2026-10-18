import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/home_service_shops_cubit.dart';
import '../manager/home_service_shops_state.dart';
import '../widgets/home_service_any_nearby_card.dart';
import '../widgets/home_service_shop_row.dart';
import '../../../../../shared/location/presentation/widgets/nearby_location_banner.dart';
import 'home_service_request_args.dart';
import 'home_service_shop_list_args.dart';

class HomeServiceShopListScreen extends StatefulWidget {
  final HomeServiceShopListArgs args;

  const HomeServiceShopListScreen({super.key, required this.args});

  @override
  State<HomeServiceShopListScreen> createState() =>
      _HomeServiceShopListScreenState();
}

class _HomeServiceShopListScreenState extends State<HomeServiceShopListScreen> {
  bool _forwardedToAnyNearby = false;

  @override
  void initState() {
    super.initState();
    _loadShops();
  }

  Future<void> _loadShops({bool isRefresh = false}) {
    return context.read<HomeServiceShopsCubit>().loadShops(
      date: widget.args.date,
      time: widget.args.time,
      isRefresh: isRefresh,
    );
  }

  void _goToAnyNearby() {
    if (_forwardedToAnyNearby) return;
    _forwardedToAnyNearby = true;
    context.pushReplacement(
      Routes.customerHomeServiceRequestScreen,
      extra: HomeServiceRequestArgs(dateTimeArgs: widget.args),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().homeServiceShopListTitle),
      body: Column(
        children: [
          BlocBuilder<HomeServiceShopsCubit, HomeServiceShopsState>(
            buildWhen: (previous, current) =>
                previous.sortedByDistance != current.sortedByDistance ||
                previous.status != current.status,
            builder: (context, state) => NearbyLocationBanner(
              locationResolved:
                  state.sortedByDistance ||
                  state.status != HomeServiceShopsStatus.success,
              onEnabled: () => _loadShops(isRefresh: true),
            ),
          ),
          Expanded(child: _buildShops()),
        ],
      ),
    );
  }

  Widget _buildShops() {
    return BlocBuilder<HomeServiceShopsCubit, HomeServiceShopsState>(
      builder: (context, state) {
        if (state.status == HomeServiceShopsStatus.loading &&
            state.shops.isEmpty) {
          return const ListSkeleton();
        }

        if (state.status == HomeServiceShopsStatus.failure &&
            state.shops.isEmpty) {
          return RefreshableStateView(
            onRefresh: () => _loadShops(isRefresh: true),
            child: AppErrorState(
              message: state.errorMessage,
              onRetry: () => _loadShops(isRefresh: true),
            ),
          );
        }

        if (state.status == HomeServiceShopsStatus.success &&
            state.shops.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _goToAnyNearby());
          return const ListSkeleton();
        }

        return RefreshIndicator(
          onRefresh: () => _loadShops(isRefresh: true),
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            itemCount: state.shops.length + 1,
            itemBuilder: (_, index) {
              if (index == 0) {
                return HomeServiceAnyNearbyCard(
                  onPressed: () => context.push(
                    Routes.customerHomeServiceRequestScreen,
                    extra: HomeServiceRequestArgs(dateTimeArgs: widget.args),
                  ),
                );
              }

              final shop = state.shops[index - 1];
              return HomeServiceShopRow(
                shop: shop,
                onTap: () => context.push(
                  Routes.customerHomeServiceRequestScreen,
                  extra: HomeServiceRequestArgs(
                    shop: shop,
                    dateTimeArgs: widget.args,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
