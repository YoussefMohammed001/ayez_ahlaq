import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/cart.dart';

class CartQuoteCard extends StatelessWidget {
  final Cart cart;
  final bool isUpdating;

  const CartQuoteCard({super.key, required this.cart, this.isUpdating = false});

  @override
  Widget build(BuildContext context) {
    final grandTotal = cart.subtotal + cart.deliveryFee;

    return AppCard(
      child: Opacity(
        opacity: isUpdating ? 0.5 : 1,
        child: Column(
          children: [
            _buildRow(context, S().orderTotal, S().currencyEgp(cart.subtotal)),
            if (cart.deliveryFee > 0)
              _buildRow(context, S().deliveryFeeOrderLabel, S().currencyEgp(cart.deliveryFee)),
            SizedBox(height: 6.h),
            _buildRow(
              context,
              S().grandTotalLabel,
              S().currencyEgp(grandTotal),
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
