import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';

class CartSummaryBar extends StatelessWidget {
  final int itemCount;
  final int subtotal;
  final String actionLabel;
  final VoidCallback? onPressed;

  const CartSummaryBar({
    super.key,
    required this.itemCount,
    required this.subtotal,
    required this.actionLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        border: Border(top: BorderSide(color: scheme.outline)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${S().productsCount} $itemCount',
                    style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                  ),
                  Text(
                    S().currencyEgp(subtotal),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: context.semantic.accentSoft,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 160.w,
              child: PrimaryCtaButton(label: actionLabel, onPressed: onPressed),
            ),
          ],
        ),
      ),
    );
  }
}
