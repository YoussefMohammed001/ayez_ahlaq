import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../cache/preferences_storage/preferences_storage.dart';
import '../../constants/strings.dart';
import 'package:ayez_ahlaq/env/env.dart';
import '../constants/content_types.dart';
import '../constants/http_headers.dart';
import '../../analytics/analytics_interceptor.dart';
import '../../analytics/api_analytics_tracker.dart';
import '../../di/services_locator.dart';
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
    dio.interceptors.add(AnalyticsInterceptor(() => sl<ApiAnalyticsTracker>()));

    if (isDevEnvironment()) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
        ),
      );
      ChuckerFlutter.showOnRelease = true;
      dio.interceptors.add(ChuckerDioInterceptor());
    }

    return dio;
  }
}
