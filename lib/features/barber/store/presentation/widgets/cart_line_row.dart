import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../../domain/entities/cart_line.dart';

class CartLineRow extends StatelessWidget {
  final CartLine line;
  final ValueChanged<int> onQuantityChanged;

  const CartLineRow({
    super.key,
    required this.line,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: scheme.outline)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line.productName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, color: scheme.onSurface, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.h),
                Text(
                  S().currencyEgp(line.unitPrice),
                  style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                ),
                if (!line.available)
                  Text(
                    line.unavailableReason ?? '',
                    style: TextStyle(fontSize: 11.sp, color: context.semantic.warning),
                  ),
              ],
            ),
          ),
          QuantityStepper(
            quantity: line.quantity,
            minQuantity: line.minOrderQty,
            onChanged: onQuantityChanged,
          ),
          SizedBox(width: 12.w),
          Text(
            S().currencyEgp(line.lineTotal),
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: context.semantic.accentSoft),
          ),
        ],
      ),
    );
  }
}
