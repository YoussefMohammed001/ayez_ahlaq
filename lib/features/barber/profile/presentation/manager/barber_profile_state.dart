import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import '../../domain/entities/barber_profile.dart';

enum BarberProfileStatus { initial, loading, success, failure }

enum ProfileImageStatus { initial, loading, loaded, empty, submitting }

class BarberProfileState extends Equatable {
  final BarberProfileStatus status;
  final BarberProfile? profile;
  final String? errorMessage;
  final bool isSubmitting;
  final ProfileImageStatus imageStatus;
  final Uint8List? profileImageBytes;

  const BarberProfileState({
    this.status = BarberProfileStatus.initial,
    this.profile,
    this.errorMessage,
    this.isSubmitting = false,
    this.imageStatus = ProfileImageStatus.initial,
    this.profileImageBytes,
  });

  BarberProfileState copyWith({
    BarberProfileStatus? status,
    BarberProfile? profile,
    String? errorMessage,
    bool? isSubmitting,
    ProfileImageStatus? imageStatus,
    Uint8List? profileImageBytes,
  }) {
    return BarberProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      imageStatus: imageStatus ?? this.imageStatus,
      profileImageBytes: profileImageBytes ?? this.profileImageBytes,
    );
  }

  BarberProfileState clearProfileImage() {
    return BarberProfileState(
      status: status,
      profile: profile,
      isSubmitting: isSubmitting,
      imageStatus: ProfileImageStatus.empty,
    );
  }

  @override
  List<Object?> get props => [
    status,
    profile,
    errorMessage,
    isSubmitting,
    imageStatus,
    profileImageBytes,
  ];
}
