import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_shift.dart';
import '../repos/i_barber_attendance_admin_repo.dart';

class CorrectAttendanceRecordUseCase {
  final IBarberAttendanceAdminRepo _repo;

  CorrectAttendanceRecordUseCase(this._repo);

  Future<Either<Failure, AttendanceShift>> call({
    required int id,
    required DateTime checkInAt,
    required DateTime checkOutAt,
    required String note,
  }) => _repo.correctRecord(
    id: id,
    checkInAt: checkInAt,
    checkOutAt: checkOutAt,
    note: note,
  );
}
