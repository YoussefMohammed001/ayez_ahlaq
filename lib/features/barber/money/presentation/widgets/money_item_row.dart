import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/toggle_switch.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/money_direction.dart';
import '../../domain/entities/money_frequency.dart';
import '../../domain/entities/money_item.dart';

class MoneyItemRow extends StatelessWidget {
  final MoneyItem item;
  final bool isMutating;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onToggleActive;

  const MoneyItemRow({
    super.key,
    required this.item,
    required this.isMutating,
    required this.onTap,
    required this.onDelete,
    required this.onToggleActive,
  });

  String _frequencyLabel() => switch (item.frequency) {
    MoneyFrequency.daily => S().moneyFrequencyDaily,
    MoneyFrequency.weekly => S().moneyFrequencyWeekly,
    MoneyFrequency.monthly => S().moneyFrequencyMonthly,
  };

  @override
  Widget build(BuildContext context) {
    final isAdd = item.direction == MoneyDirection.add;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.description, style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                Text(
                  '${item.amount} · ${_frequencyLabel()}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: isAdd ? Colors.green : Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          if (isMutating)
            SizedBox(
              width: 20.r,
              height: 20.r,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          else ...[
            ToggleSwitch(value: item.active, onTap: onToggleActive),
            IconButton(
              icon: Icon(Icons.delete_outline, color: context.colorScheme.error),
              onPressed: onDelete,
            ),
          ],
        ],
      ),
    );
  }
}
