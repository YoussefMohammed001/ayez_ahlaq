import 'package:flutter/material.dart';
import '../../../../../core/widgets/option_tile.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/location_picker_field.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/fulfillment_type.dart';
import 'fulfillment_type_label.dart';

class StoreFulfillmentSection extends StatelessWidget {
  final Cart cart;
  final FulfillmentType? fulfillmentType;
  final TextEditingController addressController;
  final double? deliveryLat;
  final double? deliveryLng;
  final ValueChanged<FulfillmentType> onTypeChanged;
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
    final isDelivery = fulfillmentType == FulfillmentType.delivery;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().fulfilmentTitle),
        OptionTile(
          label: FulfillmentType.delivery.label,
          icon: Icons.local_shipping_outlined,
          selected: isDelivery,
          enabled: cart.deliveryOffered,
          disabledReason: S().deliveryNotOfferedReason,
          onTap: () => onTypeChanged(FulfillmentType.delivery),
        ),
        OptionTile(
          label: FulfillmentType.pickupAtBranch.label,
          icon: Icons.storefront_outlined,
          selected: fulfillmentType == FulfillmentType.pickupAtBranch,
          onTap: () => onTypeChanged(FulfillmentType.pickupAtBranch),
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
