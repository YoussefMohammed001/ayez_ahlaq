import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_setup_progress.dart';
import '../../domain/entities/profile_setup_step.dart';

enum ProfileSetupStatus { initial, loading, success, failure }

class ProfileSetupState extends Equatable {
  final ProfileSetupStatus status;
  final Set<ProfileSetupStep> remoteDone;
  final bool? hasPhoto;
  final bool? documentsComplete;

  const ProfileSetupState({
    this.status = ProfileSetupStatus.initial,
    this.remoteDone = const {},
    this.hasPhoto,
    this.documentsComplete,
  });

  bool get isReady =>
      status == ProfileSetupStatus.success &&
      hasPhoto != null &&
      documentsComplete != null;

  ProfileSetupProgress get progress => ProfileSetupProgress({
    ...remoteDone,
    if (hasPhoto == true) ProfileSetupStep.photo,
    if (documentsComplete == true) ProfileSetupStep.documents,
  });

  bool get shouldShowChecklist => isReady && !progress.isComplete;

  ProfileSetupState copyWith({
    ProfileSetupStatus? status,
    Set<ProfileSetupStep>? remoteDone,
    bool? hasPhoto,
    bool? documentsComplete,
  }) {
    return ProfileSetupState(
      status: status ?? this.status,
      remoteDone: remoteDone ?? this.remoteDone,
      hasPhoto: hasPhoto ?? this.hasPhoto,
      documentsComplete: documentsComplete ?? this.documentsComplete,
    );
  }

  @override
  List<Object?> get props => [status, remoteDone, hasPhoto, documentsComplete];
}
