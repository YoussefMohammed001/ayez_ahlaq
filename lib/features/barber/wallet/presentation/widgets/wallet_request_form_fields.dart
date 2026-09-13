import 'package:flutter/material.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/option_tile.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/transfer_account.dart';
import '../../domain/entities/wallet_request_type.dart';
import 'transfer_account_field.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().walletRequestTypeLabel),
        OptionTile(
          label: S().walletRequestTypeDeposit,
          icon: Icons.south_west_rounded,
          selected: type == WalletRequestType.deposit,
          onTap: () => onTypeChanged(WalletRequestType.deposit),
        ),
        OptionTile(
          label: S().walletRequestTypeWithdraw,
          icon: Icons.north_east_rounded,
          selected: type == WalletRequestType.withdraw,
          onTap: () => onTypeChanged(WalletRequestType.withdraw),
        ),
        if (transferAccounts.isNotEmpty) ...[
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
        ],
        if (type == WalletRequestType.withdraw) ...[
          SectionTitle(title: S().withdrawAccountLabel),
          AppTextField(
            controller: withdrawAccountController,
            hint: S().withdrawAccountHint,
            validator: (v) =>
                (v ?? '').trim().isEmpty ? S().withdrawAccountRequired : null,
          ),
        ],
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
        SectionTitle(title: S().walletRequestAttachmentLabel),
        OptionTile(
          label: filePath == null ? S().attachReceiptPhoto : S().receiptPhotoAttached,
          icon: Icons.photo_camera_outlined,
          selected: filePath != null,
          onTap: onPickAttachment,
        ),
      ],
    );
  }
}
