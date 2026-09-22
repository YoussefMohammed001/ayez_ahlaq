import 'package:equatable/equatable.dart';
import '../../domain/entities/home_service_request.dart';

enum HomeServiceRequestsStatus { initial, loading, success, failure }

class HomeServiceRequestsState extends Equatable {
  final HomeServiceRequestsStatus status;
  final List<HomeServiceRequest> requests;
  final String? errorMessage;
  final int? updatingRequestId;

  const HomeServiceRequestsState({
    this.status = HomeServiceRequestsStatus.initial,
    this.requests = const [],
    this.errorMessage,
    this.updatingRequestId,
  });

  HomeServiceRequestsState copyWith({
    HomeServiceRequestsStatus? status,
    List<HomeServiceRequest>? requests,
    String? errorMessage,
    int? updatingRequestId,
    bool clearUpdatingRequestId = false,
  }) {
    return HomeServiceRequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      errorMessage: errorMessage,
      updatingRequestId: clearUpdatingRequestId
          ? null
          : (updatingRequestId ?? this.updatingRequestId),
    );
  }

  @override
  List<Object?> get props => [status, requests, errorMessage, updatingRequestId];
}
