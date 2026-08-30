import '../../../../../generated/l10n.dart';
import '../../domain/entities/fulfilment_type.dart';

extension FulfilmentTypeLabel on FulfilmentType {
  String get label => switch (this) {
    FulfilmentType.delivery => S().fulfilmentDelivery,
    FulfilmentType.pickupAtBranch => S().fulfilmentPickup,
  };
}
