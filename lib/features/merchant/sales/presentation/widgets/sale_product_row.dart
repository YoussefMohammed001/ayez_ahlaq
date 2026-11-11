import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../../../products/domain/entities/merchant_product.dart';
import '../helpers/sale_money.dart';

class SaleProductRow extends StatelessWidget {
  final MerchantProduct product;
  final int quantity;
  final ValueChanged<int> onChanged;

  const SaleProductRow({
    super.key,
    required this.product,
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final muted = context.colorScheme.onSurfaceVariant;

    return AppCard(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: font13w600,
                ),
                SizedBox(height: 3.h),
                AppText(
                  '${SaleMoney.format(product.price.toDouble())} · '
                  '${S().saleStockAvailable('${product.totalStock}')}',
                  style: font11w500.copyWith(color: muted),
                ),
              ],
            ),
          ),
          QuantityStepper(
            quantity: quantity,
            onChanged: (value) =>
                onChanged(value > product.totalStock ? quantity : value),
          ),
        ],
      ),
    );
  }
}
