import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/services_locator.dart';
import '../../../drinks/presentation/manager/barber_drinks_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../manager/bookings_cubit.dart';
import '../manager/walk_in_options_cubit.dart';
import 'add_walk_in_sheet.dart';

Future<void> showAddWalkInSheet(BuildContext context) {
  final profile = context.read<BarberProfileCubit>().state.profile;
  final isOwner = profile?.owner ?? false;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<BookingsCubit>()),
        BlocProvider.value(value: context.read<BarberStorefrontProductsCubit>()),
        BlocProvider(create: (_) => sl<BarberDrinksCubit>()),
        BlocProvider(create: (_) => sl<WalkInOptionsCubit>()..loadOptions()),
      ],
      child: AddWalkInSheet(isOwner: isOwner, ownBarberId: profile?.id),
    ),
  );
}
