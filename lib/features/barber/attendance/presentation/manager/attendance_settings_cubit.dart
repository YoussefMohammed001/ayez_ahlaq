import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_attendance_settings_use_case.dart';
import '../../domain/use_cases/update_attendance_settings_use_case.dart';
import 'attendance_settings_state.dart';

class AttendanceSettingsCubit extends Cubit<AttendanceSettingsState> {
  final GetAttendanceSettingsUseCase _getSettings;
  final UpdateAttendanceSettingsUseCase _updateSettings;

  AttendanceSettingsCubit(this._getSettings, this._updateSettings)
    : super(const AttendanceSettingsState());

  @override
  void emit(AttendanceSettingsState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> load() async {
    if (state.settings == null) {
      emit(state.copyWith(status: AttendanceSettingsStatus.loading));
    }

    final result = await _getSettings();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AttendanceSettingsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (settings) => emit(
        state.copyWith(
          status: AttendanceSettingsStatus.success,
          settings: settings,
        ),
      ),
    );
  }

  Future<bool> save({required bool enforced, int? rangeMeters}) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateSettings(
      enforced: enforced,
      rangeMeters: rangeMeters,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (settings) {
        emit(
          state.copyWith(
            status: AttendanceSettingsStatus.success,
            settings: settings,
            isSubmitting: false,
          ),
        );
        return true;
      },
    );
  }
}
