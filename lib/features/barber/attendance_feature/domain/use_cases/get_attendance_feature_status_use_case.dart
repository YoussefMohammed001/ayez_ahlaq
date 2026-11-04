import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_feature_status.dart';
import '../repos/i_attendance_feature_repo.dart';

class GetAttendanceFeatureStatusUseCase {
  final IAttendanceFeatureRepo _repo;

  GetAttendanceFeatureStatusUseCase(this._repo);

  Future<Either<Failure, AttendanceFeatureStatus>> call() => _repo.getStatus();
}
