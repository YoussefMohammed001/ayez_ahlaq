import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../core/theme/styles.dart';
import '../../../../../../core/widgets/app_card.dart';
import '../../../../../../core/widgets/custom_text.dart';

class SubHomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final VoidCallback? onTap;

  const SubHomeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.r, color: scheme.primary),
              SizedBox(width: 8.w),
              Expanded(child: AppText(title, style: font13w700)),
              if (onTap != null)
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.r,
                  color: scheme.onSurfaceVariant,
                ),
            ],
          ),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }
}
