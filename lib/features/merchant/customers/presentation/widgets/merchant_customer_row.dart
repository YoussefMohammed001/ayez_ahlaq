import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/merchant_customer.dart';

class MerchantCustomerRow extends StatelessWidget {
  final MerchantCustomer customer;

  const MerchantCustomerRow({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final initials = customer.barberName.isEmpty
        ? S().avatarFallback
        : customer.barberName.substring(0, 1);

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarCircle(initials: initials, size: 40.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.barberName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
                SizedBox(height: 3.h),
                Text(
                  customer.shopName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                ),
                SizedBox(height: 3.h),
                Text(
                  customer.phoneNumber,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                S().currencyEgp(customer.totalSpend),
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w800, color: context.semantic.accentSoft),
              ),
              Text(
                S().customerTotalSpend,
                style: TextStyle(fontSize: 9.5.sp, color: scheme.onSurfaceVariant),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.receipt_long_outlined, size: 12.r, color: scheme.onSurfaceVariant),
                  SizedBox(width: 4.w),
                  Text(
                    S().customerOrderCount(customer.orderCount),
                    style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: scheme.onSurface),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                S().customerLastOrderAt(RelativeDateLabel.format(customer.lastOrderAt)),
                style: TextStyle(fontSize: 9.5.sp, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
