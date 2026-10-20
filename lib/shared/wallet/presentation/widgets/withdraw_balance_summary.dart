import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../generated/l10n.dart';
import '../wallet_money_format.dart';

class WithdrawBalanceSummary extends StatelessWidget {
  final int? available;
  final TextEditingController amountController;

  const WithdrawBalanceSummary({
    super.key,
    required this.available,
    required this.amountController,
  });

  @override
  Widget build(BuildContext context) {
    final balance = available;

    return AppCard(
      padding: EdgeInsets.all(14.r),
      child: balance == null
          ? Text(S().walletWithdrawBalanceUnknown)
          : ValueListenableBuilder<TextEditingValue>(
              valueListenable: amountController,
              builder: (context, value, _) {
                final amount = int.tryParse(value.text.trim()) ?? 0;
                final remaining = balance - amount;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S().walletWithdrawAvailableNow(WalletMoneyFormat.isolated(balance))),
                    SizedBox(height: 6.h),
                    Text(
                      S().walletWithdrawRemainingAfter(WalletMoneyFormat.isolated(remaining)),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: remaining < 0
                            ? context.semantic.warning
                            : context.semantic.success,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
