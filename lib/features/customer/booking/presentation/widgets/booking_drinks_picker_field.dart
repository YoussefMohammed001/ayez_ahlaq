import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/quantity_picker_sheet.dart';
import '../../../../../shared/widgets/quantity_picker_trigger.dart';
import '../../../shops/domain/entities/shop_drink.dart';
import '../../domain/entities/booking_drink.dart';
import '../manager/booking_flow_cubit.dart';

class BookingDrinksPickerField extends StatelessWidget {
  final List<ShopDrink> shopDrinks;
  final List<BookingDrink> selectedDrinks;
  final void Function(ShopDrink drink, int quantity) onQuantityChanged;

  const BookingDrinksPickerField({
    super.key,
    required this.shopDrinks,
    required this.selectedDrinks,
    required this.onQuantityChanged,
  });

  int _quantityFor(BuildContext context, int drinkId) {
    final match = context.read<BookingFlowCubit>().state.drinks.where(
      (d) => d.drinkId == drinkId,
    );
    return match.isEmpty ? 0 : match.first.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return QuantityPickerTrigger(
      chips: [
        for (final drink in selectedDrinks)
          QuantityPickerChip(
            id: drink.drinkId,
            label: drink.name ?? '',
            quantity: drink.quantity,
            price: drink.price ?? 0,
            onRemove: () {
              final shopDrink = shopDrinks.firstWhere(
                (d) => d.id == drink.drinkId,
              );
              onQuantityChanged(shopDrink, 0);
            },
          ),
      ],
      onTap: () => QuantityPickerSheet.show<ShopDrink>(
        context,
        title: S().drinksTitle,
        items: shopDrinks,
        nameOf: (drink) => drink.name,
        priceOf: (drink) => drink.price,
        quantityOf: (drink) => _quantityFor(context, drink.id),
        onQuantityChanged: onQuantityChanged,
      ),
    );
  }
}
