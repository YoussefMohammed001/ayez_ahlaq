import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/attendance_setting_log_page.dart';
import '../../domain/entities/attendance_settings.dart';
import '../../domain/entities/attendance_shift.dart';
import '../../domain/entities/team_attendance_member.dart';
import '../../domain/repos/i_barber_attendance_admin_repo.dart';
import '../apis/barber_attendance_admin_api.dart';
import '../models/attendance_setting_log_page_model.dart';
import '../models/attendance_settings_model.dart';
import '../models/attendance_shift_model.dart';
import '../models/team_attendance_member_model.dart';

class BarberAttendanceAdminRepo implements IBarberAttendanceAdminRepo {
  static const _pageSize = 20;

  final BarberAttendanceAdminApi _api;

  BarberAttendanceAdminRepo(this._api);

  @override
  Future<Either<Failure, AttendanceSettings>> getSettings() async {
    final result = await _api.getSettings();
    return result.flatMap(_settingsFrom);
  }

  @override
  Future<Either<Failure, AttendanceSettings>> updateSettings({
    required bool enforced,
    int? rangeMeters,
  }) async {
    final result = await _api.updateSettings(
      enforced: enforced,
      rangeMeters: rangeMeters,
    );
    return result.flatMap(_settingsFrom);
  }

  @override
  Future<Either<Failure, List<TeamAttendanceMember>>> getTeam() async {
    final result = await _api.getTeam();
    return result.map(
      (response) => (response['data'] as List<dynamic>? ?? [])
          .map(
            (e) =>
                TeamAttendanceMemberModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Failure, AttendanceSettingLogPage>> getSettingLog({
    required int page,
  }) async {
    final result = await _api.getSettingLog(page: page, size: _pageSize);
    return result.flatMap(
      (response) =>
          requireDataMap(response).map(AttendanceSettingLogPageModel.fromJson),
    );
  }

  @override
  Future<Either<Failure, AttendanceShift>> correctRecord({
    required int id,
    required DateTime checkInAt,
    required DateTime checkOutAt,
    required String note,
  }) async {
    final result = await _api.correctRecord(
      id: id,
      checkInAt: _apiTime(checkInAt),
      checkOutAt: _apiTime(checkOutAt),
      note: note,
    );
    return result.flatMap(
      (response) => requireDataMap(response).map(AttendanceShiftModel.fromJson),
    );
  }

  String _apiTime(DateTime value) {
    String two(int number) => number.toString().padLeft(2, '0');
    final date =
        '${value.year.toString().padLeft(4, '0')}-${two(value.month)}-${two(value.day)}';
    return '${date}T${two(value.hour)}:${two(value.minute)}:${two(value.second)}';
  }

  Either<Failure, AttendanceSettings> _settingsFrom(dynamic response) =>
      requireDataMap(response).map(AttendanceSettingsModel.fromJson);
}
