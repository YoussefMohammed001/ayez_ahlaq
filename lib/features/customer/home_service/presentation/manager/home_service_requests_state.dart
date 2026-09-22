import 'package:equatable/equatable.dart';
import '../../domain/entities/home_service_request.dart';

enum HomeServiceRequestsStatus { initial, loading, success, failure }

class HomeServiceRequestsState extends Equatable {
  final HomeServiceRequestsStatus status;
  final List<HomeServiceRequest> requests;
  final String? errorMessage;

  const HomeServiceRequestsState({
    this.status = HomeServiceRequestsStatus.initial,
    this.requests = const [],
    this.errorMessage,
  });

  HomeServiceRequestsState copyWith({
    HomeServiceRequestsStatus? status,
    List<HomeServiceRequest>? requests,
    String? errorMessage,
  }) {
    return HomeServiceRequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, requests, errorMessage];
}
