class ApiParamExtractor {
  const ApiParamExtractor._();

  static const _maxLength = 40;
  static final _safeValue = RegExp(r'^[A-Za-z0-9_\-]+$');

  static const _keys = {
    'method': 'method',
    'status': 'status',
    'paymentMethod': 'payment_method',
    'type': 'type',
    'enabled': 'enabled',
  };

  static Map<String, Object> extract(dynamic body) {
    if (body is! Map) return const {};

    final params = <String, Object>{};
    for (final entry in _keys.entries) {
      final value = _safe(body[entry.key]);
      if (value != null) params[entry.value] = value;
    }
    return params;
  }

  static Object? _safe(dynamic value) {
    if (value is bool) return value.toString();
    if (value is num) return value;
    if (value is String &&
        value.length <= _maxLength &&
        _safeValue.hasMatch(value)) {
      return value;
    }
    return null;
  }
}
