import 'package:flutter/material.dart';
import '../../domain/entities/booking_addon.dart';
import 'booking_extra_line.dart';
import 'booking_extra_lines_list.dart';

class BookingExtrasSummary extends StatelessWidget {
  final List<BookingAddon> addons;

  const BookingExtrasSummary({super.key, required this.addons});

  @override
  Widget build(BuildContext context) {
    return BookingExtraLinesList(
      lines: [
        for (final addon in addons)
          BookingExtraLine(
            name: addon.name,
            quantity: addon.quantity,
            price: addon.price,
            isDrink: addon.isDrink,
          ),
      ],
    );
  }
}
