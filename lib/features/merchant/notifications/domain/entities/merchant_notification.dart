import 'package:equatable/equatable.dart';
import 'notification_kind.dart';

class MerchantNotification extends Equatable {
  final int id;
  final NotificationKind kind;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool seen;

  const MerchantNotification({
    required this.id,
    required this.kind,
    required this.title,
    required this.body,
    required this.createdAt,
    this.seen = false,
  });

  MerchantNotification copyWith({bool? seen}) {
    return MerchantNotification(
      id: id,
      kind: kind,
      title: title,
      body: body,
      createdAt: createdAt,
      seen: seen ?? this.seen,
    );
  }

  @override
  List<Object?> get props => [id, kind, title, body, createdAt, seen];
}
