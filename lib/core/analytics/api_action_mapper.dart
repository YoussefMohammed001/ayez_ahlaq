import 'package:flutter/foundation.dart';
import 'analytics_params.dart';
import 'api_action.dart';
import 'api_action_rule.dart';
import 'catalog/barber_operations_api_actions.dart';
import 'catalog/barber_shop_api_actions.dart';
import 'catalog/common_api_actions.dart';
import 'catalog/customer_api_actions.dart';
import 'catalog/ignored_api_actions.dart';
import 'catalog/merchant_api_actions.dart';

class ApiActionMapper {
  const ApiActionMapper._();

  static const _genericEvent = 'app_action';
  static const _maxActionLength = 90;

  static final _rules = <ApiActionRule>[
    ...CustomerApiActions.rules,
    ...BarberOperationsApiActions.rules,
    ...BarberShopApiActions.rules,
    ...MerchantApiActions.rules,
    ...CommonApiActions.rules,
  ];

  @visibleForTesting
  static List<ApiActionRule> get rules => _rules;

  static bool isIgnored(String method, String path) {
    final normalizedPath = _normalize(path);
    final verb = method.toUpperCase();
    return IgnoredApiActions.rules.any((r) => r.matches(verb, normalizedPath));
  }

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
