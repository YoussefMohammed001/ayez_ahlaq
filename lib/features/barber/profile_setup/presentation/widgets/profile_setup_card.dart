import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/tour/tour_target.dart';
import '../../domain/entities/profile_setup_step.dart';
import '../manager/profile_setup_cubit.dart';
import '../manager/profile_setup_state.dart';
import 'profile_setup_checklist.dart';
import 'profile_setup_local_sync.dart';
import 'profile_setup_step_router.dart';

class ProfileSetupCard extends StatelessWidget {
  final VoidCallback onStartTour;
  final GlobalKey? tourKey;

  const ProfileSetupCard({super.key, required this.onStartTour, this.tourKey});

  Widget _withTour(Widget card) {
    final key = tourKey;
    if (key == null) return card;
    return TourTarget(
      tourKey: key,
      title: S().tourChecklistTitle,
      description: S().tourChecklistBody,
      child: card,
    );
  }

  Future<void> _open(BuildContext context, ProfileSetupStep step) async {
    final cubit = context.read<ProfileSetupCubit>();
    await ProfileSetupStepRouter.open(context, step);
    await cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileSetupLocalSync(
      child: BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
        builder: (context, state) {
          if (!state.shouldShowChecklist) return const SizedBox.shrink();

          return Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: _withTour(
              ProfileSetupChecklist(
                progress: state.progress,
                onStepTap: (step) => _open(context, step),
                onStartTour: onStartTour,
              ),
            ),
          );
        },
      ),
    );
  }
}
