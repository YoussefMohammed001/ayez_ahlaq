enum QueueStatus { done, active, next, upcoming, cancelled }

extension QueueStatusLabel on QueueStatus {
  String get label => switch (this) {
        QueueStatus.done => 'خلصت',
        QueueStatus.active => 'جاري دلوقتي',
        QueueStatus.next => 'التالي',
        QueueStatus.upcoming => 'قادم',
        QueueStatus.cancelled => 'اتلغى',
      };
}

class QueueEntry {
  final String time;
  final String customerName;
  final String barberName;
  final String service;
  final int price;
  final int durationMinutes;
  final String phone;
  final String note;
  final bool walkIn;
  QueueStatus status;

  QueueEntry({
    required this.time,
    required this.customerName,
    required this.barberName,
    required this.service,
    required this.price,
    required this.durationMinutes,
    required this.status,
    this.phone = '',
    this.note = '—',
    this.walkIn = false,
  });
}
