import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_order.dart';
import '../manager/barber_storefront_orders_cubit.dart';
import 'reject_storefront_order_sheet.dart';
import 'storefront_order_status_label.dart';

class StorefrontOrderActions extends StatelessWidget {
  final StorefrontOrder order;

  const StorefrontOrderActions({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    if (order.status.needsDecision) return _buildDecisionButtons(context);

    if (order.status.isTerminal || !order.canAdvance) {
      return _buildTerminalNote(context);
    }

    return Column(
      children: [
        for (final next in order.nextStatuses)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: PrimaryCtaButton(
              label: S().moveStatusTo(next.label),
              onPressed: () => context
                  .read<BarberStorefrontOrdersCubit>()
                  .advanceStatus(order.id, next),
            ),
          ),
      ],
    );
  }

  Widget _buildDecisionButtons(BuildContext context) {
    return Column(
      children: [
        PrimaryCtaButton(
          label: S().acceptOrder,
          onPressed: () =>
              context.read<BarberStorefrontOrdersCubit>().acceptOrder(order.id),
        ),
        SizedBox(height: 10.h),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(52.h),
            side: BorderSide(color: context.colorScheme.outline),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          onPressed: () => RejectStorefrontOrderSheet.show(context, order.id),
          child: Text(
            S().rejectOrder,
            style: TextStyle(
              color: context.semantic.warning,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTerminalNote(BuildContext context) {
    return Center(
      child: Text(
        order.status.label,
        style: TextStyle(
          color: context.semantic.success,
          fontWeight: FontWeight.w700,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
