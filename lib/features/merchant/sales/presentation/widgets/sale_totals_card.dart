import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../helpers/sale_money.dart';

class SaleTotalsCard extends StatelessWidget {
  final double subtotal;
  final double discount;
  final double total;

  const SaleTotalsCard({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.total,
  });

  Widget _row(String label, String value, {bool strong = false}) {
    final style = strong ? font15w700 : font13w500;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(child: AppText(label, style: style)),
          AppText(value, style: style),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      child: Column(
        children: [
          _row(S().saleSubtotalRow, SaleMoney.format(subtotal)),
          if (discount > 0)
            _row(S().saleDiscountRow, SaleMoney.format(discount)),
          _row(S().saleTotalRow, SaleMoney.format(total), strong: true),
        ],
      ),
    );
  }
}
