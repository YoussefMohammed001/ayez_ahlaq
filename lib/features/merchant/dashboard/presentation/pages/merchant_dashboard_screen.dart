import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/stat_tile.dart';
import '../../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../orders/presentation/manager/merchant_orders_state.dart';
import '../../../orders/presentation/widgets/order_card.dart';
import '../../../discounts/presentation/manager/merchant_discounts_cubit.dart';
import '../../domain/entities/merchant_dashboard.dart';
import '../manager/merchant_dashboard_cubit.dart';
import '../manager/merchant_dashboard_state.dart';
import '../widgets/dashboard_greeting.dart';
import '../widgets/dashboard_live_offers.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class MerchantDashboardScreen extends StatelessWidget {
  final VoidCallback onGoToOrders;
  final String businessName;

  const MerchantDashboardScreen({
    super.key,
    required this.onGoToOrders,
    required this.businessName,
  });

  Future<void> _refresh(BuildContext context) async {
    await Future.wait([
      context.read<MerchantDashboardCubit>().loadDashboard(),
      context.read<MerchantDiscountsCubit>().loadDiscounts(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refresh(context),
          child: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            children: [
              DashboardGreeting(businessName: businessName),
              SizedBox(height: 8.h),
              Text(
                S().merchantDashboardNote,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 16.h),
              _buildStats(),
              const DashboardLiveOffers(),
              SectionTitle(
                title: S().latestOrders,
                actionLabel: S().allOrders,
                onAction: onGoToOrders,
              ),
              _buildRecentOrders(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStats() {
    return BlocBuilder<MerchantDashboardCubit, MerchantDashboardState>(
      builder: (context, state) {
        final data = state.dashboard;

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: StatTile(
                    value: '${data?.pendingOrders ?? 0}',
                    label: S().pendingOrders,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: StatTile(
                    value: S().currencyEgp(data?.monthRevenue ?? 0),
                    label: S().monthRevenue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: StatTile(
                    value: '${data?.productCount ?? 0}',
                    label: S().activeProducts,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(child: _buildDiscountsTile(context, data)),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDiscountsTile(BuildContext context, MerchantDashboard? data) {
    final count = data?.liveDiscounts ?? 0;

    return StatTile(
      value: '$count',
      label: S().liveDiscounts,
      valueColor: count > 0 ? context.semantic.success : null,
      onTap: () => context.push(Routes.merchantDiscountsScreen),
    );
  }

  Widget _buildRecentOrders() {
    return BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
      builder: (context, state) {
        final recent = state.orders.take(3).toList();

        return Column(
          children: [
            for (final order in recent)
              OrderCard(
                order: order,
                dateLabel: RelativeDateLabel.format(order.createdAt),
                onTap: () => context.push(
                  Routes.merchantOrderDetailsScreen,
                  extra: order,
                ),
              ),
          ],
        );
      },
    );
  }
}
