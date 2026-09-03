import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking.dart';
import '../manager/bookings_cubit.dart';
import 'booking_status_label.dart';
import 'reject_booking_sheet.dart';

class BookingActions extends StatelessWidget {
  final Booking booking;

  const BookingActions({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    if (booking.status.needsDecision) return _buildDecisionButtons(context);

    if (booking.status.isTerminal || !booking.canAdvance) {
      return _buildTerminalNote(context);
    }

    return Column(
      children: [
        for (final next in booking.nextStatuses)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: PrimaryCtaButton(
              label: S().moveStatusTo(next.label),
              onPressed: () =>
                  context.read<BookingsCubit>().advanceStatus(booking.id, next),
            ),
          ),
      ],
    );
  }

  Widget _buildDecisionButtons(BuildContext context) {
    return Column(
      children: [
        PrimaryCtaButton(
          label: S().confirmBooking,
          onPressed: () =>
              context.read<BookingsCubit>().confirmBooking(booking.id),
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
          onPressed: () => RejectBookingSheet.show(context, booking.id),
          child: Text(
            S().rejectBooking,
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
        booking.status.label,
        style: TextStyle(
          color: context.semantic.success,
          fontWeight: FontWeight.w700,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
