import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../../../shops/domain/entities/shop_addon.dart';
import '../../domain/entities/booking_addon.dart';

class BookingAddonsField extends StatelessWidget {
  final List<ShopAddon> shopAddons;
  final List<BookingAddon> selectedAddons;
  final void Function(ShopAddon addon, int quantity) onQuantityChanged;

  const BookingAddonsField({
    super.key,
    required this.shopAddons,
    required this.selectedAddons,
    required this.onQuantityChanged,
  });

  int _quantityFor(int addonId) {
    final match = selectedAddons.where((a) => a.productId == addonId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final addon in shopAddons)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${addon.name} · ${S().currencyEgp(addon.price)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13.sp, color: scheme.onSurface),
                  ),
                ),
                QuantityStepper(
                  quantity: _quantityFor(addon.id),
                  onChanged: (value) => onQuantityChanged(addon, value),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
