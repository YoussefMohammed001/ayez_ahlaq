import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_fulfillment_type.dart';

extension StoreFulfillmentTypeLabel on StoreFulfillmentType {
  String get label => switch (this) {
    StoreFulfillmentType.delivery => S().fulfilmentDelivery,
    StoreFulfillmentType.pickupAtBranch => S().fulfilmentPickup,
  };
}
