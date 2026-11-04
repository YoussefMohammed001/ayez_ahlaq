import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/attendance_feature_requests_page.dart';
import '../entities/attendance_feature_status.dart';

abstract class IAttendanceFeatureRepo {
  Future<Either<Failure, AttendanceFeatureStatus>> getStatus();

  Future<Either<Failure, Unit>> requestFeature();

  Future<Either<Failure, Unit>> cancelRequest(int id);

  Future<Either<Failure, AttendanceFeatureRequestsPage>> getRequests({
    required int page,
  });
}
