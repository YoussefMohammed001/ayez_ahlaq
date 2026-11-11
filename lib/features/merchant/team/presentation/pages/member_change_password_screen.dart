import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/auth/presentation/widgets/change_password_form.dart';
import '../manager/my_merchant_member_cubit.dart';
import '../manager/my_merchant_member_state.dart';

class MemberChangePasswordScreen extends StatelessWidget {
  const MemberChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyMerchantMemberCubit>();

    return BlocBuilder<MyMerchantMemberCubit, MyMerchantMemberState>(
      builder: (context, state) => ChangePasswordForm(
        isSubmitting: state.isSubmitting,
        onSubmit: cubit.changePassword,
        errorMessage: () => cubit.state.errorMessage,
      ),
    );
  }
}
