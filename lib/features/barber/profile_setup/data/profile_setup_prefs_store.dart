import '../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../domain/entities/profile_setup_step.dart';
import '../domain/repos/i_profile_setup_store.dart';

class ProfileSetupPrefsStore implements IProfileSetupStore {
  static const _separator = ':';

  final PreferencesStorage _preferences;

  ProfileSetupPrefsStore(this._preferences);

  @override
  Set<ProfileSetupStep> doneSteps(int ownerId) {
    final prefix = '$ownerId$_separator';
    final names = _preferences
        .getStringList(key: PreferencesKeys.profileSetupDoneSteps)
        .where((entry) => entry.startsWith(prefix))
        .map((entry) => entry.substring(prefix.length));

    return {
      for (final step in ProfileSetupStep.values)
        if (names.contains(step.name)) step,
    };
  }

  @override
  Future<void> saveDoneSteps(int ownerId, Set<ProfileSetupStep> steps) async {
    final entries = {
      ..._preferences.getStringList(key: PreferencesKeys.profileSetupDoneSteps),
      for (final step in steps) '$ownerId$_separator${step.name}',
    };
    await _preferences.putStringList(
      key: PreferencesKeys.profileSetupDoneSteps,
      value: entries.toList(),
    );
  }

  @override
  DateTime? hiddenAt(int ownerId) {
    final prefix = '$ownerId$_separator';
    final entry = _preferences
        .getStringList(key: PreferencesKeys.profileSetupDismissedOwners)
        .where((value) => value.startsWith(prefix))
        .firstOrNull;

    return entry == null
        ? null
        : DateTime.tryParse(entry.substring(prefix.length));
  }

  @override
  Future<void> hide(int ownerId, DateTime at) async {
    final prefix = '$ownerId$_separator';
    final others = _preferences
        .getStringList(key: PreferencesKeys.profileSetupDismissedOwners)
        .where((value) => !value.startsWith(prefix));

    await _preferences.putStringList(
      key: PreferencesKeys.profileSetupDismissedOwners,
      value: [...others, '$prefix${at.toIso8601String()}'],
    );
  }
}
