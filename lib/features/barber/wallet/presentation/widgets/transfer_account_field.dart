import 'package:flutter/material.dart';
import '../../../../../core/widgets/option_tile.dart';
import '../../../../../shared/wallet/domain/entities/transfer_account.dart';

class TransferAccountField extends StatelessWidget {
  final List<TransferAccount> accounts;
  final int? selectedId;
  final ValueChanged<int> onChanged;

  const TransferAccountField({
    super.key,
    required this.accounts,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final account in accounts)
          OptionTile(
            label: account.label,
            icon: Icons.account_balance_wallet_outlined,
            selected: selectedId == account.id,
            onTap: () => onChanged(account.id),
          ),
      ],
    );
  }
}
