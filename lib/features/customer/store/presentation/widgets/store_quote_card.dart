import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_quote.dart';

class StoreQuoteCard extends StatelessWidget {
  final StoreQuote? quote;
  final int fallbackSubtotal;
  final bool isUpdating;

  const StoreQuoteCard({
    super.key,
    required this.quote,
    required this.fallbackSubtotal,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    final subtotal = quote?.subtotal ?? fallbackSubtotal;
    final deliveryFee = quote?.deliveryFee ?? 0;
    final total = quote?.total ?? subtotal;

    return AppCard(
      child: Opacity(
        opacity: isUpdating ? 0.5 : 1,
        child: Column(
          children: [
            _row(context, S().orderTotal, S().currencyEgp(subtotal)),
            if (deliveryFee > 0)
              _row(context, S().deliveryFeeOrderLabel, S().currencyEgp(deliveryFee)),
            SizedBox(height: 6.h),
            _row(context, S().grandTotalLabel, S().currencyEgp(total), emphasize: true),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value, {bool emphasize = false}) {
    final scheme = context.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: emphasize ? 13.sp : 12.5.sp,
              fontWeight: emphasize ? FontWeight.w700 : FontWeight.w400,
              color: emphasize ? scheme.onSurface : scheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: emphasize ? 17.sp : 13.sp,
              fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
              color: emphasize ? context.semantic.accentSoft : scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
