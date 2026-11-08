import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/data/profile_setup_prefs_store.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/entities/profile_setup_step.dart';

void main() {
  late PreferencesStorage preferences;
  late ProfileSetupPrefsStore store;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = PreferencesStorage(await SharedPreferences.getInstance());
    store = ProfileSetupPrefsStore(preferences);
  });

  test('remembers the true steps of each account separately', () async {
    await store.saveDoneSteps(1, {ProfileSetupStep.hours});
    await store.saveDoneSteps(12, {ProfileSetupStep.team});

    expect(store.doneSteps(1), {ProfileSetupStep.hours});
    expect(store.doneSteps(12), {ProfileSetupStep.team});
    expect(store.doneSteps(2), isEmpty);
  });

  test(
    'an account whose id starts with another one is not confused with it',
    () async {
      await store.saveDoneSteps(1, {ProfileSetupStep.hours});

      expect(store.doneSteps(11), isEmpty);
    },
  );

  test('keys only ever get added', () async {
    await store.saveDoneSteps(1, {ProfileSetupStep.hours});
    await store.saveDoneSteps(1, {ProfileSetupStep.services});
    await store.saveDoneSteps(1, {ProfileSetupStep.services});

    expect(store.doneSteps(1), {
      ProfileSetupStep.hours,
      ProfileSetupStep.services,
    });
  });

  test('remembers when each account hid the card', () async {
    final moment = DateTime(2026, 11, 8, 12, 30);
    await store.hide(2, moment);

    expect(store.hiddenAt(2), moment);
    expect(store.hiddenAt(1), isNull);
    expect(store.hiddenAt(22), isNull);
  });

  test('hiding again replaces the old time for that account only', () async {
    final first = DateTime(2026, 11, 1);
    final second = DateTime(2026, 11, 8);
    await store.hide(2, first);
    await store.hide(3, first);

    await store.hide(2, second);

    expect(store.hiddenAt(2), second);
    expect(store.hiddenAt(3), first);
  });

  test(
    'everything survives a logout, the rest of the preferences do not',
    () async {
      await store.saveDoneSteps(1, {ProfileSetupStep.hours});
      await store.hide(1, DateTime(2026, 11, 8));
      await preferences.putString(
        key: PreferencesKeys.currentLanguage,
        value: 'en',
      );
      await preferences.putBoolean(key: PreferencesKeys.firstOpen, value: true);

      await preferences.clearExcept(PreferencesStorage.keptOnLogout);

      expect(store.doneSteps(1), {ProfileSetupStep.hours});
      expect(store.hiddenAt(1), DateTime(2026, 11, 8));
      expect(preferences.getCurrentLanguage(), 'en');
      expect(preferences.getBoolean(key: PreferencesKeys.firstOpen), isFalse);
    },
  );

  test(
    'what logout keeps includes the language, the tour and the setup keys',
    () {
      expect(
        PreferencesStorage.keptOnLogout,
        containsAll({
          PreferencesKeys.currentLanguage,
          PreferencesKeys.barberOwnerTourSeen,
          PreferencesKeys.barberTeamTourSeen,
          PreferencesKeys.profileSetupDoneSteps,
          PreferencesKeys.profileSetupDismissedOwners,
        }),
      );
    },
  );
}
