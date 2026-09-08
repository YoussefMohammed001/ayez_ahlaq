import '../../domain/entities/broadcast.dart';
import '../../domain/entities/broadcast_scope.dart';
import '../../domain/entities/broadcast_status.dart';

class BroadcastModel extends Broadcast {
  const BroadcastModel({
    required super.id,
    required super.scope,
    required super.title,
    required super.status,
    required super.recipientCount,
  });

  factory BroadcastModel.fromJson(Map<String, dynamic> json) {
    return BroadcastModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      scope: BroadcastScope.fromApi(json['scope'] as String?),
      title: json['title'] as String? ?? '',
      status: BroadcastStatus.fromApi(json['status'] as String?),
      recipientCount: (json['recipientCount'] as num?)?.toInt() ?? 0,
    );
  }
}
