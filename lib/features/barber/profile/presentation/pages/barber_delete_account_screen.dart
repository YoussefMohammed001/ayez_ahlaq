import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/auth/presentation/widgets/delete_account_view.dart';
import '../manager/barber_profile_cubit.dart';
import '../manager/barber_profile_state.dart';

class BarberDeleteAccountScreen extends StatelessWidget {
  const BarberDeleteAccountScreen({super.key});

  Future<void> _confirm(BuildContext context, String password) async {
    final cubit = context.read<BarberProfileCubit>();
    final deleted = await cubit.deleteAccount(password);

    if (!context.mounted) return;

    if (deleted) {
      showSuccess(S().accountDeleted);
      context.go(Routes.userTypeScreen);
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().deleteAccount),
      body: BlocBuilder<BarberProfileCubit, BarberProfileState>(
        builder: (context, state) => DeleteAccountView(
          isSubmitting: state.isSubmitting,
          onConfirm: (password) => _confirm(context, password),
        ),
      ),
    );
  }
}
