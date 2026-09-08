import 'package:equatable/equatable.dart';
import 'broadcast_scope.dart';
import 'broadcast_status.dart';

class Broadcast extends Equatable {
  final int id;
  final BroadcastScope scope;
  final String title;
  final BroadcastStatus status;
  final int recipientCount;

  const Broadcast({
    required this.id,
    required this.scope,
    required this.title,
    required this.status,
    required this.recipientCount,
  });

  @override
  List<Object?> get props => [id, scope, title, status, recipientCount];
}
