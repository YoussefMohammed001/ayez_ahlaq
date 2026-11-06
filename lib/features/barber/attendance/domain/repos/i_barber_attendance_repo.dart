import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_history_page.dart';
import '../entities/attendance_method.dart';
import '../entities/current_attendance.dart';

abstract class IBarberAttendanceRepo {
  Future<Either<Failure, CurrentAttendance>> getCurrent();

  Future<Either<Failure, CurrentAttendance>> checkIn({
    double? lat,
    double? lng,
    AttendanceMethod method,
  });

  Future<Either<Failure, Unit>> checkOut({
    double? lat,
    double? lng,
    AttendanceMethod method,
  });

  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size,
  });
}
