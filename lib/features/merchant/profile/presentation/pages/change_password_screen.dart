import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/auth/presentation/widgets/change_password_form.dart';
import '../manager/merchant_profile_cubit.dart';
import '../manager/merchant_profile_state.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MerchantProfileCubit>();

    return BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
      builder: (context, state) => ChangePasswordForm(
        isSubmitting: state.isSubmitting,
        onSubmit: cubit.changePassword,
        errorMessage: () => cubit.state.errorMessage,
      ),
    );
  }
}
