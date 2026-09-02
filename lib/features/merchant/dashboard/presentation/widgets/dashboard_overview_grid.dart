import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/stat_tile.dart';
import '../manager/merchant_dashboard_cubit.dart';
import '../manager/merchant_dashboard_state.dart';
import '../../../../../generated/l10n.dart';

class DashboardOverviewGrid extends StatelessWidget {
  final VoidCallback onGoToOrders;

  const DashboardOverviewGrid({super.key, required this.onGoToOrders});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantDashboardCubit, MerchantDashboardState>(
      builder: (context, state) {
        final data = state.dashboard;

        return GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 1.55,
          children: [
            StatTile(
              value: S().currencyEgp(data?.monthRevenue ?? 0),
              label: S().monthRevenue,
            ),
            StatTile(
              value: '${data?.pendingOrders ?? 0}',
              label: S().pendingOrders,
              onTap: onGoToOrders,
            ),
            StatTile(
              value: '${data?.activeOrders ?? 0}',
              label: S().activeOrders,
              onTap: onGoToOrders,
            ),
            StatTile(
              value: '${data?.deliveredThisMonth ?? 0}',
              label: S().deliveredThisMonth,
              onTap: onGoToOrders,
            ),
            StatTile(
              value: '${data?.productCount ?? 0}',
              label: S().activeProducts,
            ),
            StatTile(
              value: '${data?.liveDiscounts ?? 0}',
              label: S().liveDiscounts,
              onTap: () => context.push(Routes.merchantDiscountsScreen),
            ),
          ],
        );
      },
    );
  }
}
