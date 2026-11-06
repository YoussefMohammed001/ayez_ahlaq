import 'package:equatable/equatable.dart';
import '../../domain/entities/enable_auto_attendance_result.dart';

class AutoAttendanceState extends Equatable {
  final bool isEnabled;
  final bool isBusy;
  final EnableAutoAttendanceResult? lastResult;

  const AutoAttendanceState({
    this.isEnabled = false,
    this.isBusy = false,
    this.lastResult,
  });

  AutoAttendanceState copyWith({
    bool? isEnabled,
    bool? isBusy,
    EnableAutoAttendanceResult? lastResult,
  }) {
    return AutoAttendanceState(
      isEnabled: isEnabled ?? this.isEnabled,
      isBusy: isBusy ?? this.isBusy,
      lastResult: lastResult,
    );
  }

  @override
  List<Object?> get props => [isEnabled, isBusy, lastResult];
}
