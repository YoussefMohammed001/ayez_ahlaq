import '../../domain/entities/working_day.dart';

class WorkingDayModel extends WorkingDay {
  const WorkingDayModel({
    required super.dayOfWeek,
    required super.isOpen,
    required super.openTime,
    required super.closeTime,
  });

  factory WorkingDayModel.fromJson(Map<String, dynamic> json) {
    return WorkingDayModel(
      dayOfWeek: (json['dayOfWeek'] as num?)?.toInt() ?? 0,
      isOpen: !(json['off'] as bool? ?? true),
      openTime: json['opensAt'] as String? ?? '10:00',
      closeTime: json['closesAt'] as String? ?? '22:00',
    );
  }

  static Map<String, dynamic> toJson(WorkingDay day) {
    return {
      'dayOfWeek': day.dayOfWeek,
      'off': !day.isOpen,
      'opensAt': day.isOpen ? day.openTime : null,
      'closesAt': day.isOpen ? day.closeTime : null,
    };
  }
}
