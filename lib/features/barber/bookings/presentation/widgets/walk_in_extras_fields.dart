import 'package:flutter/material.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_drink.dart';
import 'walk_in_addons_field.dart';
import 'walk_in_drinks_field.dart';
import 'walk_in_slot_time_field.dart';

class WalkInExtrasFields extends StatelessWidget {
  final String? slotTime;
  final ValueChanged<String?> onSlotTimeChanged;
  final ValueNotifier<List<BookingDrink>> drinks;
  final ValueNotifier<List<BookingAddon>> addons;

  const WalkInExtrasFields({
    super.key,
    required this.slotTime,
    required this.onSlotTimeChanged,
    required this.drinks,
    required this.addons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().walkInSlotTimeLabel),
        WalkInSlotTimeField(slotTime: slotTime, onChanged: onSlotTimeChanged),
        SectionTitle(title: S().drinksTitle),
        WalkInDrinksField(drinks: drinks),
        SectionTitle(title: S().walkInAddonsLabel),
        WalkInAddonsField(addons: addons),
      ],
    );
  }
}
