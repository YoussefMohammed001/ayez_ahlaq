import 'package:equatable/equatable.dart';
import '../../domain/entities/barber_profile.dart';

enum BarberProfileStatus { initial, loading, success, failure }

class BarberProfileState extends Equatable {
  final BarberProfileStatus status;
  final BarberProfile? profile;
  final String? errorMessage;
  final bool isSubmitting;

  const BarberProfileState({
    this.status = BarberProfileStatus.initial,
    this.profile,
    this.errorMessage,
    this.isSubmitting = false,
  });

  BarberProfileState copyWith({
    BarberProfileStatus? status,
    BarberProfile? profile,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return BarberProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage, isSubmitting];
}
