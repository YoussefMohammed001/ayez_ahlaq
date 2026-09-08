import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_order.dart';

extension StoreOrderItemsLabel on StoreOrder {
  String get itemsLabel =>
      items.map((i) => '${i.quantity}× ${i.productName}').join(S().listSeparator);
}
