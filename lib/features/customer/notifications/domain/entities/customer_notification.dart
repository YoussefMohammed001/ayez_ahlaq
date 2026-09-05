import 'package:equatable/equatable.dart';
import 'customer_notification_kind.dart';

class CustomerNotification extends Equatable {
  final int id;
  final String type;
  final String? referenceType;
  final String? referenceId;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool seen;

  const CustomerNotification({
    required this.id,
    required this.type,
    this.referenceType,
    this.referenceId,
    required this.title,
    required this.body,
    required this.createdAt,
    this.seen = false,
  });

  CustomerNotificationKind get kind => CustomerNotificationKind.fromType(type);

  CustomerNotification copyWith({bool? seen}) {
    return CustomerNotification(
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
