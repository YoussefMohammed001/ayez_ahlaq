import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/analytics/api_param_extractor.dart';

void main() {
  test('keeps the check-in method and other safe fields', () {
    final params = ApiParamExtractor.extract({
      'lat': 30.0,
      'lng': 31.0,
      'method': 'AUTO',
      'status': 'DONE',
      'paymentMethod': 'WALLET',
    });

    expect(params, {
      'method': 'AUTO',
      'status': 'DONE',
      'payment_method': 'WALLET',
    });
  });

  test('never copies coordinates, names, notes or other free text', () {
    final params = ApiParamExtractor.extract({
      'lat': 30.0,
      'phoneNumber': '01000000000',
      'name': 'كريم',
      'note': 'تعديل الوردية',
      'method': 'two words',
    });

    expect(params, isEmpty);
  });

  test('turns booleans into text and keeps numbers', () {
    expect(ApiParamExtractor.extract({'enabled': true}), {'enabled': 'true'});
    expect(ApiParamExtractor.extract({'type': 3}), {'type': 3});
  });

  test('drops values that are too long to be a label', () {
    expect(ApiParamExtractor.extract({'type': 'A' * 41}), isEmpty);
  });

  test('copes with bodies that are not maps', () {
    expect(ApiParamExtractor.extract(null), isEmpty);
    expect(ApiParamExtractor.extract('text'), isEmpty);
  });
}
