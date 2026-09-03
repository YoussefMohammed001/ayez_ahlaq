import '../../domain/entities/barber_notification.dart';

class BarberNotificationModel extends BarberNotification {
  const BarberNotificationModel({
    required super.id,
    required super.type,
    super.referenceType,
    super.referenceId,
    required super.title,
    required super.body,
    required super.createdAt,
    super.seen,
  });

  factory BarberNotificationModel.fromJson(Map<String, dynamic> json) {
    return BarberNotificationModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      type: json['type'] as String? ?? '',
      referenceType: json['referenceType'] as String?,
      referenceId: json['referenceId']?.toString(),
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      seen: json['seen'] as bool? ?? false,
    );
  }
}
