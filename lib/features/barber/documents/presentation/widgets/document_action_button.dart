import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DocumentActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool emphasized;
  final bool danger;

  const DocumentActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.emphasized = false,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = _foreground(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: emphasized ? 0.16 : 0.08),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15.r, color: color),
              SizedBox(width: 5.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _foreground(BuildContext context) {
    if (danger) return context.semantic.warning;
    if (emphasized) return context.colorScheme.primary;
    return context.colorScheme.onSurfaceVariant;
  }
}
