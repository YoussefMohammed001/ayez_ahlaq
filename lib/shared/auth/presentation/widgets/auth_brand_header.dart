import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/heading_styles.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../core/widgets/app_asset.dart';
import '../../../../core/widgets/badge_tone.dart';
import '../../../../core/widgets/status_badge.dart';

class AuthBrandHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? accountTypeLabel;

  const AuthBrandHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.accountTypeLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: AppAsset(
            assetName: 'app_icon',
            fileExtension: 'png',
            width: 76.r,
            height: 76.r,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16.h),
        Text(title, textAlign: TextAlign.center, style: HeadingStyles.h1),
        if (accountTypeLabel != null) ...[
          SizedBox(height: 8.h),
          StatusBadge(
            label: accountTypeLabel!,
            tone: BadgeTone.gold,
            showDot: false,
          ),
        ],
        SizedBox(height: 8.h),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.5.sp,
            color: context.colorScheme.onSurfaceVariant,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}
