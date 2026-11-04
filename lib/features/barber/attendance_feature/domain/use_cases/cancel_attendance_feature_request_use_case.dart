import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_attendance_feature_repo.dart';

class CancelAttendanceFeatureRequestUseCase {
  final IAttendanceFeatureRepo _repo;

  CancelAttendanceFeatureRequestUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.cancelRequest(id);
}
