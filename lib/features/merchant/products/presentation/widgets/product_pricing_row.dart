import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'product_number_field.dart';
import '../../../../../generated/l10n.dart';

class ProductPricingRow extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController minOrderController;

  const ProductPricingRow({
    super.key,
    required this.priceController,
    required this.minOrderController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ProductNumberField(
            title: S().unitPrice,
            controller: priceController,
            hint: '120',
            validator: (v) =>
                (int.tryParse(v ?? '') ?? 0) <= 0 ? S().invalidPrice : null,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ProductNumberField(
            title: S().minOrderQty,
            controller: minOrderController,
            hint: '6',
            validator: (v) =>
                (int.tryParse(v ?? '') ?? 0) <= 0 ? S().invalidNumber : null,
          ),
        ),
      ],
    );
  }
}
