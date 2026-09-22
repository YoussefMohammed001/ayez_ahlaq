import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../shared/payment_methods/payment_method.dart';
import '../../../../../shared/payment_methods/payment_method_tile.dart';

class BookingPaymentMethodsRow extends StatelessWidget {
  final List<PaymentMethod> methods;
  final String selectedCode;
  final ValueChanged<String> onSelected;

  const BookingPaymentMethodsRow({
    super.key,
    required this.methods,
    required this.selectedCode,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final method in methods) ...[
          Expanded(
            child: PaymentMethodTile(
              method: method,
              selected: selectedCode == method.code,
              onTap: () => onSelected(method.code),
            ),
          ),
          if (method != methods.last) SizedBox(width: 10.w),
        ],
      ],
    );
  }
}
