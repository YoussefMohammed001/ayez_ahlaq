import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class HomeServiceCancelButton extends StatelessWidget {
  final bool isCancelling;
  final VoidCallback onPressed;

  const HomeServiceCancelButton({
    super.key,
    required this.isCancelling,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.semantic.warning,
        foregroundColor: context.colorScheme.surfaceContainerLowest,
        minimumSize: Size.fromHeight(52.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      onPressed: isCancelling ? null : onPressed,
      child: isCancelling
          ? SizedBox(
              width: 22.r,
              height: 22.r,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: context.colorScheme.surfaceContainerLowest,
              ),
            )
          : Text(
              S().homeServiceCancelRequest,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
            ),
    );
  }
}
