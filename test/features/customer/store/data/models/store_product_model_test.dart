import 'package:ayez_ahlaq/features/customer/store/data/models/store_product_model.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _json(Map<String, dynamic> extra) => {
  'id': 1,
  'name': 'p',
  'price': 10,
  ...extra,
};

void main() {
  test('own image counts as an image', () {
    final product = StoreProductModel.fromJson(
      _json({'hasOwnImage': true, 'imageSource': 'OWN'}),
    );
    expect(product.hasImage, isTrue);
  });

  test('category fallback image counts as an image', () {
    final product = StoreProductModel.fromJson(
      _json({'hasOwnImage': false, 'imageSource': 'CATEGORY'}),
    );
    expect(product.hasImage, isTrue);
  });

  test('default image source means no image', () {
    final product = StoreProductModel.fromJson(
      _json({'hasOwnImage': false, 'imageSource': 'DEFAULT'}),
    );
    expect(product.hasImage, isFalse);
  });

  test('falls back to hasOwnImage when imageSource is missing', () {
    expect(StoreProductModel.fromJson(_json({'hasOwnImage': true})).hasImage, isTrue);
    expect(StoreProductModel.fromJson(_json({})).hasImage, isFalse);
  });
}
