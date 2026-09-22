import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_home_service_settings_use_case.dart';
import '../../domain/use_cases/update_home_service_settings_use_case.dart';
import 'home_service_settings_state.dart';

class HomeServiceSettingsCubit extends Cubit<HomeServiceSettingsState> {
  final GetHomeServiceSettingsUseCase _getSettings;
  final UpdateHomeServiceSettingsUseCase _updateSettings;

  HomeServiceSettingsCubit(this._getSettings, this._updateSettings)
    : super(const HomeServiceSettingsState());

  Future<void> loadSettings() async {
    emit(state.copyWith(status: HomeServiceSettingsStatus.loading));

    final result = await _getSettings();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeServiceSettingsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (settings) => emit(
        state.copyWith(
          status: HomeServiceSettingsStatus.success,
          settings: settings,
        ),
      ),
    );
  }

  Future<bool> save({required bool enabled, num? price, String? note}) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateSettings(
      enabled: enabled,
      price: price,
      note: note,
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
            isSubmitting: false,
            status: HomeServiceSettingsStatus.success,
            settings: settings,
          ),
        );
        return true;
      },
    );
  }
}
