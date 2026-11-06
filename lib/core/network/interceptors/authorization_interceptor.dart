import 'package:dio/dio.dart';
import '../../cache/secure_storage/secure_storage.dart';
import '../../cache/preferences_storage/preferences_storage.dart';
import '../../cache/preferences_storage/preferences_storage_keys.dart';
import '../constants/http_headers.dart';
import '../constants/http_codes.dart';
import '../../../shared/user_type.dart';

class AuthorizationInterceptor extends Interceptor {
  final SecureStorage storage;
  final PreferencesStorage preferences;
  final void Function() onUnauthorized;

  AuthorizationInterceptor(this.storage, this.preferences, this.onUnauthorized);

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

    final skipClientHeader =
        options.extra[HttpHeadersKeys.skipClientHeaderExtraKey] == true;
    final userType = preferences.getString(key: PreferencesKeys.userType);
    if (!skipClientHeader &&
        (userType == UserType.barber.name ||
            userType == UserType.customer.name)) {
      options.headers[HttpHeadersKeys.client] = 'MOBILE';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final hadToken = err.requestOptions.headers.containsKey(
      HttpHeadersKeys.authorization,
    );
    if (hadToken && err.response?.statusCode == HttpCodes.unauthorized) {
      onUnauthorized();
    }
    handler.next(err);
  }
}
