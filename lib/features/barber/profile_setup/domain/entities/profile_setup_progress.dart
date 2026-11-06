import 'package:equatable/equatable.dart';
import 'profile_setup_step.dart';

class ProfileSetupProgress extends Equatable {
  final Set<ProfileSetupStep> done;

  const ProfileSetupProgress(this.done);

  int get total => ProfileSetupStep.values.length;

  int get doneCount => done.length;

  bool get isComplete => doneCount == total;

  double get fraction => doneCount / total;

  bool isDone(ProfileSetupStep step) => done.contains(step);

  ProfileSetupStep? get nextStep {
    for (final step in ProfileSetupStep.values) {
      if (!isDone(step)) return step;
    }
    return null;
  }

  @override
  List<Object?> get props => [done];
}
