import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../drinks/domain/entities/drink.dart';
import '../../../drinks/presentation/manager/barber_drinks_cubit.dart';
import '../../../drinks/presentation/manager/barber_drinks_state.dart';
import '../../domain/entities/booking_drink.dart';
import 'walk_in_picker_trigger.dart';
import 'walk_in_quantity_picker_sheet.dart';

class WalkInDrinksField extends StatefulWidget {
  final ValueNotifier<List<BookingDrink>> drinks;

  const WalkInDrinksField({super.key, required this.drinks});

  @override
  State<WalkInDrinksField> createState() => _WalkInDrinksFieldState();
}

class _WalkInDrinksFieldState extends State<WalkInDrinksField> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<BarberDrinksCubit>();
    if (cubit.state.drinks.isEmpty) cubit.loadDrinks();
  }

  int _quantityFor(int drinkId) {
    final match = widget.drinks.value.where((d) => d.drinkId == drinkId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  void _setQuantity(Drink drink, int quantity) {
    final next = widget.drinks.value.where((d) => d.drinkId != drink.id).toList();
    if (quantity > 0) {
      next.add(
        BookingDrink(
          drinkId: drink.id,
          quantity: quantity,
          name: drink.name,
          price: drink.price,
        ),
      );
    }
    widget.drinks.value = next;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberDrinksCubit, BarberDrinksState>(
      builder: (context, state) {
        final drinks = state.drinks.where((d) => d.active).toList();

        if (drinks.isEmpty) return const SizedBox.shrink();

        return ValueListenableBuilder<List<BookingDrink>>(
          valueListenable: widget.drinks,
          builder: (context, selected, _) {
            return WalkInPickerTrigger(
              chips: [
                for (final drink in selected)
                  WalkInPickerChip(
                    label: drink.name ?? '',
                    quantity: drink.quantity,
                    price: drink.price ?? 0,
                    onRemove: () => widget.drinks.value =
                        selected.where((d) => d.drinkId != drink.drinkId).toList(),
                  ),
              ],
              onTap: () => WalkInQuantityPickerSheet.show<Drink>(
                context,
                title: S().drinksTitle,
                items: drinks,
                nameOf: (drink) => drink.name,
                priceOf: (drink) => drink.price,
                quantityOf: (drink) => _quantityFor(drink.id),
                onQuantityChanged: _setQuantity,
              ),
            );
          },
        );
      },
    );
  }
}
