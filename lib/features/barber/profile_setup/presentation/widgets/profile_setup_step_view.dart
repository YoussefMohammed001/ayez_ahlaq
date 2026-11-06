import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/profile_setup_step.dart';

extension ProfileSetupStepView on ProfileSetupStep {
  IconData get icon => switch (this) {
    ProfileSetupStep.hours => Icons.schedule_rounded,
    ProfileSetupStep.services => Icons.content_cut_rounded,
    ProfileSetupStep.photo => Icons.add_a_photo_outlined,
    ProfileSetupStep.documents => Icons.folder_outlined,
  };

  String get title => switch (this) {
    ProfileSetupStep.hours => S().setupStepHoursTitle,
    ProfileSetupStep.services => S().setupStepServicesTitle,
    ProfileSetupStep.photo => S().setupStepPhotoTitle,
    ProfileSetupStep.documents => S().setupStepDocumentsTitle,
  };

  String get hint => switch (this) {
    ProfileSetupStep.hours => S().setupStepHoursHint,
    ProfileSetupStep.services => S().setupStepServicesHint,
    ProfileSetupStep.photo => S().setupStepPhotoHint,
    ProfileSetupStep.documents => S().setupStepDocumentsHint,
  };
}
