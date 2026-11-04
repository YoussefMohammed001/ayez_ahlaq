import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_attendance_feature_repo.dart';

class RequestAttendanceFeatureUseCase {
  final IAttendanceFeatureRepo _repo;

  RequestAttendanceFeatureUseCase(this._repo);

  Future<Either<Failure, Unit>> call() => _repo.requestFeature();
}
