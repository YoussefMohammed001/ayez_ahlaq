import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../storefront/products/domain/entities/storefront_product.dart';
import '../../../storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../../../storefront/products/presentation/manager/barber_storefront_products_state.dart';
import '../../domain/entities/booking_addon.dart';
import 'walk_in_picker_trigger.dart';
import 'walk_in_quantity_picker_sheet.dart';

class WalkInAddonsField extends StatefulWidget {
  final ValueNotifier<List<BookingAddon>> addons;

  const WalkInAddonsField({super.key, required this.addons});

  @override
  State<WalkInAddonsField> createState() => _WalkInAddonsFieldState();
}

class _WalkInAddonsFieldState extends State<WalkInAddonsField> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<BarberStorefrontProductsCubit>();
    if (cubit.state.products.isEmpty) cubit.loadProducts();
  }

  int _quantityFor(int productId) {
    final match = widget.addons.value.where((a) => a.productId == productId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  void _setQuantity(StorefrontProduct product, int quantity) {
    final next = widget.addons.value.where((a) => a.productId != product.id).toList();
    if (quantity > 0) {
      next.add(
        BookingAddon(
          productId: product.id,
          quantity: quantity,
          name: product.name,
          price: product.effectivePrice,
        ),
      );
    }
    widget.addons.value = next;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberStorefrontProductsCubit, BarberStorefrontProductsState>(
      builder: (context, state) {
        final products = state.products.where((p) => p.active).toList();

        if (products.isEmpty) return const SizedBox.shrink();

        return ValueListenableBuilder<List<BookingAddon>>(
          valueListenable: widget.addons,
          builder: (context, selected, _) {
            return WalkInPickerTrigger(
              chips: [
                for (final addon in selected)
                  WalkInPickerChip(
                    label: addon.name ?? '',
                    quantity: addon.quantity,
                    price: addon.price ?? 0,
                    onRemove: () => widget.addons.value =
                        selected.where((a) => a.productId != addon.productId).toList(),
                  ),
              ],
              onTap: () => WalkInQuantityPickerSheet.show<StorefrontProduct>(
                context,
                title: S().walkInAddonsLabel,
                items: products,
                nameOf: (product) => product.name,
                priceOf: (product) => product.effectivePrice,
                quantityOf: (product) => _quantityFor(product.id),
                onQuantityChanged: _setQuantity,
              ),
            );
          },
        );
      },
    );
  }
}
