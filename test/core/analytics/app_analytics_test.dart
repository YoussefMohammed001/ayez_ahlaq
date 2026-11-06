import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/analytics/app_analytics.dart';
import '../../support/recording_analytics.dart';

final _validName = RegExp(r'^[A-Za-z][A-Za-z0-9_]{0,39}$');

void main() {
  late RecordingAnalytics recorder;
  late AppAnalytics analytics;

  setUp(() {
    recorder = RecordingAnalytics();
    analytics = AppAnalytics(recorder);
  });

  test('every client event has a valid name and safe parameters', () async {
    await analytics.tourStarted('first_run');
    await analytics.tourCompleted();
    await analytics.tourSkipped();
    await analytics.setupStepOpened('hours');
    await analytics.setupCompleted();
    await analytics.helpOpened();
    await analytics.helpQuestionOpened(2);
    await analytics.helpTourRequested();
    await analytics.autoAttendanceToggled(enabled: true, result: 'enabled');
    await analytics.languageChanged('en');
    await analytics.themeChanged('dark');
    await analytics.externalLinkOpened('whatsapp');
    await analytics.locationPicked('map_picker');
    await analytics.shopViewed(5);
    await analytics.loggedOut('barber');

    expect(recorder.events, hasLength(15));
    for (final event in recorder.events) {
      expect(_validName.hasMatch(event.name), isTrue, reason: event.name);
      expect(event.parameters.length, lessThanOrEqualTo(25));
      for (final value in event.parameters.values) {
        expect(value is String || value is num, isTrue, reason: '$event');
      }
    }
  });

  test('carries the details dashboards need', () async {
    await analytics.setupStepOpened('documents');
    await analytics.shopViewed(8);
    await analytics.autoAttendanceToggled(enabled: false, result: 'disabled');

    expect(recorder.events.map((e) => e.parameters), [
      {'step': 'documents'},
      {'shop_id': 8},
      {'enabled': 'false', 'result': 'disabled'},
    ]);
  });
}
