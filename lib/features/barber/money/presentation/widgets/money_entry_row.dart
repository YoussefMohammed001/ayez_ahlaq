import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../domain/entities/money_direction.dart';
import '../../domain/entities/money_entry.dart';

class MoneyEntryRow extends StatelessWidget {
  final MoneyEntry entry;

  const MoneyEntryRow({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final isAdd = entry.direction == MoneyDirection.add;
    final date = entry.entryDate;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.description, style: TextStyle(fontWeight: FontWeight.w700)),
                if (date != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
          Text(
            '${isAdd ? '+' : '-'}${entry.amount}',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: isAdd ? Colors.green : Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
