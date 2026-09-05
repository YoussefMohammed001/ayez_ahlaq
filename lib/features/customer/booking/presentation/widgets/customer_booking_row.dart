import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/customer_booking.dart';
import 'customer_booking_status_label.dart';
import 'customer_booking_status_tone.dart';

class CustomerBookingRow extends StatelessWidget {
  final CustomerBooking booking;
  final VoidCallback onTap;

  const CustomerBookingRow({super.key, required this.booking, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  booking.shopName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                AppDateTime.formatHour(booking.slotTime),
                style: TextStyle(fontSize: 10.5.sp, color: context.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            booking.serviceLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11.5.sp, color: context.colorScheme.onSurfaceVariant),
          ),
          if (booking.barberName.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              booking.barberName,
              style: TextStyle(fontSize: 10.5.sp, color: context.semantic.info),
            ),
          ],
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusBadge(label: booking.status.label, tone: booking.status.tone),
              Text(
                S().currencyEgp(booking.totalPrice),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.semantic.accentSoft,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
