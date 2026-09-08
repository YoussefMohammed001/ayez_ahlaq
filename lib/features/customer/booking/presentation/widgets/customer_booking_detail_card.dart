import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/customer_booking.dart';
import 'booking_extras_summary.dart';
import 'customer_booking_status_label.dart';
import 'customer_booking_status_tone.dart';

class CustomerBookingDetailCard extends StatelessWidget {
  final CustomerBooking booking;

  const CustomerBookingDetailCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                booking.code,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.onSurface,
                ),
              ),
              StatusBadge(label: booking.status.label, tone: booking.status.tone),
            ],
          ),
          SizedBox(height: 12.h),
          _row(context, S().shopsTitle, booking.shopName),
          _row(context, S().barberLabel, booking.barberName),
          _row(context, S().serviceLabel, booking.serviceLabel),
          if ((booking.styleName ?? '').isNotEmpty)
            _row(context, S().styleLabel, booking.styleName!),
          _row(
            context,
            S().bookingDateLabel,
            '${booking.bookingDate} · ${AppDateTime.formatHour(booking.slotTime)}',
          ),
          _row(context, S().paymentMethodLabel, booking.paymentMethod),
          BookingExtrasSummary(addons: booking.addons),
          _row(context, S().orderTotal, S().currencyEgp(booking.totalPrice)),
          if (booking.queuePosition != null)
            _row(context, S().queuePositionLabel, '${booking.queuePosition}'),
          if (booking.peopleAhead != null)
            _row(context, S().peopleAheadLabel, '${booking.peopleAhead}'),
          if ((booking.note ?? '').isNotEmpty)
            _row(context, S().walkInNoteLabel, booking.note!),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: context.colorScheme.onSurfaceVariant),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
