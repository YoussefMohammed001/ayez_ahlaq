import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/quantity_picker_sheet.dart';
import '../../../../../shared/widgets/quantity_picker_trigger.dart';
import '../../../shops/domain/entities/shop_addon.dart';
import '../../domain/entities/booking_addon.dart';
import '../manager/booking_flow_cubit.dart';

class BookingAddonsPickerField extends StatelessWidget {
  final List<ShopAddon> shopAddons;
  final List<BookingAddon> selectedAddons;
  final void Function(ShopAddon addon, int quantity) onQuantityChanged;

  const BookingAddonsPickerField({
    super.key,
    required this.shopAddons,
    required this.selectedAddons,
    required this.onQuantityChanged,
  });

  int _quantityFor(BuildContext context, int productId) {
    final match = context
        .read<BookingFlowCubit>()
        .state
        .addons
        .where((a) => a.productId == productId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return QuantityPickerTrigger(
      chips: [
        for (final addon in selectedAddons)
          QuantityPickerChip(
            id: addon.productId,
            label: addon.name ?? '',
            quantity: addon.quantity,
            price: addon.price ?? 0,
            onRemove: () {
              final shopAddon = shopAddons.firstWhere((a) => a.id == addon.productId);
              onQuantityChanged(shopAddon, 0);
            },
          ),
      ],
      onTap: () => QuantityPickerSheet.show<ShopAddon>(
        context,
        title: S().walkInAddonsLabel,
        items: shopAddons,
        nameOf: (addon) => addon.name,
        priceOf: (addon) => addon.price,
        quantityOf: (addon) => _quantityFor(context, addon.id),
        onQuantityChanged: onQuantityChanged,
      ),
    );
  }
}
