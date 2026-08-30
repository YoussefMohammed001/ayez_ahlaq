import 'package:dio/dio.dart';
import '../../cache/secure_storage/secure_storage.dart';
import '../../cache/preferences_storage/preferences_storage.dart';
import '../constants/http_headers.dart';
import '../constants/http_codes.dart';
import '../../session/session_manager.dart';

class AuthorizationInterceptor extends Interceptor {
  final SecureStorage storage;
  final PreferencesStorage preferences;
  final SessionManager sessionManager;

  AuthorizationInterceptor(this.storage, this.preferences, this.sessionManager);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.read(SecureStorageKeys.userToken);

    if (token != null && token.isNotEmpty) {
      options.headers[HttpHeadersKeys.authorization] = 'Bearer $token';
    }

    options.headers[HttpHeadersKeys.locale] = preferences.getCurrentLanguage();

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpCodes.unauthorized) {
      sessionManager.emitUnauthorized();
    }
    handler.next(err);
  }
}
