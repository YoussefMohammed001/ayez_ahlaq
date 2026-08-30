import 'dart:async';
import 'package:ayez_ahlaq/generated/l10n.dart';
import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/preferences_storage/preferences_storage_keys.dart';
import '../cache/secure_storage/secure_storage.dart';
import '../helpers/alerts.dart';
import '../routes/app_routes.dart';
import '../routes/route_paths.dart';
import 'session_events.dart';

class SessionManager {
  final SecureStorage storage;
  final PreferencesStorage preferencesStorage;

  SessionManager(this.storage, this.preferencesStorage);

  final StreamController<String> _sessionEvents =
      StreamController<String>.broadcast();

  bool _isHandlingUnauthorized = false;

  Stream<String> get sessionEvents => _sessionEvents.stream;

  void emitUnauthorized() => _sessionEvents.add(SessionEvents.unauthorized);

  Future<void> handleUnauthorized() async {
    if (_isHandlingUnauthorized) return;
    _isHandlingUnauthorized = true;

    try {
      await _clearSession();
      showError(S().your_session_has_been_expired);
      routes.go(Routes.userTypeScreen);
    } finally {
      _isHandlingUnauthorized = false;
    }
  }

  Future<void> logout() async {
    await _clearSession();
    routes.go(Routes.userTypeScreen);
  }

  Future<void> _clearSession() async {
    final language = preferencesStorage.getCurrentLanguage();
    await storage.deleteAll();
    await preferencesStorage.clear();
    await preferencesStorage.putString(
      key: PreferencesKeys.currentLanguage,
      value: language,
    );
  }
}
