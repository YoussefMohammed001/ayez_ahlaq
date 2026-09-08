import 'package:equatable/equatable.dart';
import 'sponsorship.dart';

enum SponsorshipStatus { initial, loading, success, failure }

class SponsorshipState extends Equatable {
  final SponsorshipStatus status;
  final Sponsorship? sponsorship;
  final String? errorMessage;
  final bool isSubmitting;

  const SponsorshipState({
    this.status = SponsorshipStatus.initial,
    this.sponsorship,
    this.errorMessage,
    this.isSubmitting = false,
  });

  SponsorshipState copyWith({
    SponsorshipStatus? status,
    Sponsorship? sponsorship,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return SponsorshipState(
      status: status ?? this.status,
      sponsorship: sponsorship ?? this.sponsorship,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, sponsorship, errorMessage, isSubmitting];
}
