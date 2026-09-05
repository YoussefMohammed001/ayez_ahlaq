import 'package:equatable/equatable.dart';
import '../../domain/entities/subscription_request.dart';

enum BarberSubscriptionRequestsStatus { initial, loading, success, failure }

class BarberSubscriptionRequestsState extends Equatable {
  final BarberSubscriptionRequestsStatus status;
  final List<SubscriptionRequest> requests;
  final String? errorMessage;

  const BarberSubscriptionRequestsState({
    this.status = BarberSubscriptionRequestsStatus.initial,
    this.requests = const [],
    this.errorMessage,
  });

  BarberSubscriptionRequestsState copyWith({
    BarberSubscriptionRequestsStatus? status,
    List<SubscriptionRequest>? requests,
    String? errorMessage,
  }) {
    return BarberSubscriptionRequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, requests, errorMessage];
}
