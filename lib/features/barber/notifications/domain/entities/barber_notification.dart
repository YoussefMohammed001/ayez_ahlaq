import 'package:equatable/equatable.dart';
import 'notification_kind.dart';

class BarberNotification extends Equatable {
  final int id;
  final String type;
  final String? referenceType;
  final String? referenceId;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool seen;

  const BarberNotification({
    required this.id,
    required this.type,
    this.referenceType,
    this.referenceId,
    required this.title,
    required this.body,
    required this.createdAt,
    this.seen = false,
  });

  NotificationKind get kind => NotificationKind.fromType(type);

  BarberNotification copyWith({bool? seen}) {
    return BarberNotification(
      id: id,
      type: type,
      referenceType: referenceType,
      referenceId: referenceId,
      title: title,
      body: body,
      createdAt: createdAt,
      seen: seen ?? this.seen,
    );
  }

  @override
  List<Object?> get props => [id, type, title, body, createdAt, seen];
}
