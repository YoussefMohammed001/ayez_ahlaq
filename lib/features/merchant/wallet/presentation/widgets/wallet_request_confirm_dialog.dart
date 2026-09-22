import 'package:flutter/material.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../generated/l10n.dart';

abstract class WalletRequestConfirmDialog {
  static Future<bool> show(
    BuildContext context, {
    required bool isDeposit,
    required int amount,
  }) {
    return showConfirmDialog(
      context,
      title: isDeposit
          ? S().confirmWalletRequestDepositTitle
          : S().confirmWalletRequestWithdrawTitle,
      message: S().confirmWalletRequestMessage(S().currencyEgp(amount)),
      confirmLabel: isDeposit
          ? S().walletRequestTypeDeposit
          : S().walletRequestTypeWithdraw,
      icon: Icons.account_balance_wallet_outlined,
      isDestructive: !isDeposit,
    );
  }
}
