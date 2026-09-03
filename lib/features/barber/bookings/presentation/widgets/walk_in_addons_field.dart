import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../storefront/products/domain/entities/storefront_product.dart';
import '../../../storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../../../storefront/products/presentation/manager/barber_storefront_products_state.dart';
import '../../../store/presentation/widgets/quantity_stepper.dart';
import '../../domain/entities/booking_addon.dart';

class WalkInAddonsField extends StatefulWidget {
  final List<BookingAddon> addons;
  final ValueChanged<List<BookingAddon>> onChanged;

  const WalkInAddonsField({
    super.key,
    required this.addons,
    required this.onChanged,
  });

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
    final match = widget.addons.where((a) => a.productId == productId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  void _setQuantity(StorefrontProduct product, int quantity) {
    final next = widget.addons.where((a) => a.productId != product.id).toList();
    if (quantity > 0) {
      next.add(
        BookingAddon(productId: product.id, quantity: quantity, name: product.name),
      );
    }
    widget.onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberStorefrontProductsCubit, BarberStorefrontProductsState>(
      builder: (context, state) {
        final products = state.products.where((p) => p.active).toList();

        if (products.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final product in products)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    QuantityStepper(
                      quantity: _quantityFor(product.id),
                      onChanged: (value) => _setQuantity(product, value),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
