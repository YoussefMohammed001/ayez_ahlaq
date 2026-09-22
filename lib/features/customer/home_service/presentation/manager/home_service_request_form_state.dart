import 'package:equatable/equatable.dart';

enum HomeServiceRequestFormStatus { initial, submitting, success, failure }

class HomeServiceRequestFormState extends Equatable {
  final HomeServiceRequestFormStatus status;
  final int? createdRequestId;
  final String? errorMessage;

  const HomeServiceRequestFormState({
    this.status = HomeServiceRequestFormStatus.initial,
    this.createdRequestId,
    this.errorMessage,
  });

  HomeServiceRequestFormState copyWith({
    HomeServiceRequestFormStatus? status,
    int? createdRequestId,
    String? errorMessage,
  }) {
    return HomeServiceRequestFormState(
      status: status ?? this.status,
      createdRequestId: createdRequestId ?? this.createdRequestId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, createdRequestId, errorMessage];
}
