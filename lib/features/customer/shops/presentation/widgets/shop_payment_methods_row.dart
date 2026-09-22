import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../shared/payment_methods/payment_method.dart';

class ShopPaymentMethodsRow extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;

  const ShopPaymentMethodsRow({super.key, required this.paymentMethods});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: paymentMethods
          .map(
            (method) => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                method.label,
                style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
              ),
            ),
          )
          .toList(),
    );
  }
}
