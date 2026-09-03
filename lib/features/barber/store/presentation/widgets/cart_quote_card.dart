import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/cart_quote.dart';

class CartQuoteCard extends StatelessWidget {
  final CartQuote quote;
  final bool isQuoting;

  const CartQuoteCard({super.key, required this.quote, this.isQuoting = false});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Opacity(
        opacity: isQuoting ? 0.5 : 1,
        child: Column(
          children: [
            _buildRow(context, S().orderTotal, S().currencyEgp(quote.subtotal)),
            if (quote.deliveryFee > 0)
              _buildRow(context, S().deliveryFeeOrderLabel, S().currencyEgp(quote.deliveryFee)),
            SizedBox(height: 6.h),
            _buildRow(
              context,
              S().grandTotalLabel,
              S().currencyEgp(quote.total),
              emphasize: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value, {bool emphasize = false}) {
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
