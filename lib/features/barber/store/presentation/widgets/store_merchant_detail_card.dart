import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_merchant.dart';

class StoreMerchantDetailCard extends StatelessWidget {
  final StoreMerchant merchant;

  const StoreMerchantDetailCard({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      margin: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarCircle(
                initials: merchant.businessName.isEmpty
                    ? S().avatarFallback
                    : merchant.businessName.substring(0, 1),
                size: 48.r,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      merchant.businessName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, size: 15.r, color: context.semantic.accentSoft),
                        SizedBox(width: 3.w),
                        Text(
                          '${merchant.rating.toStringAsFixed(1)} (${merchant.ratingCount})',
                          style: TextStyle(fontSize: 12.sp, color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          InfoRow(
            icon: Icons.call_outlined,
            label: S().contact,
            value: merchant.phoneNumber,
          ),
          for (final phone in merchant.phones)
            InfoRow(
              icon: Icons.phone_forwarded_outlined,
              label: phone.label?.isNotEmpty ?? false
                  ? phone.label!
                  : S().extraPhoneFallbackLabel,
              value: phone.phoneNumber,
            ),
          InfoRow(
            icon: Icons.inventory_2_outlined,
            label: S().productsCount,
            value: '${merchant.productCount}',
          ),
          InfoRow(
            icon: merchant.deliveryOffered
                ? Icons.delivery_dining_outlined
                : Icons.storefront_outlined,
            label: S().deliveryFeeOrderLabel,
            value: merchant.deliveryOffered
                ? (merchant.deliveryFee > 0
                      ? S().currencyEgp(merchant.deliveryFee)
                      : S().freeDelivery)
                : S().deliveryNotOfferedReason,
            showDivider: merchant.freeDeliveryOver != null,
          ),
          if (merchant.freeDeliveryOver != null)
            InfoRow(
              icon: Icons.local_offer_outlined,
              label: S().deliveryFreeOverLabel,
              value: S().currencyEgp(merchant.freeDeliveryOver!),
              showDivider: false,
            ),
        ],
      ),
    );
  }
}
