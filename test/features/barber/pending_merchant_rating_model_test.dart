import 'package:ayez_ahlaq/features/barber/ratings/data/models/pending_merchant_rating_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('null data means nothing pending', () {
    expect(PendingMerchantRatingModel.fromResponseData(null), isNull);
  });

  test('reads the delivered order', () {
    final model = PendingMerchantRatingModel.fromResponseData({
      'orderId': 74,
      'code': 'PO-919045',
      'merchantName': 'متجر الحلاقة للجملة',
    });
    expect(model?.orderId, 74);
    expect(model?.code, 'PO-919045');
    expect(model?.merchantName, 'متجر الحلاقة للجملة');
  });
}
