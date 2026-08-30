import 'package:ayez_ahlaq/features/merchant/orders/domain/entities/order_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OrderStatus', () {
    test('maps api values both ways', () {
      for (final status in OrderStatus.values) {
        expect(OrderStatus.fromApi(status.toApi()), status);
      }
    });

    test('falls back to pending for unknown values', () {
      expect(OrderStatus.fromApi('SOMETHING_ELSE'), OrderStatus.pending);
      expect(OrderStatus.fromApi(null), OrderStatus.pending);
    });

    test('marks terminal statuses', () {
      expect(OrderStatus.delivered.isTerminal, isTrue);
      expect(OrderStatus.rejected.isTerminal, isTrue);
      expect(OrderStatus.cancelled.isTerminal, isTrue);
      expect(OrderStatus.pending.isTerminal, isFalse);
      expect(OrderStatus.preparing.isTerminal, isFalse);
    });

    test('only pending needs a decision', () {
      expect(OrderStatus.pending.needsDecision, isTrue);
      expect(OrderStatus.accepted.needsDecision, isFalse);
    });
  });
}
