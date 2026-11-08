import 'package:equatable/equatable.dart';
import 'profile_setup_step.dart';

class ProfileSetupSnapshot extends Equatable {
  final Set<ProfileSetupStep> done;
  final bool teamKnown;
  final bool hasTeam;
  final int? memberNeedingHours;
  final int? memberNeedingServices;

  const ProfileSetupSnapshot({
    required this.done,
    this.teamKnown = false,
    this.hasTeam = false,
    this.memberNeedingHours,
    this.memberNeedingServices,
  });

  const ProfileSetupSnapshot.empty()
    : done = const {},
      teamKnown = false,
      hasTeam = false,
      memberNeedingHours = null,
      memberNeedingServices = null;

  @override
  List<Object?> get props => [
    done,
    teamKnown,
    hasTeam,
    memberNeedingHours,
    memberNeedingServices,
  ];
}
