import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';
import 'payment_method.dart';

class PaymentMethodTile extends StatelessWidget {
  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.selected,
    required this.onTap,
  });

  IconData get _icon => switch (method.code) {
    'CASH' => Icons.payments_outlined,
    'CARD' => Icons.credit_card_outlined,
    'WALLET' => Icons.account_balance_wallet_outlined,
    _ => Icons.payment_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: selected ? scheme.primary : scheme.outline),
        ),
        child: Column(
          children: [
            Icon(
              _icon,
              size: 24.r,
              color: selected ? scheme.primary : scheme.onSurfaceVariant,
            ),
            SizedBox(height: 8.h),
            Text(
              method.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
