import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';
import '../../core/theme/styles.dart';

class CountBadge extends StatelessWidget {
  final int count;
  final Color? color;

  const CountBadge({super.key, required this.count, this.color});

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    final background = color ?? context.colorScheme.error;

    return Container(
      constraints: BoxConstraints(minWidth: 16.r, minHeight: 16.r),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Text(
          count > 99 ? '99+' : '$count',
          style: font10w600.copyWith(
            color: context.colorScheme.surfaceContainerLowest,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}
