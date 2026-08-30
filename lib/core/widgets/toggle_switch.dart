import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';

class ToggleSwitch extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;

  const ToggleSwitch({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 44.w,
        height: 26.h,
        padding: EdgeInsets.all(2.r),
        alignment: value ? Alignment.centerLeft : Alignment.centerRight,
        decoration: BoxDecoration(
          color: value ? context.semantic.success : context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: value ? context.semantic.success : context.colorScheme.outline,
          ),
        ),
        child: Container(
          width: 20.r,
          height: 20.r,
          decoration: BoxDecoration(
            color: value ? context.colorScheme.onPrimary : context.colorScheme.onSurfaceVariant,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
