import 'package:equatable/equatable.dart';

enum BarberBroadcastStatus { initial, sending, success, failure }

enum BarberBroadcastScope { all, mine }

class BarberBroadcastState extends Equatable {
  final BarberBroadcastStatus status;
  final BarberBroadcastScope scope;
  final String? errorMessage;

  const BarberBroadcastState({
    this.status = BarberBroadcastStatus.initial,
    this.scope = BarberBroadcastScope.all,
    this.errorMessage,
  });

  BarberBroadcastState copyWith({
    BarberBroadcastStatus? status,
    BarberBroadcastScope? scope,
    String? errorMessage,
  }) {
    return BarberBroadcastState(
      status: status ?? this.status,
      scope: scope ?? this.scope,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, scope, errorMessage];
}
