import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/heading_styles.dart';
import 'primary_cta_button.dart';
import '../../core/extensions/ext_theme.dart';

class AppStateView extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool compact;

  const AppStateView({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 56.r : 84.r,
          height: compact ? 56.r : 84.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: compact ? 26.r : 38.r, color: iconColor),
        ),
        SizedBox(height: compact ? 12.h : 18.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: compact
              ? HeadingStyles.h5
              : HeadingStyles.h4.copyWith(color: context.colorScheme.onSurface),
        ),
        if (message != null && message!.isNotEmpty) ...[
          SizedBox(height: 6.h),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5.sp,
              color: context.colorScheme.onSurfaceVariant,
              height: 1.7,
            ),
          ),
        ],
        if (actionLabel != null && onAction != null) ...[
          SizedBox(height: 20.h),
          SizedBox(
            width: 180.w,
            child: PrimaryCtaButton(label: actionLabel!, onPressed: onAction),
          ),
        ],
      ],
    );

    final padded = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: compact ? 24.h : 40.h,
      ),
      child: content,
    );

    return compact ? padded : Center(child: padded);
  }
}
