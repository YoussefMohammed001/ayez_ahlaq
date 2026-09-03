import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_fulfillment_type.dart';

extension StorefrontFulfillmentTypeLabel on StorefrontFulfillmentType {
  String get label => switch (this) {
    StorefrontFulfillmentType.delivery => S().fulfilmentDelivery,
    StorefrontFulfillmentType.pickupAtBranch => S().fulfilmentPickup,
  };
}
