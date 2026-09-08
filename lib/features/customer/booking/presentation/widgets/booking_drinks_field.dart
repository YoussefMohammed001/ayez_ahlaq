import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../../../shops/domain/entities/shop_drink.dart';
import '../../domain/entities/booking_drink.dart';

class BookingDrinksField extends StatelessWidget {
  final List<ShopDrink> shopDrinks;
  final List<BookingDrink> selectedDrinks;
  final void Function(ShopDrink drink, int quantity) onQuantityChanged;

  const BookingDrinksField({
    super.key,
    required this.shopDrinks,
    required this.selectedDrinks,
    required this.onQuantityChanged,
  });

  int _quantityFor(int drinkId) {
    final match = selectedDrinks.where((d) => d.drinkId == drinkId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final drink in shopDrinks)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${drink.name} · ${S().currencyEgp(drink.price)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13.sp, color: scheme.onSurface),
                  ),
                ),
                QuantityStepper(
                  quantity: _quantityFor(drink.id),
                  onChanged: (value) => onQuantityChanged(drink, value),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
