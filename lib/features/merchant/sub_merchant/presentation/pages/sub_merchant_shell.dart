import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/blocking_gate.dart';
import '../../../team/presentation/manager/my_merchant_member_cubit.dart';
import '../../../team/presentation/manager/my_merchant_member_state.dart';
import '../../../team/presentation/pages/member_force_change_password_screen.dart';
import '../widgets/sub_merchant_tabs.dart';

class SubMerchantShell extends StatefulWidget {
  final Future<void> Function() onLogout;

  const SubMerchantShell({super.key, required this.onLogout});

  @override
  State<SubMerchantShell> createState() => _SubMerchantShellState();
}

class _SubMerchantShellState extends State<SubMerchantShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<MyMerchantMemberCubit>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyMerchantMemberCubit, MyMerchantMemberState>(
      buildWhen: (previous, current) =>
          previous.mustChangePassword != current.mustChangePassword,
      builder: (context, state) => BlockingGate(
        isBlocked: state.mustChangePassword,
        title: S().forceChangePasswordTitle,
        onLogout: widget.onLogout,
        blockedBuilder: (_) => const MemberForceChangePasswordScreen(),
        builder: (_) => SubMerchantTabs(onLogout: widget.onLogout),
      ),
    );
  }
}
