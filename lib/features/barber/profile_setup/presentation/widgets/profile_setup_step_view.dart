import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/profile_setup_step.dart';

extension ProfileSetupStepView on ProfileSetupStep {
  IconData get icon => switch (this) {
    ProfileSetupStep.hours => Icons.schedule_rounded,
    ProfileSetupStep.services => Icons.content_cut_rounded,
    ProfileSetupStep.photo => Icons.add_a_photo_outlined,
    ProfileSetupStep.team => Icons.group_add_outlined,
    ProfileSetupStep.teamHours => Icons.more_time_rounded,
    ProfileSetupStep.teamServices => Icons.design_services_outlined,
  };

  String get title => switch (this) {
    ProfileSetupStep.hours => S().setupStepHoursTitle,
    ProfileSetupStep.services => S().setupStepServicesTitle,
    ProfileSetupStep.photo => S().setupStepPhotoTitle,
    ProfileSetupStep.team => S().setupStepTeamTitle,
    ProfileSetupStep.teamHours => S().setupStepTeamHoursTitle,
    ProfileSetupStep.teamServices => S().setupStepTeamServicesTitle,
  };

  String get hint => switch (this) {
    ProfileSetupStep.hours => S().setupStepHoursHint,
    ProfileSetupStep.services => S().setupStepServicesHint,
    ProfileSetupStep.photo => S().setupStepPhotoHint,
    ProfileSetupStep.team => S().setupStepTeamHint,
    ProfileSetupStep.teamHours => S().setupStepTeamHoursHint,
    ProfileSetupStep.teamServices => S().setupStepTeamServicesHint,
  };
}
