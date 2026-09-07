import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_order.dart';
import '../manager/barber_storefront_orders_cubit.dart';
import '../manager/barber_storefront_orders_state.dart';
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

    return BlocBuilder<BarberStorefrontOrdersCubit, BarberStorefrontOrdersState>(
      buildWhen: (previous, current) =>
          previous.updatingOrderId != current.updatingOrderId,
      builder: (context, state) {
        final isUpdating = state.updatingOrderId == order.id;

        return Column(
          children: [
            for (final next in order.validNextStatuses)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: PrimaryCtaButton(
                  label: S().moveStatusTo(next.labelFor(order.fulfillmentType)),
                  isLoading: isUpdating,
                  onPressed: () => context
                      .read<BarberStorefrontOrdersCubit>()
                      .advanceStatus(order.id, next),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDecisionButtons(BuildContext context) {
    return BlocBuilder<BarberStorefrontOrdersCubit, BarberStorefrontOrdersState>(
      buildWhen: (previous, current) =>
          previous.updatingOrderId != current.updatingOrderId,
      builder: (context, state) {
        final isUpdating = state.updatingOrderId == order.id;

        return Column(
          children: [
            PrimaryCtaButton(
              label: S().acceptOrder,
              isLoading: isUpdating,
              onPressed: () => context
                  .read<BarberStorefrontOrdersCubit>()
                  .acceptOrder(order.id),
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
              onPressed: isUpdating
                  ? null
                  : () => RejectStorefrontOrderSheet.show(context, order.id),
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
      },
    );
  }

  Widget _buildTerminalNote(BuildContext context) {
    return Center(
      child: Text(
        order.status.labelFor(order.fulfillmentType),
        style: TextStyle(
          color: context.semantic.success,
          fontWeight: FontWeight.w700,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
