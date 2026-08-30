import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/strings.dart';
import '../../core/extensions/ext_theme.dart';

class AvatarCircle extends StatelessWidget {
  final String initials;
  final double? size;
  final Color? background;
  final Color? foreground;

  const AvatarCircle({
    super.key,
    required this.initials,
    this.size,
    this.background,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    final diameter = size ?? 56.r;
    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background ?? context.colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style: TextStyle(
          fontFamily: AppStrings.headingFontFamily,
          fontWeight: FontWeight.w800,
          fontSize: diameter * 0.36,
          color: foreground ?? context.colorScheme.surfaceContainerLowest,
        ),
      ),
    );
  }
}
