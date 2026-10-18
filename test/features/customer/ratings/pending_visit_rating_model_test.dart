import 'package:ayez_ahlaq/features/customer/ratings/data/models/pending_visit_rating_model.dart';
import 'package:ayez_ahlaq/features/customer/ratings/domain/entities/pending_rating_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final booking = {
    'kind': 'BOOKING',
    'referenceId': 122,
    'shopName': "Men's Club",
    'barberName': 'كريم',
    'canRateBarber': true,
    'canRateShop': false,
  };

  test('null data means nothing pending', () {
    expect(PendingVisitRatingModel.fromResponseData(null), isNull);
  });

  test('booking reads referenceId and rate flags', () {
    final model = PendingVisitRatingModel.fromResponseData(booking);
    expect(model?.kind, PendingRatingKind.booking);
    expect(model?.referenceId, 122);
    expect(model?.canRateBarber, isTrue);
    expect(model?.canRateShop, isFalse);
  });

  test('order has a null barber and rates the shop only', () {
    final model = PendingVisitRatingModel.fromResponseData({
      'kind': 'ORDER',
      'referenceId': 75,
      'shopName': "Men's Club",
      'barberName': null,
      'canRateBarber': false,
      'canRateShop': true,
    });
    expect(model?.kind, PendingRatingKind.order);
    expect(model?.referenceId, 75);
    expect(model?.barberName, '');
    expect(model?.canRateBarber, isFalse);
  });

  test('unknown kinds are ignored', () {
    expect(
      PendingVisitRatingModel.fromResponseData({...booking, 'kind': 'HOME_SERVICE'}),
      isNull,
    );
  });

  test('nothing rateable means no prompt', () {
    expect(
      PendingVisitRatingModel.fromResponseData({
        ...booking,
        'canRateBarber': false,
      }),
      isNull,
    );
  });
}
