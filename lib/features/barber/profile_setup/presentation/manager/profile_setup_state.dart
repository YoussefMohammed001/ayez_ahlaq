import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_setup_progress.dart';
import '../../domain/entities/profile_setup_snapshot.dart';
import '../../domain/entities/profile_setup_step.dart';

enum ProfileSetupStatus { initial, loading, success, failure }

class ProfileSetupState extends Equatable {
  final ProfileSetupStatus status;
  final ProfileSetupSnapshot snapshot;
  final int? ownerId;
  final bool? hasPhoto;
  final bool dismissed;

  const ProfileSetupState({
    this.status = ProfileSetupStatus.initial,
    this.snapshot = const ProfileSetupSnapshot.empty(),
    this.ownerId,
    this.hasPhoto,
    this.dismissed = false,
  });

  bool get isReady => status == ProfileSetupStatus.success && hasPhoto != null;

  bool get hasFinishedLoading =>
      status == ProfileSetupStatus.success ||
      status == ProfileSetupStatus.failure;

  Set<ProfileSetupStep> get doneSteps => {
    ...snapshot.done,
    if (hasPhoto == true) ProfileSetupStep.photo,
  };

  List<ProfileSetupStep> get visibleSteps => [
    for (final step in ProfileSetupStep.values)
      if (!step.isTeamRelated || snapshot.teamKnown) step,
  ];

  bool isBlocked(ProfileSetupStep step) =>
      step.dependsOnTeam && !snapshot.hasTeam;

  ProfileSetupProgress get progress =>
      ProfileSetupProgress(done: doneSteps, steps: visibleSteps);

  bool get shouldShowChecklist => isReady && !dismissed && !progress.isComplete;

  int? memberFor(ProfileSetupStep step) => switch (step) {
    ProfileSetupStep.teamHours => snapshot.memberNeedingHours,
    ProfileSetupStep.teamServices => snapshot.memberNeedingServices,
    _ => null,
  };

  ProfileSetupState copyWith({
    ProfileSetupStatus? status,
    ProfileSetupSnapshot? snapshot,
    int? ownerId,
    bool? hasPhoto,
    bool? dismissed,
  }) {
    return ProfileSetupState(
      status: status ?? this.status,
      snapshot: snapshot ?? this.snapshot,
      ownerId: ownerId ?? this.ownerId,
      hasPhoto: hasPhoto ?? this.hasPhoto,
      dismissed: dismissed ?? this.dismissed,
    );
  }

  @override
  List<Object?> get props => [status, snapshot, ownerId, hasPhoto, dismissed];
}
