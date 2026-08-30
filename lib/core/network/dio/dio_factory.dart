import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ayez_ahlaq/core/helpers/safe_print.dart';
import '../../cache/preferences_storage/preferences_storage.dart';
import '../../constants/strings.dart';
import 'package:ayez_ahlaq/env/env.dart';
import '../constants/content_types.dart';
import '../constants/http_headers.dart';
import '../interceptors/authorization_interceptor.dart';

class DioFactory {
  static Dio create(
    AuthorizationInterceptor authInterceptor,
    PreferencesStorage storage,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppStrings.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (options.data is! FormData) {
            options.headers[HttpHeadersKeys.contentType] = ContentTypes.json;
          }
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(authInterceptor);

    final bool debugEnabled = _isDebugEnabled(storage);
    safePrint("hahahahahaa $debugEnabled");
    if (debugEnabled) {
      ChuckerFlutter.showOnRelease = true;
      dio.interceptors.add(ChuckerDioInterceptor());
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }

  static bool _isDebugEnabled(PreferencesStorage storage) {
    return isDevEnvironment();
  }
}
