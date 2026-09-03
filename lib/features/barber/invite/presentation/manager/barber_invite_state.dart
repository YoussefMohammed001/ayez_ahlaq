import 'package:equatable/equatable.dart';
import '../../domain/entities/barber_invite.dart';

enum BarberInviteStatus { initial, loading, success, failure }

class BarberInviteState extends Equatable {
  final BarberInviteStatus status;
  final BarberInvite? invite;
  final bool isRegenerating;
  final String? errorMessage;

  const BarberInviteState({
    this.status = BarberInviteStatus.initial,
    this.invite,
    this.isRegenerating = false,
    this.errorMessage,
  });

  BarberInviteState copyWith({
    BarberInviteStatus? status,
    BarberInvite? invite,
    bool? isRegenerating,
    String? errorMessage,
  }) {
    return BarberInviteState(
      status: status ?? this.status,
      invite: invite ?? this.invite,
      isRegenerating: isRegenerating ?? this.isRegenerating,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, invite, isRegenerating, errorMessage];
}
