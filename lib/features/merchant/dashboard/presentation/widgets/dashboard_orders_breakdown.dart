import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../orders/domain/entities/order_insights.dart';
import '../../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../orders/presentation/manager/merchant_orders_state.dart';
import '../../../orders/presentation/widgets/order_status_label.dart';
import '../../../orders/presentation/widgets/order_status_tone.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardOrdersBreakdown extends StatelessWidget {
  const DashboardOrdersBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
      builder: (context, state) {
        final statuses = state.orders.presentStatuses;

        if (statuses.isEmpty) return const SizedBox.shrink();

        final counts = state.orders.countByStatus;

        return AppCard(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Wrap(
            spacing: 10.w,
            runSpacing: 8.h,
            children: [
              for (final status in statuses)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatusBadge(label: status.label, tone: status.tone),
                    SizedBox(width: 5.w),
                    Text(
                      '${counts[status]}',
                      style: font13w700.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
