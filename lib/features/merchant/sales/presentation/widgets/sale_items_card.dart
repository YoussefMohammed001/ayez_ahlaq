import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../domain/entities/sale_item.dart';
import '../../../../../generated/l10n.dart';
import '../helpers/sale_money.dart';

class SaleItemsCard extends StatelessWidget {
  final List<SaleItem> items;

  const SaleItemsCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      child: Column(
        children: [
          for (final item in items)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                children: [
                  Expanded(
                    child: AppText(
                      S().saleItemLine(item.productName, '${item.quantity}'),
                      style: font13w500,
                    ),
                  ),
                  AppText(SaleMoney.format(item.lineTotal), style: font13w600),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
