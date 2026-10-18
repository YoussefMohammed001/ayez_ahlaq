import 'package:dio/dio.dart';
import '../../shared/analytics/user_analytics_sync.dart';
import '../../shared/user_type.dart';
import '../review/review_prompt_service.dart';
import 'analytics_events.dart';
import 'analytics_params.dart';
import 'api_action_mapper.dart';
import 'i_analytics_service.dart';

class ApiAnalyticsTracker {
  static const _readMethods = {'GET', 'HEAD', 'OPTIONS'};
  static const _positiveRatingThreshold = 4;
  static const _barberDoneStatus = 'DONE';
  static const _merchantDeliveredStatus = 'DELIVERED';

  final IAnalyticsService _analytics;
  final UserAnalyticsSync _userSync;
  final ReviewPromptService _reviewPrompt;

  ApiAnalyticsTracker(this._analytics, this._userSync, this._reviewPrompt);

  Future<void> onSuccess(RequestOptions request) async {
    if (_readMethods.contains(request.method.toUpperCase())) return;

    final action = ApiActionMapper.map(request.method, request.path);
    final rating = _ratingOf(request.data);
    final parameters = {
      ...action.parameters,
      if (rating != null) AnalyticsParams.rating: rating,
    };

    await _analytics.logEvent(action.eventName, parameters);
    await _identifyOnLogin(action.eventName, parameters);

    if (_isPositiveAction(action.eventName, request, rating)) {
      await _reviewPrompt.onPositiveAction();
    }
  }

  Future<void> _identifyOnLogin(
    String event,
    Map<String, Object> parameters,
  ) async {
    if (event != AnalyticsEvents.login) return;

    final segment = parameters[AnalyticsParams.userType];
    final types = UserType.values.where((type) => type.apiSegment == segment);
    if (types.isNotEmpty) await _userSync.identify(types.first);
  }

  bool _isPositiveAction(String event, RequestOptions request, int? rating) {
    final status = _statusOf(request.data);

    return switch (event) {
      AnalyticsEvents.bookingRated =>
        rating != null && rating >= _positiveRatingThreshold,
      AnalyticsEvents.barberBookingCompleted => status == _barberDoneStatus,
      AnalyticsEvents.merchantOrderUpdated =>
        status == _merchantDeliveredStatus || request.path.endsWith('/accept'),
      _ => false,
    };
  }

  int? _ratingOf(dynamic data) {
    if (data is! Map) return null;
    final value = data['stars'];
    return value is num ? value.toInt() : null;
  }

  String? _statusOf(dynamic data) {
    if (data is! Map) return null;
    final value = data['status'];
    return value is String ? value : null;
  }
}
