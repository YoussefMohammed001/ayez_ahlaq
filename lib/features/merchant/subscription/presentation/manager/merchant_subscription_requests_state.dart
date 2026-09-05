import 'package:equatable/equatable.dart';
import '../../domain/entities/subscription_request.dart';

enum MerchantSubscriptionRequestsStatus { initial, loading, success, failure }

class MerchantSubscriptionRequestsState extends Equatable {
  final MerchantSubscriptionRequestsStatus status;
  final List<SubscriptionRequest> requests;
  final String? errorMessage;

  const MerchantSubscriptionRequestsState({
    this.status = MerchantSubscriptionRequestsStatus.initial,
    this.requests = const [],
    this.errorMessage,
  });

  MerchantSubscriptionRequestsState copyWith({
    MerchantSubscriptionRequestsStatus? status,
    List<SubscriptionRequest>? requests,
    String? errorMessage,
  }) {
    return MerchantSubscriptionRequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, requests, errorMessage];
}
