import '../../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../../../core/di/sl.dart';
import '../../../../../core/session/session_scope.dart';
import '../manager/profile_setup_cubit.dart';

class ProfileSetupPrefetch {
  const ProfileSetupPrefetch._();

  static const _homeBudget = Duration(seconds: 4);

  static Future<void> start(ProfileSetupCubit cubit) async {
    final ownerId = sl<PreferencesStorage>().getUserId();
    if (ownerId == 0) return;

    await cubit.start(ownerId).catchError((_) {});
  }

  static Future<void> beforeHome() async {
    await start(
      SessionScope.cubit<ProfileSetupCubit>(),
    ).timeout(_homeBudget, onTimeout: () {});
  }
}
