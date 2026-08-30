class NotificationPayload {
  final String type;
  final String? typeId;

  const NotificationPayload({required this.type, this.typeId});

  factory NotificationPayload.fromMap(Map<dynamic, dynamic> data) {
    final id = data['type_id'] ?? data['typeId'] ?? data['id'];
    return NotificationPayload(
      type: data['type'] as String? ?? '',
      typeId: id?.toString(),
    );
  }
}
