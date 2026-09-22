import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';

class ChangeAccountTypeButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ChangeAccountTypeButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: context.colorScheme.outlineVariant, height: 1),
        SizedBox(height: 18.h),
        OutlinedButton.icon(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(48.h),
            foregroundColor: context.semantic.accentStrong,
            side: BorderSide(color: context.semantic.accentStrong),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          icon: Icon(Icons.swap_horiz_rounded, size: 18.r),
          label: Text(
            label,
            style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
