import 'package:equatable/equatable.dart';
import '../../domain/entities/member_client.dart';

enum MemberClientsStatus { initial, loading, success, failure }

class MemberClientsState extends Equatable {
  final MemberClientsStatus status;
  final int? memberId;
  final DateTime from;
  final DateTime to;
  final List<MemberClient> clients;
  final String? errorMessage;

  MemberClientsState({
    this.status = MemberClientsStatus.initial,
    this.memberId,
    DateTime? from,
    DateTime? to,
    this.clients = const [],
    this.errorMessage,
  }) : from = from ?? DateTime.now().subtract(const Duration(days: 30)),
       to = to ?? DateTime.now();

  MemberClientsState copyWith({
    MemberClientsStatus? status,
    int? memberId,
    DateTime? from,
    DateTime? to,
    List<MemberClient>? clients,
    String? errorMessage,
  }) {
    return MemberClientsState(
      status: status ?? this.status,
      memberId: memberId ?? this.memberId,
      from: from ?? this.from,
      to: to ?? this.to,
      clients: clients ?? this.clients,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, memberId, from, to, clients, errorMessage];
}
