import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_settle_decision.dart';

class UnresolvedBookingRow extends StatefulWidget {
  final Booking booking;
  final BookingSettleDecision? decision;
  final ValueChanged<BookingSettleDecision?> onDecisionChanged;
  final ValueChanged<String> onReasonChanged;

  const UnresolvedBookingRow({
    super.key,
    required this.booking,
    required this.decision,
    required this.onDecisionChanged,
    required this.onReasonChanged,
  });

  @override
  State<UnresolvedBookingRow> createState() => _UnresolvedBookingRowState();
}

class _UnresolvedBookingRowState extends State<UnresolvedBookingRow> {
  final _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reasonController.addListener(
      () => widget.onReasonChanged(_reasonController.text),
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;
    final scheme = context.colorScheme;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  booking.customerName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                AppDateTime.formatHour(booking.slotTime),
                style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            booking.serviceLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: widget.decision == BookingSettleDecision.approve
                        ? context.semantic.success.withValues(alpha: 0.12)
                        : null,
                    side: BorderSide(
                      color: widget.decision == BookingSettleDecision.approve
                          ? context.semantic.success
                          : scheme.outline,
                    ),
                  ),
                  onPressed: () => widget.onDecisionChanged(
                    widget.decision == BookingSettleDecision.approve
                        ? null
                        : BookingSettleDecision.approve,
                  ),
                  child: Text(S().settleApprove, style: TextStyle(color: context.semantic.success)),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: widget.decision == BookingSettleDecision.cancel
                        ? context.semantic.warning.withValues(alpha: 0.12)
                        : null,
                    side: BorderSide(
                      color: widget.decision == BookingSettleDecision.cancel
                          ? context.semantic.warning
                          : scheme.outline,
                    ),
                  ),
                  onPressed: () => widget.onDecisionChanged(
                    widget.decision == BookingSettleDecision.cancel
                        ? null
                        : BookingSettleDecision.cancel,
                  ),
                  child: Text(S().settleCancel, style: TextStyle(color: context.semantic.warning)),
                ),
              ),
            ],
          ),
          if (widget.decision == BookingSettleDecision.cancel) ...[
            SizedBox(height: 10.h),
            AppTextField(
              controller: _reasonController,
              hint: S().settleCancelReasonHint,
            ),
          ],
        ],
      ),
    );
  }
}
