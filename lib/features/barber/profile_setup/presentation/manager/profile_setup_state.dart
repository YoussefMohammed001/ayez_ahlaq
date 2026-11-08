import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_setup_progress.dart';
import '../../domain/entities/profile_setup_snapshot.dart';
import '../../domain/entities/profile_setup_step.dart';

enum ProfileSetupStatus { initial, loading, success, failure }

class ProfileSetupState extends Equatable {
  final ProfileSetupStatus status;
  final ProfileSetupSnapshot snapshot;
  final bool? hasPhoto;
  final bool started;
  final bool dismissed;

  const ProfileSetupState({
    this.status = ProfileSetupStatus.initial,
    this.snapshot = const ProfileSetupSnapshot.empty(),
    this.hasPhoto,
    this.started = false,
    this.dismissed = false,
  });

  bool get isReady => status == ProfileSetupStatus.success && hasPhoto != null;

  bool get hasFinishedLoading =>
      status == ProfileSetupStatus.success ||
      status == ProfileSetupStatus.failure;

  bool get requiredIncomplete => ProfileSetupStep.values.any(
    (step) => step.required && !snapshot.done.contains(step),
  );

  List<ProfileSetupStep> get visibleSteps => [
    for (final step in ProfileSetupStep.values)
      if (step.required || (started && _optionalIsVisible(step))) step,
  ];

  bool _optionalIsVisible(ProfileSetupStep step) =>
      !step.isTeamRelated || snapshot.teamKnown;

  bool isBlocked(ProfileSetupStep step) =>
      step.dependsOnTeam && !snapshot.hasTeam;

  ProfileSetupProgress get progress => ProfileSetupProgress(
    done: {...snapshot.done, if (hasPhoto == true) ProfileSetupStep.photo},
    steps: visibleSteps,
  );

  bool get shouldShowChecklist => isReady && !dismissed && !progress.isComplete;

  int? memberFor(ProfileSetupStep step) => switch (step) {
    ProfileSetupStep.teamHours => snapshot.memberNeedingHours,
    ProfileSetupStep.teamServices => snapshot.memberNeedingServices,
    _ => null,
  };

  ProfileSetupState copyWith({
    ProfileSetupStatus? status,
    ProfileSetupSnapshot? snapshot,
    bool? hasPhoto,
    bool? started,
    bool? dismissed,
  }) {
    return ProfileSetupState(
      status: status ?? this.status,
      snapshot: snapshot ?? this.snapshot,
      hasPhoto: hasPhoto ?? this.hasPhoto,
      started: started ?? this.started,
      dismissed: dismissed ?? this.dismissed,
    );
  }

  @override
  List<Object?> get props => [status, snapshot, hasPhoto, started, dismissed];
}
