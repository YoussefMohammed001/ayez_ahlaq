import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/sale.dart';
import '../helpers/sale_money.dart';
import 'sale_status_badge.dart';

class SaleRow extends StatelessWidget {
  final Sale sale;
  final VoidCallback onTap;

  const SaleRow({super.key, required this.sale, required this.onTap});

  String get _subtitle {
    final date = sale.createdAt;
    final when = date == null ? '' : AppDateTime.formatDateTime(date);
    final seller = sale.soldByName;
    return [
      sale.code,
      when,
      if (seller != null) S().saleSoldBy(seller),
    ].where((part) => part.isNotEmpty).join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final muted = context.colorScheme.onSurfaceVariant;

    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  sale.customerName ?? S().saleWalkInCustomer,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: font14w700,
                ),
                SizedBox(height: 4.h),
                AppText(_subtitle, style: font11w500.copyWith(color: muted)),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(SaleMoney.format(sale.total), style: font14w700),
              SizedBox(height: 6.h),
              SaleStatusBadge(sale: sale),
            ],
          ),
        ],
      ),
    );
  }
}
