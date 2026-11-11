import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../../../barber/attendance/data/models/attendance_history_page_model.dart';
import '../../../../barber/attendance/data/models/current_attendance_model.dart';
import '../../../../barber/attendance/domain/entities/attendance_history_page.dart';
import '../../../../barber/attendance/domain/entities/attendance_method.dart';
import '../../../../barber/attendance/domain/entities/current_attendance.dart';
import '../../../../barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import '../apis/merchant_attendance_api.dart';

class MerchantAttendanceRepo implements IBarberAttendanceRepo {
  final MerchantAttendanceApi _api;

  MerchantAttendanceRepo(this._api);

  @override
  Future<Either<Failure, CurrentAttendance>> getCurrent() async {
    final result = await _api.getCurrent();
    return result.flatMap(_currentFrom);
  }

  @override
  Future<Either<Failure, CurrentAttendance>> checkIn({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) async {
    final result = await _api.checkIn(lat: lat, lng: lng, method: method);
    return result.flatMap(_currentFrom);
  }

  @override
  Future<Either<Failure, Unit>> checkOut({
    double? lat,
    double? lng,
    AttendanceMethod method = AttendanceMethod.manual,
  }) async {
    final result = await _api.checkOut(lat: lat, lng: lng, method: method);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size = 20,
    DateTime? from,
  }) async {
    final result = await _api.getHistory(page: page, size: size);
    return result.flatMap(
      (response) =>
          requireDataMap(response).map(AttendanceHistoryPageModel.fromJson),
    );
  }

  Either<Failure, CurrentAttendance> _currentFrom(dynamic response) =>
      requireDataMap(response).map(CurrentAttendanceModel.fromJson);
}
