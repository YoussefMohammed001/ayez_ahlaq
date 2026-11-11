import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../../orders/presentation/manager/merchant_orders_state.dart';
import '../../helpers/sub_home_summary.dart';
import 'sub_home_stat_tile.dart';

class SubHomeStatsRow extends StatelessWidget {
  final VoidCallback onTap;

  const SubHomeStatsRow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
      builder: (context, state) {
        final loaded =
            state.status != OrdersStatus.initial &&
            !(state.status == OrdersStatus.loading && state.orders.isEmpty);
        final summary = SubHomeSummary.ordersOf(state.orders);

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SubHomeStatTile(
                    icon: Icons.notifications_active_outlined,
                    value: loaded ? '${summary.pending}' : '-',
                    label: S().subHomePendingLabel,
                    highlight: summary.pending > 0,
                    onTap: onTap,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SubHomeStatTile(
                    icon: Icons.local_shipping_outlined,
                    value: loaded ? '${summary.active}' : '-',
                    label: S().subHomeActiveLabel,
                    onTap: onTap,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
