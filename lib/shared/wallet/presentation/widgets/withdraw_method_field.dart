import 'package:flutter/material.dart';
import '../../../../core/widgets/option_tile.dart';
import '../../domain/entities/withdraw_method.dart';

class WithdrawMethodField extends StatelessWidget {
  final List<WithdrawMethod> methods;
  final int? selectedId;
  final ValueChanged<int> onChanged;

  const WithdrawMethodField({
    super.key,
    required this.methods,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final method in methods)
          OptionTile(
            label: method.name,
            icon: Icons.account_balance_wallet_outlined,
            selected: selectedId == method.id,
            onTap: () => onChanged(method.id),
          ),
      ],
    );
  }
}
