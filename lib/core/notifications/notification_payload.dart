class NotificationPayload {
  final String type;
  final String? typeId;
  final String? referenceType;

  const NotificationPayload({
    required this.type,
    this.typeId,
    this.referenceType,
  });

  factory NotificationPayload.fromMap(Map<dynamic, dynamic> data) {
    final id =
        data['referenceId'] ??
        data['reference_id'] ??
        data['type_id'] ??
        data['typeId'] ??
        data['notificationTypeId'] ??
        data['notification_type_id'];
    final reference = data['referenceType'] ?? data['reference_type'];
    return NotificationPayload(
      type: _nonEmpty(
            data['type'] ??
                data['notificationType'] ??
                data['notification_type'],
          ) ??
          '',
      typeId: _nonEmpty(id),
      referenceType: _nonEmpty(reference),
    );
  }

  static String? _nonEmpty(Object? value) {
    final text = value?.toString();
    return text == null || text.isEmpty ? null : text;
  }
}
