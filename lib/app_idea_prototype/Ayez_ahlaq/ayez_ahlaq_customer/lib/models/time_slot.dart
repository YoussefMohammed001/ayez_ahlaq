enum SlotStatus { available, booked }

class TimeSlot {
  final String time;
  final SlotStatus status;
  final int? queueAhead;

  const TimeSlot({required this.time, required this.status, this.queueAhead});
}

class DateOption {
  final String id;
  final String day;
  final int num;

  const DateOption({required this.id, required this.day, required this.num});
}
