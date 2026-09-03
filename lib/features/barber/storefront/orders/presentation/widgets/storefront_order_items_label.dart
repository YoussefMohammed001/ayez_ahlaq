import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_order.dart';

extension StorefrontOrderItemsLabel on StorefrontOrder {
  String get itemsLabel => items
      .map((i) => '${i.quantity}× ${i.productName}')
      .join(S().listSeparator);
}
