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
  bool isDismissed(int ownerId) => _preferences
      .getStringList(key: PreferencesKeys.profileSetupDismissedOwners)
      .contains('$ownerId');

  @override
  Future<void> dismiss(int ownerId) async {
    final owners = {
      ..._preferences.getStringList(
        key: PreferencesKeys.profileSetupDismissedOwners,
      ),
      '$ownerId',
    };
    await _preferences.putStringList(
      key: PreferencesKeys.profileSetupDismissedOwners,
      value: owners.toList(),
    );
  }
}
