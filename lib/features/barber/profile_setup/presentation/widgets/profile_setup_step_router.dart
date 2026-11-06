import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../profile/presentation/widgets/barber_shop_photo_picker.dart';
import '../../domain/entities/profile_setup_step.dart';

class ProfileSetupStepRouter {
  const ProfileSetupStepRouter._();

  static Future<void> open(BuildContext context, ProfileSetupStep step) async {
    switch (step) {
      case ProfileSetupStep.hours:
        await context.push(Routes.barberHoursScreen);
      case ProfileSetupStep.services:
        await context.push(Routes.barberServicesScreen);
      case ProfileSetupStep.documents:
        await context.push(Routes.barberDocumentsScreen);
      case ProfileSetupStep.photo:
        await BarberShopPhotoPicker.pickAndUpload(context);
    }
  }
}
