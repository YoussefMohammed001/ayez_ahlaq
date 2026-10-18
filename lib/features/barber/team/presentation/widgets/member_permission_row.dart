import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/toggle_switch.dart';

class MemberPermissionRow extends StatelessWidget {
  final String title;
  final String hint;
  final bool value;
  final bool enabled;
  final VoidCallback onTap;

  const MemberPermissionRow({
    super.key,
    required this.title,
    required this.hint,
    required this.value,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    hint,
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      height: 1.5,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            IgnorePointer(
              ignoring: !enabled,
              child: ToggleSwitch(value: value, onTap: onTap),
            ),
          ],
        ),
      ),
    );
  }
}
