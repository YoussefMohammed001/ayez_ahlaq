import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/profile_setup_progress.dart';
import '../../domain/entities/profile_setup_step.dart';
import 'profile_setup_step_row.dart';

class ProfileSetupChecklist extends StatelessWidget {
  final ProfileSetupProgress progress;
  final bool Function(ProfileSetupStep step) isBlocked;
  final ValueChanged<ProfileSetupStep> onStepTap;
  final VoidCallback onStartTour;
  final VoidCallback onDismiss;

  const ProfileSetupChecklist({
    super.key,
    required this.progress,
    required this.isBlocked,
    required this.onStepTap,
    required this.onStartTour,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      borderColor: scheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S().setupChecklistTitle,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            S().setupChecklistProgress(progress.doneCount, progress.total),
            style: TextStyle(fontSize: 12.sp, color: scheme.onSurfaceVariant),
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress.fraction,
              minHeight: 6.h,
              backgroundColor: scheme.outline.withValues(alpha: 0.4),
            ),
          ),
          SizedBox(height: 6.h),
          for (final step in progress.steps)
            ProfileSetupStepRow(
              step: step,
              done: progress.isDone(step),
              blocked: isBlocked(step),
              onTap: () => onStepTap(step),
            ),
          Row(
            children: [
              Flexible(
                child: TextButton.icon(
                  onPressed: onStartTour,
                  icon: Icon(Icons.explore_outlined, size: 18.r),
                  label: Text(
                    S().setupStartTour,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              TextButton(
                onPressed: onDismiss,
                child: Text(
                  S().setupHide,
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
