import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_profile.dart';

enum CustomerProfileStatus { initial, loading, success, failure }

class CustomerProfileState extends Equatable {
  final CustomerProfileStatus status;
  final CustomerProfile? profile;
  final String? errorMessage;

  const CustomerProfileState({
    this.status = CustomerProfileStatus.initial,
    this.profile,
    this.errorMessage,
  });

  CustomerProfileState copyWith({
    CustomerProfileStatus? status,
    CustomerProfile? profile,
    String? errorMessage,
  }) {
    return CustomerProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage];
}
