import 'package:equatable/equatable.dart';
import 'broadcast_scope.dart';
import 'broadcast_status.dart';

class Broadcast extends Equatable {
  final int id;
  final BroadcastScope scope;
  final String title;
  final String body;
  final BroadcastStatus status;
  final int recipientCount;
  final String? decisionNote;
  final DateTime? decidedAt;
  final DateTime? sentAt;
  final DateTime? createdAt;

  const Broadcast({
    required this.id,
    required this.scope,
    required this.title,
    required this.body,
    required this.status,
    required this.recipientCount,
    this.decisionNote,
    this.decidedAt,
    this.sentAt,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    scope,
    title,
    body,
    status,
    recipientCount,
    decisionNote,
    decidedAt,
    sentAt,
    createdAt,
  ];
}
