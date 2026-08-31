import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/merchant/delivery/data/models/delivery_settings_model.dart';
import 'package:ayez_ahlaq/features/merchant/delivery/domain/entities/delivery_settings.dart';
import 'package:ayez_ahlaq/features/merchant/orders/data/models/purchase_order_model.dart';
import 'package:ayez_ahlaq/features/merchant/orders/domain/entities/fulfilment_type.dart';

void main() {
  test('parses live delivery payload', () {
    final s = DeliverySettingsModel.fromJson(
      {'offered': true, 'fee': 25, 'freeOver': 300},
    );
    expect(s.offered, isTrue);
    expect(s.fee, 25);
    expect(s.freeOver, 300);
    expect(s.hasFreeThreshold, isTrue);
  });

  test('parses freeOver null', () {
    final s = DeliverySettingsModel.fromJson(
      {'offered': true, 'fee': 25, 'freeOver': null},
    );
    expect(s.hasFreeThreshold, isFalse);
  });

  test('always sends fee, as the backend requires', () {
    expect(
      DeliverySettingsModel.toJson(const DeliverySettings.disabled()),
      {'offered': false, 'fee': 0, 'freeOver': null},
    );
    expect(
      DeliverySettingsModel.toJson(
        const DeliverySettings(offered: true, fee: 25, freeOver: 300),
      ),
      {'offered': true, 'fee': 25, 'freeOver': 300},
    );
    expect(
      DeliverySettingsModel.toJson(
        const DeliverySettings(offered: true, fee: 25, freeOver: 0),
      ),
      {'offered': true, 'fee': 25, 'freeOver': null},
    );
  });

  test('parses live order payload including delivery fields', () {
    final o = PurchaseOrderModel.fromJson({
      'id': 1,
      'code': 'PO-373785',
      'status': 'PENDING',
      'shopName': 'احمد',
      'barberName': 'صالون بلطيم',
      'fulfillmentType': 'PICKUP_AT_BRANCH',
      'total': 990,
      'deliveryFee': 0,
      'grandTotal': 990,
      'orderDiscount': 10,
      'items': const [],
      'nextStatuses': const [],
    });
    expect(o.fulfilmentType, FulfilmentType.pickupAtBranch);
    expect(o.deliveryFee, 0);
    expect(o.grandTotal, 990);
  });

  test('grandTotal falls back to total + fee when absent', () {
    final o = PurchaseOrderModel.fromJson({
      'id': 2,
      'fulfillmentType': 'DELIVERY',
      'total': 500,
      'deliveryFee': 25,
      'items': const [],
      'nextStatuses': const [],
    });
    expect(o.fulfilmentType, FulfilmentType.delivery);
    expect(o.grandTotal, 525);
    expect(o.hasDeliveryFee, isTrue);
  });
}
