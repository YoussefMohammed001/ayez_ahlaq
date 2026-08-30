import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_profile.dart';

enum ProfileStatus { initial, loading, success, failure }

class MerchantProfileState extends Equatable {
  final ProfileStatus status;
  final MerchantProfile? profile;
  final String? errorMessage;
  final bool isSubmitting;

  const MerchantProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.errorMessage,
    this.isSubmitting = false,
  });

  MerchantProfileState copyWith({
    ProfileStatus? status,
    MerchantProfile? profile,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MerchantProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage, isSubmitting];
}
