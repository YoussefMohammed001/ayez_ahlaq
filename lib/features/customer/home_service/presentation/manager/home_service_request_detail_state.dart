import 'package:equatable/equatable.dart';
import '../../domain/entities/home_service_request.dart';

enum HomeServiceRequestDetailStatus { initial, loading, success, failure }

class HomeServiceRequestDetailState extends Equatable {
  final HomeServiceRequestDetailStatus status;
  final HomeServiceRequest? request;
  final bool isConfirmingPrice;
  final bool isCancelling;
  final String? errorMessage;

  const HomeServiceRequestDetailState({
    this.status = HomeServiceRequestDetailStatus.initial,
    this.request,
    this.isConfirmingPrice = false,
    this.isCancelling = false,
    this.errorMessage,
  });

  HomeServiceRequestDetailState copyWith({
    HomeServiceRequestDetailStatus? status,
    HomeServiceRequest? request,
    bool? isConfirmingPrice,
    bool? isCancelling,
    String? errorMessage,
  }) {
    return HomeServiceRequestDetailState(
      status: status ?? this.status,
      request: request ?? this.request,
      isConfirmingPrice: isConfirmingPrice ?? this.isConfirmingPrice,
      isCancelling: isCancelling ?? this.isCancelling,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    request,
    isConfirmingPrice,
    isCancelling,
    errorMessage,
  ];
}
