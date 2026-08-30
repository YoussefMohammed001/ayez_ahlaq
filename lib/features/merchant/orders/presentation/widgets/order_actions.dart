import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../domain/entities/purchase_order.dart';
import '../manager/merchant_orders_cubit.dart';
import 'reject_order_sheet.dart';
import '../../../../../generated/l10n.dart';
import 'order_status_label.dart';
import '../../../../../core/extensions/ext_theme.dart';

class OrderActions extends StatelessWidget {
  final PurchaseOrder order;

  const OrderActions({super.key, required this.order});

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
              onPressed: () => context.read<MerchantOrdersCubit>().advanceStatus(
                order.id,
                next,
              ),
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
              context.read<MerchantOrdersCubit>().acceptOrder(order.id),
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
          onPressed: () => RejectOrderSheet.show(context, order.id),
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
