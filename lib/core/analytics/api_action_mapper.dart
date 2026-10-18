import 'analytics_events.dart';
import 'analytics_params.dart';
import 'api_action.dart';

class ApiActionMapper {
  const ApiActionMapper._();

  static const _genericEvent = 'app_action';
  static const _maxActionLength = 90;

  static final _rules = <_Rule>[
    _Rule('POST', r'^(customer|barber|merchant)/login$', AnalyticsEvents.login),
    _Rule(
      'POST',
      r'^(customer|barber|merchant)/register$',
      AnalyticsEvents.signUp,
    ),
    _Rule(
      'POST',
      r'^(customer|barber|merchant)/register/verifyOtp$',
      AnalyticsEvents.otpVerified,
    ),
    _Rule('POST', r'^customer/booking$', AnalyticsEvents.bookingCreated),
    _Rule(
      'PUT',
      r'^customer/booking/\d+/cancel$',
      AnalyticsEvents.bookingCancelled,
    ),
    _Rule('POST', r'^customer/rating$', AnalyticsEvents.bookingRated),
    _Rule(
      'POST',
      r'^customer/homeService$',
      AnalyticsEvents.homeServiceRequested,
    ),
    _Rule(
      'POST',
      r'^(customer|barber)/cart/checkout$',
      AnalyticsEvents.storeOrderPlaced,
    ),
    _Rule('POST', r'^customer/favorite/\d+$', AnalyticsEvents.favoriteAdded),
    _Rule(
      'DELETE',
      r'^customer/favorite/\d+$',
      AnalyticsEvents.favoriteRemoved,
    ),
    _Rule(
      'PUT',
      r'^barber/booking/\d+/confirm$',
      AnalyticsEvents.barberBookingAccepted,
    ),
    _Rule(
      'PUT',
      r'^barber/booking/\d+/reject$',
      AnalyticsEvents.barberBookingRejected,
    ),
    _Rule(
      'PUT',
      r'^barber/booking/\d+/status$',
      AnalyticsEvents.barberBookingCompleted,
    ),
    _Rule('POST', r'^barber/service$', AnalyticsEvents.barberServiceAdded),
    _Rule('PUT', r'^barber/location$', AnalyticsEvents.barberLocationSaved),
    _Rule('POST', r'^merchant/product$', AnalyticsEvents.merchantProductAdded),
    _Rule(
      'PUT',
      r'^merchant/order/\d+/(accept|reject|status|ship)$',
      AnalyticsEvents.merchantOrderUpdated,
    ),
  ];

  static ApiAction map(String method, String path) {
    final normalizedPath = _normalize(path);
    final verb = method.toUpperCase();

    for (final rule in _rules) {
      if (rule.matches(verb, normalizedPath)) {
        return ApiAction(rule.event, {
          AnalyticsParams.userType: _userTypeOf(normalizedPath),
        });
      }
    }

    return ApiAction(_genericEvent, {
      'action': _truncate('${verb.toLowerCase()}_${_slug(normalizedPath)}'),
      AnalyticsParams.userType: _userTypeOf(normalizedPath),
    });
  }

  static String _normalize(String path) {
    final withoutQuery = path.split('?').first;
    return withoutQuery
        .replaceAll(RegExp(r'^/+'), '')
        .replaceAll(RegExp(r'^api/'), '');
  }

  static String _userTypeOf(String path) {
    for (final type in const ['customer', 'barber', 'merchant']) {
      if (path.startsWith('$type/')) return type;
    }
    return 'unknown';
  }

  static String _slug(String path) => path
      .replaceAll(RegExp(r'\d+'), 'id')
      .replaceAll(RegExp(r'[^A-Za-z]+'), '_');

  static String _truncate(String value) => value.length <= _maxActionLength
      ? value
      : value.substring(0, _maxActionLength);
}

class _Rule {
  final String method;
  final RegExp pattern;
  final String event;

  _Rule(this.method, String pattern, this.event) : pattern = RegExp(pattern);

  bool matches(String verb, String path) =>
      verb == method && pattern.hasMatch(path);
}
