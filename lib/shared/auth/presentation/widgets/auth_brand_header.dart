import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/heading_styles.dart';
import '../../../../core/extensions/ext_theme.dart';

class AuthBrandHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthBrandHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 76.r,
          height: 76.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.semantic.accentSoft,
                context.semantic.accentStrong,
              ],
            ),
          ),
          child: Icon(
            Icons.content_cut_rounded,
            size: 34.r,
            color: context.semantic.onAccent,
          ),
        ),
        SizedBox(height: 16.h),
        Text(title, textAlign: TextAlign.center, style: HeadingStyles.h1),
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
