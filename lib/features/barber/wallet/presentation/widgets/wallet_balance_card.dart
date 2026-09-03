import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class WalletBalanceCard extends StatelessWidget {
  final int balance;

  const WalletBalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S().walletBalanceLabel,
            style: TextStyle(fontSize: 12.sp, color: context.colorScheme.onSurfaceVariant),
          ),
          SizedBox(height: 8.h),
          Text(
            S().currencyEgp(balance),
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
