import '../../../../../generated/l10n.dart';
import '../../domain/entities/purchase_order.dart';

extension OrderItemsLabel on PurchaseOrder {
  String get itemsLabel => items
      .map((i) => '${i.quantity}× ${i.productName}')
      .join(S().listSeparator);
}
