import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/transfer_account.dart';
import '../../domain/entities/wallet_request_type.dart';
import '../../domain/entities/withdraw_method.dart';
import '../manager/create_wallet_request_state.dart';
import 'wallet_request_form_fields.dart';
import 'wallet_request_submit_button.dart';

class WalletRequestFormBody extends StatelessWidget {
  final CreateWalletRequestState state;
  final TextEditingController amountController;
  final TextEditingController noteController;
  final TextEditingController withdrawAccountController;
  final WalletRequestType type;
  final ValueChanged<WalletRequestType> onTypeChanged;
  final String? filePath;
  final VoidCallback onPickAttachment;
  final int? selectedTransferAccountId;
  final ValueChanged<int> onTransferAccountChanged;
  final bool showTransferAccountError;
  final int? selectedWithdrawMethodId;
  final ValueChanged<int> onWithdrawMethodChanged;
  final bool showWithdrawMethodError;
  final VoidCallback onSubmit;

  const WalletRequestFormBody({
    super.key,
    required this.state,
    required this.amountController,
    required this.noteController,
    required this.withdrawAccountController,
    required this.type,
    required this.onTypeChanged,
    required this.filePath,
    required this.onPickAttachment,
    required this.selectedTransferAccountId,
    required this.onTransferAccountChanged,
    required this.showTransferAccountError,
    required this.selectedWithdrawMethodId,
    required this.onWithdrawMethodChanged,
    required this.showWithdrawMethodError,
    required this.onSubmit,
  });

  List<TransferAccount> get _transferAccounts => state.transferAccounts;

  List<WithdrawMethod> get _withdrawMethods => state.withdrawMethods;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
      children: [
        WalletRequestFormFields(
          amountController: amountController,
          noteController: noteController,
          withdrawAccountController: withdrawAccountController,
          type: type,
          onTypeChanged: onTypeChanged,
          filePath: filePath,
          onPickAttachment: onPickAttachment,
          transferAccounts: _transferAccounts,
          selectedTransferAccountId: selectedTransferAccountId,
          onTransferAccountChanged: onTransferAccountChanged,
          showTransferAccountError: showTransferAccountError,
          withdrawMethods: _withdrawMethods,
          selectedWithdrawMethodId: selectedWithdrawMethodId,
          onWithdrawMethodChanged: onWithdrawMethodChanged,
          showWithdrawMethodError: showWithdrawMethodError,
        ),
        SizedBox(height: 20.h),
        WalletRequestSubmitButton(status: state.status, onPressed: onSubmit),
      ],
    );
  }
}
