import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../shared/tour/tour_target.dart';
import '../../../../../shared/widgets/notifications_icon_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../notifications/presentation/widgets/unseen_notifications_badge.dart';
import '../../../profile/presentation/widgets/barber_shop_photo_avatar.dart';

class BarberHomeGreeting extends StatelessWidget {
  final String shopName;
  final VoidCallback onAvatarTap;
  final VoidCallback onNotificationsTap;
  final GlobalKey? notificationsTourKey;

  const BarberHomeGreeting({
    super.key,
    required this.shopName,
    required this.onAvatarTap,
    required this.onNotificationsTap,
    this.notificationsTourKey,
  });

  Widget _withTour(Widget bell) {
    final key = notificationsTourKey;
    if (key == null) return bell;
    return TourTarget(
      tourKey: key,
      title: S().tourNotificationsTitle,
      description: S().tourNotificationsBody,
      borderRadius: BorderRadius.circular(40),
      child: bell,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S().greeting,
                style: font12w400.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                shopName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: HeadingStyles.h4.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        _withTour(
          NotificationsIconButton(
            badge: const BarberUnseenNotificationsBadge(),
            onTap: onNotificationsTap,
          ),
        ),
        SizedBox(width: 14.w),
        GestureDetector(
          onTap: onAvatarTap,
          child: BarberShopPhotoAvatar(
            initials: shopName.isEmpty
                ? S().avatarFallback
                : shopName.substring(0, 1),
            canEdit: false,
            size: 44,
          ),
        ),
      ],
    );
  }
}
