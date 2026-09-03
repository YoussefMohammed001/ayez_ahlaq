import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../../domain/entities/wallet_transaction_direction.dart';

class WalletTransactionRow extends StatelessWidget {
  final WalletTransaction transaction;

  const WalletTransactionRow({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final isCredit = transaction.direction == WalletTransactionDirection.credit;
    final amountColor = isCredit ? context.semantic.success : context.semantic.warning;
    final sign = isCredit ? '+' : '-';

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: amountColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              isCredit ? Icons.south_west_rounded : Icons.north_east_rounded,
              size: 18.r,
              color: amountColor,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.reason,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
                SizedBox(height: 3.h),
                Text(
                  RelativeDateLabel.format(transaction.at),
                  style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Text(
            '$sign${S().currencyEgp(transaction.amount)}',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w800, color: amountColor),
          ),
        ],
      ),
    );
  }
}
