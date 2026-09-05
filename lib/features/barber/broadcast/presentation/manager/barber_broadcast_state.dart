import 'package:equatable/equatable.dart';

enum BarberBroadcastStatus { initial, sending, success, failure }

class BarberBroadcastState extends Equatable {
  final BarberBroadcastStatus status;
  final String? errorMessage;

  const BarberBroadcastState({
    this.status = BarberBroadcastStatus.initial,
    this.errorMessage,
  });

  BarberBroadcastState copyWith({
    BarberBroadcastStatus? status,
    String? errorMessage,
  }) {
    return BarberBroadcastState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
