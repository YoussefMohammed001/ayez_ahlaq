import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ayez_ahlaq/core/analytics/external_link_target.dart';
import 'package:ayez_ahlaq/core/analytics/pending_analytics_queue.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import '../../support/recording_analytics.dart';

class _ThrowingAnalytics extends RecordingAnalytics {
  final RecordingAnalytics inner;

  _ThrowingAnalytics(this.inner);

  @override
  Future<void> logEvent(String name, [Map<String, Object>? parameters]) async {
    if (name == 'a') throw StateError('offline');
    await inner.logEvent(name, parameters);
  }
}

void main() {
  late PendingAnalyticsQueue queue;
  late RecordingAnalytics analytics;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    queue = PendingAnalyticsQueue(
      PreferencesStorage(await SharedPreferences.getInstance()),
    );
    analytics = RecordingAnalytics();
  });

  group('pending events', () {
    test('are delivered in order and only once', () async {
      await queue.enqueue('auto_attendance_triggered', {
        'transition': 'entered',
        'outcome': 'checkedIn',
      });
      await queue.enqueue('auto_attendance_triggered', {
        'transition': 'exited',
        'outcome': 'checkedOut',
      });

      await queue.flush(analytics);
      await queue.flush(analytics);

      expect(analytics.events.map((e) => e.parameters), [
        {'transition': 'entered', 'outcome': 'checkedIn'},
        {'transition': 'exited', 'outcome': 'checkedOut'},
      ]);
    });

    test('flushing with nothing waiting does nothing', () async {
      await queue.flush(analytics);

      expect(analytics.events, isEmpty);
    });

    test('keep only the latest fifty', () async {
      for (var i = 0; i < 60; i++) {
        await queue.enqueue('e', {'i': i});
      }

      await queue.flush(analytics);

      expect(analytics.events, hasLength(50));
      expect(analytics.events.first.parameters['i'], 10);
      expect(analytics.events.last.parameters['i'], 59);
    });

    test('flushed twice at once are still delivered once', () async {
      await queue.enqueue('a', {'x': 1});

      await Future.wait([queue.flush(analytics), queue.flush(analytics)]);

      expect(analytics.names, ['a']);
    });

    test('a failing analytics service does not break the flush', () async {
      await queue.enqueue('a', {'x': 1});
      await queue.enqueue('b', {'x': 2});

      await queue.flush(_ThrowingAnalytics(analytics));

      expect(analytics.names, ['b']);
    });

    test('survive a corrupted entry', () async {
      SharedPreferences.setMockInitialValues({
        'pendingAnalyticsEvents': [
          'not json',
          '{"name":"ok","params":{"a":1}}',
        ],
      });
      final fresh = PendingAnalyticsQueue(
        PreferencesStorage(await SharedPreferences.getInstance()),
      );

      await fresh.flush(analytics);

      expect(analytics.names, ['ok']);
    });
  });

  group('external link target', () {
    test('tells apart the places people open', () {
      expect(ExternalLinkTarget.of(Uri.parse('tel:+201000000000')), 'phone');
      expect(ExternalLinkTarget.of(Uri.parse('mailto:a@b.c')), 'email');
      expect(
        ExternalLinkTarget.of(Uri.parse('https://wa.me/201000000000')),
        'whatsapp',
      );
      expect(
        ExternalLinkTarget.of(
          Uri.parse('https://api.whatsapp.com/send?phone=1'),
        ),
        'whatsapp',
      );
      expect(
        ExternalLinkTarget.of(Uri.parse('https://www.google.com/maps?q=1,2')),
        'maps',
      );
      expect(
        ExternalLinkTarget.of(Uri.parse('comgooglemaps://?q=1,2')),
        'maps',
      );
      expect(
        ExternalLinkTarget.of(Uri.parse('https://example.com/terms')),
        'web',
      );
    });
  });
}
