import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/heading_styles.dart';
import '../../../../core/theme/styles.dart';
import '../../../../core/widgets/avatar_circle.dart';
import '../../../../shared/widgets/notifications_icon_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../notifications/presentation/widgets/customer_unseen_notifications_badge.dart';

class CustomerHomeGreeting extends StatelessWidget {
  final String name;
  final VoidCallback onAvatarTap;
  final VoidCallback onNotificationsTap;

  const CustomerHomeGreeting({
    super.key,
    required this.name,
    required this.onAvatarTap,
    required this.onNotificationsTap,
  });

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
                name,
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
        NotificationsIconButton(
          badge: const CustomerUnseenNotificationsBadge(),
          onTap: onNotificationsTap,
        ),
        SizedBox(width: 14.w),
        GestureDetector(
          onTap: onAvatarTap,
          child: AvatarCircle(
            initials: name.isEmpty ? S().avatarFallback : name.substring(0, 1),
            size: 44.r,
          ),
        ),
      ],
    );
  }
}
