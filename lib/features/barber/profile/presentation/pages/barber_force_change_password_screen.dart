import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/auth/presentation/widgets/force_change_password_view.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/barber_profile_cubit.dart';
import '../manager/barber_profile_state.dart';

class BarberForceChangePasswordScreen extends StatelessWidget {
  const BarberForceChangePasswordScreen({super.key});

  Future<bool> _submit(
    BuildContext context,
    String current,
    String updated,
  ) async {
    final cubit = context.read<BarberProfileCubit>();
    final changed = await cubit.changePassword(current, updated);

    if (!context.mounted) return changed;

    if (changed) {
      showSuccess(S().passwordChanged);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<BarberProfileCubit, BarberProfileState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: BlocBuilder<BarberProfileCubit, BarberProfileState>(
        builder: (context, state) => ForceChangePasswordView(
          isSubmitting: state.isSubmitting,
          onSubmit: (current, updated) => _submit(context, current, updated),
        ),
      ),
    );
  }
}
