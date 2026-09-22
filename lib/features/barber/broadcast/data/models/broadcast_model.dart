import '../../domain/entities/broadcast.dart';
import '../../domain/entities/broadcast_scope.dart';
import '../../domain/entities/broadcast_status.dart';

class BroadcastModel extends Broadcast {
  const BroadcastModel({
    required super.id,
    required super.scope,
    required super.title,
    required super.body,
    required super.status,
    required super.recipientCount,
    super.decisionNote,
    super.decidedAt,
    super.sentAt,
    super.createdAt,
  });

  factory BroadcastModel.fromJson(Map<String, dynamic> json) {
    return BroadcastModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      scope: BroadcastScope.fromApi(json['scope'] as String?),
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      status: BroadcastStatus.fromApi(json['status'] as String?),
      recipientCount: (json['recipientCount'] as num?)?.toInt() ?? 0,
      decisionNote: json['decisionNote'] as String?,
      decidedAt: DateTime.tryParse(json['decidedAt'] as String? ?? ''),
      sentAt: DateTime.tryParse(json['sentAt'] as String? ?? ''),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }
}
