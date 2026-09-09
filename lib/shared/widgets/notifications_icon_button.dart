import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';

class NotificationsIconButton extends StatelessWidget {
  final Widget badge;
  final VoidCallback onTap;

  const NotificationsIconButton({
    super.key,
    required this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: 26.r,
            color: context.colorScheme.onSurface,
          ),
          Positioned(right: -4.w, top: -4.h, child: badge),
        ],
      ),
    );
  }
}
