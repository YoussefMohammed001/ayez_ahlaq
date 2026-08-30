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
import '../manager/merchant_dashboard_cubit.dart';
import '../manager/merchant_dashboard_state.dart';
import '../widgets/dashboard_greeting.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: context.read<MerchantDashboardCubit>().loadDashboard,
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
        return Row(
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
            SizedBox(width: 10.w),
            Expanded(
              child: StatTile(
                value: '${data?.productCount ?? 0}',
                label: S().activeProducts,
              ),
            ),
          ],
        );
      },
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
