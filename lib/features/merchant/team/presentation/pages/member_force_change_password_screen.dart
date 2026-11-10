import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/auth/presentation/widgets/force_change_password_view.dart';
import '../manager/my_merchant_member_cubit.dart';
import '../manager/my_merchant_member_state.dart';

class MemberForceChangePasswordScreen extends StatelessWidget {
  const MemberForceChangePasswordScreen({super.key});

  Future<bool> _submit(
    BuildContext context,
    String current,
    String updated,
  ) async {
    final cubit = context.read<MyMerchantMemberCubit>();
    final changed = await cubit.changePassword(current, updated);

    if (!context.mounted) return changed;

    if (changed) {
      showSuccess(S().passwordChanged);
      return true;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyMerchantMemberCubit, MyMerchantMemberState>(
      builder: (context, state) => ForceChangePasswordView(
        isSubmitting: state.isSubmitting,
        onSubmit: (current, updated) => _submit(context, current, updated),
      ),
    );
  }
}
