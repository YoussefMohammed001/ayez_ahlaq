import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../profile/presentation/widgets/barber_shop_photo_picker.dart';
import '../../domain/entities/profile_setup_step.dart';

class ProfileSetupStepRouter {
  const ProfileSetupStepRouter._();

  static Future<void> open(
    BuildContext context,
    ProfileSetupStep step, {
    int? memberId,
  }) async {
    switch (step) {
      case ProfileSetupStep.hours:
        await context.push(Routes.barberHoursScreen);
      case ProfileSetupStep.services:
        await context.push(Routes.barberServicesScreen);
      case ProfileSetupStep.photo:
        await BarberShopPhotoPicker.pickAndUpload(context);
      case ProfileSetupStep.team:
        await context.push(Routes.barberTeamScreen);
      case ProfileSetupStep.teamHours:
      case ProfileSetupStep.teamServices:
        await _openMember(context, memberId);
    }
  }

  static Future<void> _openMember(BuildContext context, int? memberId) {
    return memberId == null
        ? context.push(Routes.barberTeamScreen)
        : context.push(Routes.barberTeamMemberDetailScreen, extra: memberId);
  }
}
