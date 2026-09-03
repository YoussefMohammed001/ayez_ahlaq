import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking.dart';

class BookingInfoCard extends StatelessWidget {
  final Booking booking;

  const BookingInfoCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow(context, S().serviceLabel, booking.serviceLabel),
          if ((booking.styleName ?? '').isNotEmpty)
            _buildRow(context, S().styleLabel, booking.styleName!),
          _buildRow(
            context,
            S().bookingDateLabel,
            '${booking.bookingDate} · ${AppDateTime.formatHour(booking.slotTime)}',
          ),
          _buildRow(context, S().paymentMethodLabel, booking.paymentMethod),
          _buildRow(context, S().orderTotal, S().currencyEgp(booking.totalPrice)),
          if (booking.queuePosition != null)
            _buildRow(
              context,
              S().queuePositionLabel,
              '${booking.queuePosition}',
            ),
          if (booking.status.needsDecision && booking.decisionDeadline != null)
            _buildRow(
              context,
              S().decisionDeadlineLabel,
              AppDateTime.formatDateTime(booking.decisionDeadline!),
            ),
          if (booking.addons.isNotEmpty)
            _buildRow(
              context,
              S().addonsLabel,
              booking.addons
                  .map((a) => '${a.name ?? '#${a.productId}'} x${a.quantity}')
                  .join(S().listSeparator),
            ),
          if ((booking.note ?? '').isNotEmpty)
            _buildRow(context, S().walkInNoteLabel, booking.note!),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
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
