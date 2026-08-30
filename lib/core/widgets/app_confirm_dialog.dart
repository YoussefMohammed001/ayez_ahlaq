import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../generated/l10n.dart';
import '../theme/heading_styles.dart';
import '../../core/extensions/ext_theme.dart';

class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmLabel;
  final String? cancelLabel;
  final IconData icon;
  final bool isDestructive;

  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel,
    this.cancelLabel,
    this.icon = Icons.help_outline_rounded,
    this.isDestructive = true,
  });

  @override
  Widget build(BuildContext context) {
    final accent = isDestructive
        ? context.semantic.warning
        : context.colorScheme.primary;

    return Dialog(
      backgroundColor: context.colorScheme.surfaceContainer,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: context.colorScheme.outline),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56.r,
              height: 56.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 26.r, color: accent),
            ),
            SizedBox(height: 16.h),
            Text(title, textAlign: TextAlign.center, style: HeadingStyles.h5),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5.sp,
                color: context.colorScheme.onSurfaceVariant,
                height: 1.7,
              ),
            ),
            SizedBox(height: 22.h),
            Row(
              children: [
                Expanded(child: _buildCancel(context)),
                SizedBox(width: 10.w),
                Expanded(child: _buildConfirm(context, accent)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancel(BuildContext context) {
    return SizedBox(
      height: 46.h,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: context.colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: context.colorScheme.outline),
          ),
        ),
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(
          cancelLabel ?? S().cancel,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirm(BuildContext context, Color accent) {
    return SizedBox(
      height: 46.h,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(
          confirmLabel ?? S().confirm,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: isDestructive
                ? context.colorScheme.onSurface
                : context.colorScheme.surfaceContainerLowest,
          ),
        ),
      ),
    );
  }
}
