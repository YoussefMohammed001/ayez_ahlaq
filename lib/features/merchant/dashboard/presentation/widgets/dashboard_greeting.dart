import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardGreeting extends StatelessWidget {
  final String businessName;

  const DashboardGreeting({super.key, required this.businessName});

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
                businessName,
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
        AvatarCircle(
          initials: businessName.isEmpty
              ? S().avatarFallback
              : businessName.substring(0, 1),
          size: 44.r,
        ),
      ],
    );
  }
}
