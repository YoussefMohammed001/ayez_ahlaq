import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../manager/bookings_cubit.dart';
import '../manager/bookings_state.dart';

class WalkInSubmitButton extends StatelessWidget {
  final void Function(BookingsState state) onSubmit;

  const WalkInSubmitButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      builder: (context, state) => PrimaryCtaButton(
        label: S().addWalkInAction,
        isLoading: state.isSubmittingWalkIn,
        onPressed: () => onSubmit(state),
      ),
    );
  }
}
