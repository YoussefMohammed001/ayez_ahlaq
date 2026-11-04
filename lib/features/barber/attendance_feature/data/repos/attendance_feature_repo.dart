import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/http_codes.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/attendance_feature_requests_page.dart';
import '../../domain/entities/attendance_feature_status.dart';
import '../../domain/repos/i_attendance_feature_repo.dart';
import '../apis/attendance_feature_api.dart';
import '../models/attendance_feature_requests_page_model.dart';
import '../models/attendance_feature_status_model.dart';

class AttendanceFeatureRepo implements IAttendanceFeatureRepo {
  static const _pageSize = 20;

  final AttendanceFeatureApi _api;

  AttendanceFeatureRepo(this._api);

  @override
  Future<Either<Failure, AttendanceFeatureStatus>> getStatus() async {
    final result = await _api.getStatus();

    return result.fold(
      (failure) => failure.statusCode == HttpCodes.notFound
          ? const Right(AttendanceFeatureStatus.ungated())
          : Left(failure),
      (response) => requireDataMap(
        response,
      ).map<AttendanceFeatureStatus>(AttendanceFeatureStatusModel.fromJson),
    );
  }

  @override
  Future<Either<Failure, Unit>> requestFeature() async {
    final result = await _api.requestFeature();
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> cancelRequest(int id) async {
    final result = await _api.cancelRequest(id);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, AttendanceFeatureRequestsPage>> getRequests({
    required int page,
  }) async {
    final result = await _api.getRequests(page: page, size: _pageSize);
    return result.flatMap(
      (response) => requireDataMap(
        response,
      ).map(AttendanceFeatureRequestsPageModel.fromJson),
    );
  }
}
