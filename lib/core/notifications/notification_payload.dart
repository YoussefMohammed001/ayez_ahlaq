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
        data['typeId'];
    final reference = data['referenceType'] ?? data['reference_type'];
    return NotificationPayload(
      type: data['type'] as String? ?? '',
      typeId: id?.toString(),
      referenceType: reference?.toString(),
    );
  }
}
