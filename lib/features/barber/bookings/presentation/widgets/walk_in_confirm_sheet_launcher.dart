import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_drink.dart';
import '../../domain/entities/walk_in_option.dart';
import '../manager/bookings_cubit.dart';
import '../manager/bookings_state.dart';
import 'walk_in_confirm_sheet.dart';

Future<void> showWalkInConfirmSheet(
  BuildContext context, {
  required WalkInOption? option,
  required int? barberId,
  required List<BookingDrink> drinks,
  required List<BookingAddon> addons,
  required void Function(BuildContext sheetContext) onConfirm,
}) {
  final bookingsCubit = context.read<BookingsCubit>();
  final barberOption =
      option?.barbers.where((b) => b.barberId == barberId).firstOrNull;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => BlocBuilder<BookingsCubit, BookingsState>(
      bloc: bookingsCubit,
      builder: (_, state) => WalkInConfirmSheet(
        serviceName: option?.name ?? '',
        servicePrice: barberOption?.price ?? 0,
        drinks: drinks,
        addons: addons,
        isLoading: state.isSubmittingWalkIn,
        onConfirm: () => onConfirm(sheetContext),
      ),
    ),
  );
}
