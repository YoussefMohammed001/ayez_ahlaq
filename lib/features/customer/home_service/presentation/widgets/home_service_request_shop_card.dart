import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_shop.dart';

class HomeServiceRequestShopCard extends StatelessWidget {
  final HomeServiceShop? shop;
  final String? retryShopName;

  const HomeServiceRequestShopCard({super.key, this.shop, this.retryShopName});

  @override
  Widget build(BuildContext context) {
    final shop = this.shop;
    final retryShopName = this.retryShopName;

    return AppCard(
      child: shop == null && retryShopName == null
          ? Text(
              S().homeServiceAnyNearbyDescription,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.colorScheme.onSurface,
              ),
            )
          : shop == null
          ? Text(
              retryShopName!,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: context.colorScheme.onSurface,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  S().homeServiceStartingPrice(
                    shop.homeServicePrice.toString(),
                  ),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: context.semantic.accentStrong,
                  ),
                ),
                if ((shop.homeServiceNote ?? '').isNotEmpty) ...[
                  SizedBox(height: 6.h),
                  Text(
                    '${S().homeServiceShopNoteLabel}: ${shop.homeServiceNote}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
