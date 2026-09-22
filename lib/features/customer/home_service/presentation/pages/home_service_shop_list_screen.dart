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
import '../manager/home_service_shops_cubit.dart';
import '../manager/home_service_shops_state.dart';
import '../widgets/home_service_shop_row.dart';

class HomeServiceShopListScreen extends StatefulWidget {
  const HomeServiceShopListScreen({super.key});

  @override
  State<HomeServiceShopListScreen> createState() =>
      _HomeServiceShopListScreenState();
}

class _HomeServiceShopListScreenState
    extends State<HomeServiceShopListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeServiceShopsCubit>().loadShops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().homeServiceShopListTitle),
      body: BlocBuilder<HomeServiceShopsCubit, HomeServiceShopsState>(
        builder: (context, state) {
          final cubit = context.read<HomeServiceShopsCubit>();

          if (state.status == HomeServiceShopsStatus.loading &&
              state.shops.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == HomeServiceShopsStatus.failure &&
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
                icon: Icons.home_repair_service_outlined,
                title: S().noHomeServiceShopsYet,
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
                return HomeServiceShopRow(
                  shop: shop,
                  onTap: () => context.push(
                    Routes.customerHomeServiceRequestScreen,
                    extra: shop,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
