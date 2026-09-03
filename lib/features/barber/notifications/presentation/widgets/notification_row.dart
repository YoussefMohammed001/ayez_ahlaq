import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../domain/entities/barber_notification.dart';
import '../../../../../core/extensions/ext_theme.dart';

class NotificationRow extends StatelessWidget {
  final BarberNotification notification;
  final VoidCallback onTap;

  const NotificationRow({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final unseen = !notification.seen;

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 10.h),
      borderColor: unseen ? context.colorScheme.primary : context.colorScheme.outline,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: unseen
                  ? context.colorScheme.primaryContainer
                  : context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              notification.kind.icon,
              size: 18.r,
              color: unseen
                  ? context.semantic.accentSoft
                  : context.colorScheme.onSurfaceVariant,
            ),
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
                        notification.title,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: context.colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      RelativeDateLabel.format(notification.createdAt),
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.body,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
