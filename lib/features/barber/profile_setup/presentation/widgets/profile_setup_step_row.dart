import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../domain/entities/profile_setup_step.dart';
import 'profile_setup_step_view.dart';

class ProfileSetupStepRow extends StatelessWidget {
  final ProfileSetupStep step;
  final bool done;
  final VoidCallback onTap;

  const ProfileSetupStepRow({
    super.key,
    required this.step,
    required this.done,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final accent = done ? context.semantic.success : scheme.primary;

    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: done ? null : onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 34.r,
              height: 34.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                done ? Icons.check_rounded : step.icon,
                size: 18.r,
                color: accent,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: done ? scheme.onSurfaceVariant : scheme.onSurface,
                    ),
                  ),
                  if (!done) ...[
                    SizedBox(height: 2.h),
                    Text(
                      step.hint,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!done)
              Icon(
                Icons.chevron_right,
                size: 20.r,
                color: scheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}
