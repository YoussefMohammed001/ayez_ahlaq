import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_profile.dart';

enum CustomerProfileStatus { initial, loading, success, failure }

class CustomerProfileState extends Equatable {
  final CustomerProfileStatus status;
  final CustomerProfile? profile;
  final String? errorMessage;
  final bool isSubmitting;

  const CustomerProfileState({
    this.status = CustomerProfileStatus.initial,
    this.profile,
    this.errorMessage,
    this.isSubmitting = false,
  });

  CustomerProfileState copyWith({
    CustomerProfileStatus? status,
    CustomerProfile? profile,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return CustomerProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage, isSubmitting];
}
