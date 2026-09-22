import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/avatar_circle.dart';
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
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarCircle(
            initials: booking.shopName.isEmpty ? S().avatarFallback : booking.shopName.substring(0, 1),
            size: 46.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
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
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    StatusBadge(label: booking.status.label, tone: booking.status.tone),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  booking.serviceLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.sp, color: scheme.onSurfaceVariant),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.schedule_rounded, size: 14.r, color: scheme.onSurfaceVariant),
                    SizedBox(width: 4.w),
                    Text(
                      '${booking.bookingDate} · ${AppDateTime.formatHour(booking.slotTime)}',
                      style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                    ),
                    const Spacer(),
                    Text(
                      S().currencyEgp(booking.totalPrice),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: context.semantic.accentSoft,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
