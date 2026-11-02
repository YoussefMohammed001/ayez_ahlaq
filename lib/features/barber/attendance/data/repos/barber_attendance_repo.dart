import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/attendance_history_page.dart';
import '../../domain/entities/current_attendance.dart';
import '../../domain/repos/i_barber_attendance_repo.dart';
import '../apis/barber_attendance_api.dart';
import '../models/attendance_history_page_model.dart';
import '../models/current_attendance_model.dart';

class BarberAttendanceRepo implements IBarberAttendanceRepo {
  final BarberAttendanceApi _api;

  BarberAttendanceRepo(this._api);

  @override
  Future<Either<Failure, CurrentAttendance>> getCurrent() async {
    final result = await _api.getCurrent();
    return result.flatMap(_currentFrom);
  }

  @override
  Future<Either<Failure, CurrentAttendance>> checkIn({
    double? lat,
    double? lng,
  }) async {
    final result = await _api.checkIn(lat: lat, lng: lng);
    return result.flatMap(_currentFrom);
  }

  @override
  Future<Either<Failure, Unit>> checkOut({double? lat, double? lng}) async {
    final result = await _api.checkOut(lat: lat, lng: lng);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size = 20,
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
