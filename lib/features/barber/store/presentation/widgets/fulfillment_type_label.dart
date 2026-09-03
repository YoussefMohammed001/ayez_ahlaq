import '../../../../../generated/l10n.dart';
import '../../domain/entities/fulfillment_type.dart';

extension FulfillmentTypeLabel on FulfillmentType {
  String get label => switch (this) {
    FulfillmentType.delivery => S().fulfilmentDelivery,
    FulfillmentType.pickupAtBranch => S().fulfilmentPickup,
  };
}
