import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_feature_requests_page.dart';
import '../repos/i_attendance_feature_repo.dart';

class GetAttendanceFeatureRequestsUseCase {
  final IAttendanceFeatureRepo _repo;

  GetAttendanceFeatureRequestsUseCase(this._repo);

  Future<Either<Failure, AttendanceFeatureRequestsPage>> call({
    required int page,
  }) => _repo.getRequests(page: page);
}
