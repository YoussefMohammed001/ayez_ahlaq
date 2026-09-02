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
      constraints: BoxConstraints(minWidth: 20.r),
      height: 20.r,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: font12w600.copyWith(
          color: context.colorScheme.surfaceContainerLowest,
        ),
      ),
    );
  }
}
