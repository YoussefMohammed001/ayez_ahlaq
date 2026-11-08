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

  test('hiding is remembered per account', () async {
    await store.dismiss(2);

    expect(store.isDismissed(2), isTrue);
    expect(store.isDismissed(1), isFalse);
    expect(store.isDismissed(22), isFalse);
  });

  test(
    'everything survives a logout, the rest of the preferences do not',
    () async {
      await store.saveDoneSteps(1, {ProfileSetupStep.hours});
      await store.dismiss(1);
      await preferences.putString(
        key: PreferencesKeys.currentLanguage,
        value: 'en',
      );
      await preferences.putBoolean(key: PreferencesKeys.firstOpen, value: true);

      await preferences.clearExcept(PreferencesStorage.keptOnLogout);

      expect(store.doneSteps(1), {ProfileSetupStep.hours});
      expect(store.isDismissed(1), isTrue);
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
