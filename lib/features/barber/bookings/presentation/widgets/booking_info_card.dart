import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_addon.dart';
import 'booking_adjustments_section.dart';

class BookingInfoCard extends StatelessWidget {
  final Booking booking;

  const BookingInfoCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final drinks = booking.addons.where((a) => a.isDrink).toList();
    final products = booking.addons.where((a) => !a.isDrink).toList();

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
          if (drinks.isNotEmpty) _buildExtrasSection(context, S().drinksTitle, drinks),
          if (products.isNotEmpty) _buildExtrasSection(context, S().addonsLabel, products),
          if (booking.adjustments.isNotEmpty)
            BookingAdjustmentsSection(adjustments: booking.adjustments),
          if ((booking.note ?? '').isNotEmpty)
            _buildRow(context, S().walkInNoteLabel, booking.note!),
        ],
      ),
    );
  }

  Widget _buildExtrasSection(BuildContext context, String title, List<BookingAddon> items) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: context.colorScheme.onSurfaceVariant),
          ),
          SizedBox(height: 4.h),
          for (final item in items) _buildExtraRow(context, item),
        ],
      ),
    );
  }

  Widget _buildExtraRow(BuildContext context, BookingAddon item) {
    final name = item.name ?? '#${item.drinkId ?? item.productId}';
    final total = item.lineTotal ?? ((item.price ?? 0) * item.quantity);

    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${item.quantity}× $name',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.5.sp, color: context.colorScheme.onSurface),
            ),
          ),
          Text(
            S().currencyEgp(total),
            style: TextStyle(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),
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
