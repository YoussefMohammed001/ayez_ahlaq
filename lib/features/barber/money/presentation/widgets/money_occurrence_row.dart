import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/money_direction.dart';
import '../../domain/entities/money_occurrence.dart';

class MoneyOccurrenceRow extends StatelessWidget {
  final MoneyOccurrence occurrence;
  final bool isProcessing;
  final VoidCallback onConfirm;
  final VoidCallback onDismiss;

  const MoneyOccurrenceRow({
    super.key,
    required this.occurrence,
    required this.isProcessing,
    required this.onConfirm,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final isAdd = occurrence.direction == MoneyDirection.add;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(occurrence.description, style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                Text(
                  occurrence.amount.toString(),
                  style: TextStyle(color: isAdd ? Colors.green : Colors.redAccent),
                ),
              ],
            ),
          ),
          if (isProcessing)
            SizedBox(
              width: 20.r,
              height: 20.r,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: context.colorScheme.error),
                  onPressed: onDismiss,
                  tooltip: S().moneyOccurrenceDismiss,
                ),
                IconButton(
                  icon: Icon(Icons.check, color: Colors.green),
                  onPressed: onConfirm,
                  tooltip: S().moneyOccurrenceConfirm,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
