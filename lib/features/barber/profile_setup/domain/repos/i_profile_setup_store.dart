import '../entities/profile_setup_step.dart';

abstract class IProfileSetupStore {
  Set<ProfileSetupStep> doneSteps(int ownerId);

  Future<void> saveDoneSteps(int ownerId, Set<ProfileSetupStep> steps);

  bool isDismissed(int ownerId);

  Future<void> dismiss(int ownerId);
}
