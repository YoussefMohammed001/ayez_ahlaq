import 'package:flutter/material.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/option_tile.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/wallet_request_type.dart';

class WalletRequestFormFields extends StatelessWidget {
  final TextEditingController amountController;
  final TextEditingController noteController;
  final WalletRequestType type;
  final ValueChanged<WalletRequestType> onTypeChanged;
  final String? filePath;
  final VoidCallback onPickAttachment;

  const WalletRequestFormFields({
    super.key,
    required this.amountController,
    required this.noteController,
    required this.type,
    required this.onTypeChanged,
    required this.filePath,
    required this.onPickAttachment,
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
