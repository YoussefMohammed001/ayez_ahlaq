import 'package:equatable/equatable.dart';
import 'profile_setup_step.dart';

class ProfileSetupProgress extends Equatable {
  final Set<ProfileSetupStep> done;
  final List<ProfileSetupStep> steps;

  const ProfileSetupProgress({required this.done, required this.steps});

  int get total => steps.length;

  int get doneCount => steps.where(done.contains).length;

  bool get isComplete => doneCount == total;

  double get fraction => total == 0 ? 1 : doneCount / total;

  bool isDone(ProfileSetupStep step) => done.contains(step);

  @override
  List<Object?> get props => [done, steps];
}
