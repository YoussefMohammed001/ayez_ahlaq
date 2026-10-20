import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_quote.dart';

class CartQuoteCard extends StatelessWidget {
  final StoreQuote quote;
  final bool isUpdating;

  const CartQuoteCard({super.key, required this.quote, this.isUpdating = false});

  @override
  Widget build(BuildContext context) {
    final hasDelivery = quote.deliveryFee > 0;
    final showSubtotal = quote.grandTotal != quote.subtotal;

    return AppCard(
      child: Opacity(
        opacity: isUpdating ? 0.5 : 1,
        child: Column(
          children: [
            if (quote.hasProductDiscount)
              _buildRow(
                context,
                S().quoteGrossTotal,
                S().currencyEgp(quote.grossSubtotal),
              ),
            if (showSubtotal)
              _buildRow(context, S().orderTotal, S().currencyEgp(quote.subtotal)),
            if (quote.orderDiscount > 0)
              _buildRow(
                context,
                S().orderDiscountLabel,
                '-${S().currencyEgp(quote.orderDiscount)}',
              ),
            if (quote.discountTotal > 0)
              _buildRow(
                context,
                S().quoteSavings,
                S().currencyEgp(quote.discountTotal),
                highlight: true,
              ),
            if (quote.deliveryFee > 0)
              _buildRow(context, S().deliveryFeeOrderLabel, S().currencyEgp(quote.deliveryFee)),
            SizedBox(height: 6.h),
            _buildRow(
              context,
              hasDelivery ? S().grandTotalLabel : S().orderTotal,
              S().currencyEgp(quote.grandTotal),
              emphasize: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    String label,
    String value, {
    bool emphasize = false,
    bool highlight = false,
  }) {
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
              fontWeight: emphasize || highlight ? FontWeight.w800 : FontWeight.w600,
              color: emphasize
                  ? context.semantic.accentSoft
                  : highlight
                  ? context.semantic.success
                  : scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
