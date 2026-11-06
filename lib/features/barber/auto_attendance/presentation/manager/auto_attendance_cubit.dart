import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/analytics/app_analytics.dart';
import '../../domain/entities/background_location_status.dart';
import '../../domain/entities/enable_auto_attendance_result.dart';
import '../../domain/repos/i_auto_attendance_store.dart';
import '../../domain/repos/i_background_location_permission.dart';
import '../../domain/use_cases/disable_auto_attendance_use_case.dart';
import '../../domain/use_cases/enable_auto_attendance_use_case.dart';
import 'auto_attendance_state.dart';

class AutoAttendanceCubit extends Cubit<AutoAttendanceState> {
  final EnableAutoAttendanceUseCase _enable;
  final DisableAutoAttendanceUseCase _disable;
  final IAutoAttendanceStore _store;
  final IBackgroundLocationPermission _permission;
  final AppAnalytics _analytics;

  AutoAttendanceCubit(
    this._enable,
    this._disable,
    this._store,
    this._permission,
    this._analytics,
  ) : super(const AutoAttendanceState());

  @override
  void emit(AutoAttendanceState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> load() async {
    var enabled = _store.isEnabled;

    if (enabled &&
        await _permission.status() != BackgroundLocationStatus.granted) {
      await _disable();
      _analytics.autoAttendanceToggled(
        enabled: false,
        result: 'permission_revoked',
      );
      enabled = false;
    }

    emit(state.copyWith(isEnabled: enabled));
  }

  Future<EnableAutoAttendanceResult> turnOn() async {
    emit(state.copyWith(isBusy: true));

    final result = await _enable();
    _analytics.autoAttendanceToggled(enabled: true, result: result.name);

    emit(
      state.copyWith(
        isBusy: false,
        isEnabled: result == EnableAutoAttendanceResult.enabled,
        lastResult: result,
      ),
    );
    return result;
  }

  Future<void> turnOff() async {
    emit(state.copyWith(isBusy: true));
    await _disable();
    _analytics.autoAttendanceToggled(enabled: false, result: 'disabled');
    emit(state.copyWith(isBusy: false, isEnabled: false));
  }

  Future<void> openSettings() => _permission.openSettings();
}
