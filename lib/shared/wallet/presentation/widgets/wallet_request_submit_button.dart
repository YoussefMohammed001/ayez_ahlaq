import 'package:flutter/material.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../generated/l10n.dart';
import '../manager/create_wallet_request_state.dart';

class WalletRequestSubmitButton extends StatelessWidget {
  final CreateWalletRequestStatus status;
  final VoidCallback onPressed;

  const WalletRequestSubmitButton({
    super.key,
    required this.status,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryCtaButton(
      label: S().submitWalletRequest,
      isLoading: status == CreateWalletRequestStatus.submitting,
      onPressed: onPressed,
    );
  }
}
