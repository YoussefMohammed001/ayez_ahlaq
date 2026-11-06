import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ayez_ahlaq/core/analytics/app_analytics.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/constants/strings.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/data/services/auto_attendance_prefs_store.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/background_location_status.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/enable_auto_attendance_result.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/use_cases/disable_auto_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/use_cases/enable_auto_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/presentation/manager/auto_attendance_cubit.dart';
import '../../../support/recording_analytics.dart';
import 'auto_attendance_test_doubles.dart';

void main() {
  late FakeAttendanceRepo repo;
  late FakeStore store;
  late FakeRegistrar registrar;
  late FakePermission permission;
  late RecordingAnalytics analytics;

  AutoAttendanceCubit build() => AutoAttendanceCubit(
    EnableAutoAttendanceUseCase(
      GetCurrentAttendanceUseCase(repo),
      permission,
      registrar,
      store,
    ),
    DisableAutoAttendanceUseCase(registrar, store),
    store,
    permission,
    AppAnalytics(analytics),
  );

  setUp(() {
    repo = FakeAttendanceRepo();
    store = FakeStore(enabled: false);
    registrar = FakeRegistrar();
    permission = FakePermission();
    analytics = RecordingAnalytics();
  });

  group('cubit', () {
    test('starts off and reflects a stored choice', () async {
      store.enabled = true;
      final cubit = build();

      await cubit.load();

      expect(cubit.state.isEnabled, isTrue);
    });

    test('turns off a stored choice when location access is gone', () async {
      store.enabled = true;
      permission.current = BackgroundLocationStatus.denied;
      final cubit = build();

      await cubit.load();

      expect(cubit.state.isEnabled, isFalse);
      expect(store.enabled, isFalse);
      expect(registrar.clears, 1);
    });

    test('turning on succeeds and shows as enabled', () async {
      final cubit = build();

      final result = await cubit.turnOn();

      expect(result, EnableAutoAttendanceResult.enabled);
      expect(cubit.state.isEnabled, isTrue);
      expect(cubit.state.isBusy, isFalse);
    });

    test('a refused permission leaves it off and remembers why', () async {
      permission.afterRequest = BackgroundLocationStatus.blocked;
      final cubit = build();

      await cubit.turnOn();

      expect(cubit.state.isEnabled, isFalse);
      expect(
        cubit.state.lastResult,
        EnableAutoAttendanceResult.permissionBlocked,
      );
    });

    test('turning off clears the zone', () async {
      final cubit = build();
      await cubit.turnOn();

      await cubit.turnOff();

      expect(cubit.state.isEnabled, isFalse);
      expect(registrar.clears, 1);
    });

    test('reports what happened when it was switched on or off', () async {
      final cubit = build();

      await cubit.turnOn();
      await cubit.turnOff();

      expect(analytics.events.map((e) => e.parameters), [
        {'enabled': 'true', 'result': 'enabled'},
        {'enabled': 'false', 'result': 'disabled'},
      ]);
    });

    test('reports when access was taken away behind its back', () async {
      store.enabled = true;
      permission.current = BackgroundLocationStatus.denied;

      await build().load();

      expect(analytics.last('auto_attendance_toggled')!.parameters, {
        'enabled': 'false',
        'result': 'permission_revoked',
      });
    });

    test('opens the system settings on request', () async {
      await build().openSettings();

      expect(permission.settingsOpened, 1);
    });
  });

  group('preferences store', () {
    late AutoAttendancePrefsStore prefsStore;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      AppStrings.baseUrl = 'https://example.test/api';
      prefsStore = AutoAttendancePrefsStore(
        PreferencesStorage(await SharedPreferences.getInstance()),
      );
    });

    test('remembers which server the background should talk to', () async {
      expect(prefsStore.isEnabled, isFalse);

      await prefsStore.setEnabled(true);

      expect(prefsStore.isEnabled, isTrue);
      expect(prefsStore.serverUrl, 'https://example.test/api');

      await prefsStore.setEnabled(false);

      expect(prefsStore.isEnabled, isFalse);
      expect(prefsStore.serverUrl, isEmpty);
    });
  });
}
