import 'package:flutter/material.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/option_tile.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/wallet/domain/entities/transfer_account.dart';
import '../../../../../shared/wallet/domain/entities/wallet_request_type.dart';
import '../../../../../shared/wallet/domain/entities/withdraw_method.dart';
import 'transfer_account_field.dart';
import 'withdraw_method_field.dart';

class WalletRequestFormFields extends StatelessWidget {
  final TextEditingController amountController;
  final TextEditingController noteController;
  final TextEditingController withdrawAccountController;
  final WalletRequestType type;
  final ValueChanged<WalletRequestType> onTypeChanged;
  final String? filePath;
  final VoidCallback onPickAttachment;
  final List<TransferAccount> transferAccounts;
  final int? selectedTransferAccountId;
  final ValueChanged<int> onTransferAccountChanged;
  final bool showTransferAccountError;
  final List<WithdrawMethod> withdrawMethods;
  final int? selectedWithdrawMethodId;
  final ValueChanged<int> onWithdrawMethodChanged;
  final bool showWithdrawMethodError;

  const WalletRequestFormFields({
    super.key,
    required this.amountController,
    required this.noteController,
    required this.withdrawAccountController,
    required this.type,
    required this.onTypeChanged,
    required this.filePath,
    required this.onPickAttachment,
    required this.transferAccounts,
    required this.selectedTransferAccountId,
    required this.onTransferAccountChanged,
    this.showTransferAccountError = false,
    required this.withdrawMethods,
    required this.selectedWithdrawMethodId,
    required this.onWithdrawMethodChanged,
    this.showWithdrawMethodError = false,
  });

  bool get _isDeposit => type == WalletRequestType.deposit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().walletRequestTypeLabel),
        OptionTile(
          label: S().walletRequestTypeDeposit,
          icon: Icons.south_west_rounded,
          selected: _isDeposit,
          onTap: () => onTypeChanged(WalletRequestType.deposit),
        ),
        OptionTile(
          label: S().walletRequestTypeWithdraw,
          icon: Icons.north_east_rounded,
          selected: !_isDeposit,
          onTap: () => onTypeChanged(WalletRequestType.withdraw),
        ),
        if (_isDeposit) ..._depositFields(context) else ..._withdrawFields(context),
        SectionTitle(title: S().walletRequestAmountLabel),
        AppTextField(
          controller: amountController,
          hint: S().walletRequestAmountHint,
          isNumber: true,
          validator: (v) =>
              (v ?? '').trim().isEmpty ? S().walletRequestAmountLabel : null,
        ),
        SectionTitle(title: S().walletRequestNoteLabel),
        AppTextField(
          controller: noteController,
          hint: S().walletRequestNoteHint,
          maxLines: 4,
        ),
        if (_isDeposit) ...[
          SectionTitle(title: S().walletRequestAttachmentLabel),
          OptionTile(
            label: filePath == null ? S().attachReceiptPhoto : S().receiptPhotoAttached,
            icon: Icons.photo_camera_outlined,
            selected: filePath != null,
            onTap: onPickAttachment,
          ),
        ],
      ],
    );
  }

  List<Widget> _depositFields(BuildContext context) {
    if (transferAccounts.isEmpty) return const [];
    return [
      SectionTitle(title: S().transferAccountLabel),
      TransferAccountField(
        accounts: transferAccounts,
        selectedId: selectedTransferAccountId,
        onChanged: onTransferAccountChanged,
      ),
      if (showTransferAccountError)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            S().transferAccountRequired,
            style: TextStyle(fontSize: 11, color: context.semantic.warning),
          ),
        ),
    ];
  }

  List<Widget> _withdrawFields(BuildContext context) {
    return [
      if (withdrawMethods.isNotEmpty) ...[
        SectionTitle(title: S().withdrawMethodLabel),
        WithdrawMethodField(
          methods: withdrawMethods,
          selectedId: selectedWithdrawMethodId,
          onChanged: onWithdrawMethodChanged,
        ),
        if (showWithdrawMethodError)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              S().withdrawMethodRequired,
              style: TextStyle(fontSize: 11, color: context.semantic.warning),
            ),
          ),
      ],
      SectionTitle(title: S().withdrawAccountLabel),
      AppTextField(
        controller: withdrawAccountController,
        hint: S().withdrawAccountHint,
        validator: (v) =>
            (v ?? '').trim().isEmpty ? S().withdrawAccountRequired : null,
      ),
    ];
  }
}
