import 'package:flutter/material.dart';
import '../../../../../core/widgets/option_tile.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/location_picker_field.dart';
import '../../domain/entities/store_cart.dart';
import '../../domain/entities/store_fulfillment_type.dart';
import 'store_fulfillment_type_label.dart';

class StoreFulfillmentSection extends StatelessWidget {
  final StoreCart cart;
  final StoreFulfillmentType? fulfillmentType;
  final TextEditingController addressController;
  final double? deliveryLat;
  final double? deliveryLng;
  final ValueChanged<StoreFulfillmentType> onTypeChanged;
  final void Function(double lat, double lng) onLocationPicked;

  const StoreFulfillmentSection({
    super.key,
    required this.cart,
    required this.fulfillmentType,
    required this.addressController,
    required this.deliveryLat,
    required this.deliveryLng,
    required this.onTypeChanged,
    required this.onLocationPicked,
  });

  @override
  Widget build(BuildContext context) {
    final isDelivery = fulfillmentType == StoreFulfillmentType.delivery;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().fulfilmentTitle),
        OptionTile(
          label: StoreFulfillmentType.delivery.label,
          icon: Icons.local_shipping_outlined,
          selected: isDelivery,
          enabled: cart.deliveryOffered,
          disabledReason: S().deliveryNotOfferedReason,
          onTap: () => onTypeChanged(StoreFulfillmentType.delivery),
        ),
        OptionTile(
          label: StoreFulfillmentType.pickupAtBranch.label,
          icon: Icons.storefront_outlined,
          selected: fulfillmentType == StoreFulfillmentType.pickupAtBranch,
          onTap: () => onTypeChanged(StoreFulfillmentType.pickupAtBranch),
        ),
        if (isDelivery) ...[
          SectionTitle(title: S().orderDeliveryAddressLabel),
          LocationPickerField(
            addressController: addressController,
            latitude: deliveryLat,
            longitude: deliveryLng,
            onLocationPicked: onLocationPicked,
          ),
        ],
      ],
    );
  }
}
