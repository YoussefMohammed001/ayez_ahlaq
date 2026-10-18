import 'package:dio/dio.dart';
import 'api_analytics_tracker.dart';

class AnalyticsInterceptor extends Interceptor {
  final ApiAnalyticsTracker Function() _tracker;

  AnalyticsInterceptor(this._tracker);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);

    final status = response.statusCode ?? 0;
    if (status < 200 || status >= 300) return;

    try {
      _tracker().onSuccess(response.requestOptions);
    } catch (_) {}
  }
}
