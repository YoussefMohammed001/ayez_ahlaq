import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/user_helpers.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../attendance/presentation/manager/member_attendance_cubit.dart';
import '../../../dashboard/presentation/widgets/dashboard_greeting.dart';
import '../../../notifications/presentation/manager/merchant_notifications_cubit.dart';
import '../../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../sales/presentation/manager/sales_cubit.dart';
import '../../../team/presentation/manager/my_merchant_member_cubit.dart';
import '../../../team/presentation/manager/my_schedule_cubit.dart';
import '../../../team/presentation/widgets/merchant_permission_gate.dart';
import '../../domain/sub_merchant_tab.dart';
import '../widgets/home/sub_home_attendance_card.dart';
import '../widgets/home/sub_home_low_stock_card.dart';
import '../widgets/home/sub_home_latest_orders.dart';
import '../widgets/home/sub_home_sales_card.dart';
import '../widgets/home/sub_home_schedule_card.dart';
import '../widgets/home/sub_home_stats_row.dart';

class SubMerchantHomeScreen extends StatelessWidget {
  final ValueChanged<SubMerchantTab> onGoTo;

  const SubMerchantHomeScreen({super.key, required this.onGoTo});

  Future<void> _refresh(BuildContext context) {
    final canSell =
        context.read<MyMerchantMemberCubit>().state.member?.canSell ?? false;

    return Future.wait([
      context.read<MemberAttendanceCubit>().load(),
      context.read<MerchantOrdersCubit>().loadOrders(),
      context.read<MerchantProductsCubit>().loadProducts(),
      context.read<MyScheduleCubit>().load(),
      context.read<MerchantNotificationsCubit>().refreshUnseenCount(),
      if (canSell) context.read<SalesCubit>().refresh(),
    ]);
  }

  Future<void> _newSale(BuildContext context) async {
    final sales = context.read<SalesCubit>();
    final created = await context.push<bool>(Routes.merchantNewSaleScreen);
    if (created ?? false) sales.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refresh(context),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
            children: [
              DashboardGreeting(
                businessName: UserHelpers.displayName,
                onProfileTap: () => onGoTo(SubMerchantTab.account),
                onNotificationsTap: () =>
                    context.push(Routes.merchantNotificationsScreen),
              ),
              SizedBox(height: 18.h),
              SubHomeStatsRow(onTap: () => onGoTo(SubMerchantTab.orders)),
              SubHomeAttendanceCard(
                onTap: () => onGoTo(SubMerchantTab.attendance),
              ),
              const SubHomeScheduleCard(),
              MerchantPermissionGate(
                allows: MerchantPermissionGate.canSell,
                builder: (context, allowed) => allowed
                    ? SubHomeSalesCard(
                        onOpenSales: () => onGoTo(SubMerchantTab.sales),
                        onNewSale: () => _newSale(context),
                      )
                    : const SizedBox.shrink(),
              ),
              SubHomeLatestOrders(
                onSeeAll: () => onGoTo(SubMerchantTab.orders),
              ),
              SubHomeLowStockCard(onTap: () => onGoTo(SubMerchantTab.products)),
            ],
          ),
        ),
      ),
    );
  }
}
