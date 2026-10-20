import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/booking_detail_cubit.dart';
import '../manager/booking_detail_state.dart';
import '../manager/my_bookings_cubit.dart';

class BookingListSync extends StatelessWidget {
  final Widget child;

  const BookingListSync({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingDetailCubit, BookingDetailState>(
      listenWhen: (previous, current) =>
          current.booking != null &&
          previous.booking?.id == current.booking!.id &&
          previous.booking != current.booking,
      listener: (context, state) =>
          context.read<MyBookingsCubit>().replace(state.booking!),
      child: child,
    );
  }
}
