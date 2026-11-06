import 'dart:convert';
import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/preferences_storage/preferences_storage_keys.dart';
import 'i_analytics_service.dart';

class PendingAnalyticsQueue {
  static const _maxEvents = 50;
  static const _key = PreferencesKeys.pendingAnalyticsEvents;

  final PreferencesStorage _preferences;

  PendingAnalyticsQueue(this._preferences);

  Future<void> enqueue(String name, Map<String, Object> parameters) async {
    await _preferences.reload();

    final events = [..._preferences.getStringList(key: _key)];
    events.add(jsonEncode({'name': name, 'params': parameters}));

    final kept = events.length > _maxEvents
        ? events.sublist(events.length - _maxEvents)
        : events;
    await _preferences.putStringList(key: _key, value: kept);
  }

  Future<void> flush(IAnalyticsService analytics) async {
    await _preferences.reload();

    final events = _preferences.getStringList(key: _key);
    if (events.isEmpty) return;
    await _preferences.putStringList(key: _key, value: const []);

    for (final raw in events) {
      final event = _decode(raw);
      if (event != null) await analytics.logEvent(event.$1, event.$2);
    }
  }

  (String, Map<String, Object>)? _decode(String raw) {
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final params = (json['params'] as Map).cast<String, Object>();
      return (json['name'] as String, params);
    } catch (_) {
      return null;
    }
  }
}
