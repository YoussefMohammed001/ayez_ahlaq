import 'package:ayez_ahlaq/shared/user_type.dart';
import '../../features/barber/auth/domain/entities/barber_account_kind.dart';
import '../../features/merchant/auth/domain/entities/merchant_account_kind.dart';
import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/preferences_storage/preferences_storage_keys.dart';
import '../cache/secure_storage/secure_storage.dart';
import '/core/di/services_locator.dart';

class UserHelpers {
  static Future<bool> isLoggedIn() async {
    final token = await sl<SecureStorage>().read(SecureStorageKeys.userToken);

    return token != null && token.isNotEmpty;
  }

  static Future<bool> isGuest() async {
    final token = await sl<SecureStorage>().read(SecureStorageKeys.userToken);

    return token == null || token.isEmpty;
  }

  static bool isFirstTime() {
    return sl<PreferencesStorage>().getBoolean(
      key: PreferencesKeys.firstOpen,
      defaultValue: true,
    );
  }

  static bool isNotLoggedIn() {
    return getPhoneNumber().isEmpty;
  }

  static Future<String> getUserToken() async {
    final userToken = await sl<SecureStorage>().read(
      SecureStorageKeys.userToken,
    );
    return userToken ?? '';
  }

  static String getPhoneNumber() {
    final phone = sl<PreferencesStorage>().getString(
      key: PreferencesKeys.phone,
    );
    return phone;
  }

  static UserType get userType {
    final raw = sl<PreferencesStorage>().getString(
      key: PreferencesKeys.userType,
    );
    return UserType.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => UserType.customer,
    );
  }

  static BarberAccountKind get barberAccountKind {
    return BarberAccountKind.fromName(
      sl<PreferencesStorage>().getString(key: PreferencesKeys.barberAccountKind),
    );
  }

  static Future<void> setBarberAccountKind(BarberAccountKind kind) {
    return sl<PreferencesStorage>().putString(
      key: PreferencesKeys.barberAccountKind,
      value: kind.name,
    );
  }

  static MerchantAccountKind get merchantAccountKind {
    return MerchantAccountKind.fromName(
      sl<PreferencesStorage>().getString(
        key: PreferencesKeys.merchantAccountKind,
      ),
    );
  }

  static String get displayName {
    return sl<PreferencesStorage>().getString(key: PreferencesKeys.name);
  }

  static bool get hasSelectedUserType {
    return sl<PreferencesStorage>()
        .getString(key: PreferencesKeys.userType)
        .isNotEmpty;
  }

  static Future<void> setUserType(UserType type) {
    return sl<PreferencesStorage>().putString(
      key: PreferencesKeys.userType,
      value: type.name,
    );
  }


  static bool get isAdminApproved {
    return sl<PreferencesStorage>().getBoolean(
      key: PreferencesKeys.adminApproved,
    );
  }

  static int get userId {
    return sl<PreferencesStorage>().getInt(key: PreferencesKeys.userId);
  }
}
