import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/cart_line.dart';

class CartLineRow extends StatelessWidget {
  final CartLine line;
  final VoidCallback onRemove;

  const CartLineRow({super.key, required this.line, required this.onRemove});

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
                  line.product.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, color: scheme.onSurface, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${line.quantity} × ${S().currencyEgp(line.product.effectivePrice)}',
                  style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Text(
            S().currencyEgp(line.lineTotal),
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: context.semantic.accentSoft),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Icon(Icons.delete_outline_rounded, size: 18.r, color: context.semantic.warning),
            ),
          ),
        ],
      ),
    );
  }
}
