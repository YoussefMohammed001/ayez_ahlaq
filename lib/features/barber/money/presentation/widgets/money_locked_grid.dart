import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/stat_tile.dart';
import '../../../../../generated/l10n.dart';

class MoneyLockedGrid extends StatelessWidget {
  final VoidCallback onTap;

  const MoneyLockedGrid({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatTile(value: '••••', label: S().earningsToday, onTap: onTap),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatTile(value: '••••', label: S().tabBookings, onTap: onTap),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatTile(value: '••••', label: S().earningsThisMonth, onTap: onTap),
        ),
      ],
    );
  }
}
