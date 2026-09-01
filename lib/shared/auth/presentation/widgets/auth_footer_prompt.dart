import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/bouncing_widgets.dart';
import '../../../../core/extensions/ext_theme.dart';

class AuthFooterPrompt extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AuthFooterPrompt({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BounceIt(
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: context.semantic.accentStrong,
          ),
        ),
      ),
    );
  }
}
