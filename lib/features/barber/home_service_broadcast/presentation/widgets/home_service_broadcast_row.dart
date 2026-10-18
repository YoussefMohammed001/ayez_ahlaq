import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_broadcast.dart';

class HomeServiceBroadcastRow extends StatelessWidget {
  final HomeServiceBroadcast broadcast;
  final VoidCallback onTap;

  const HomeServiceBroadcastRow({
    super.key,
    required this.broadcast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  broadcast.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                broadcast.requestCode,
                style: TextStyle(
                  fontSize: 10.5.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          if (broadcast.distanceKm != null) ...[
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Icons.place_outlined,
                  size: 14.r,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: 2.w),
                Text(
                  '${broadcast.distanceKm!.toStringAsFixed(1)} ${S().kmUnit}',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.event_outlined,
                    size: 14.r,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${broadcast.date} ${broadcast.time}',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Text(
                broadcast.suggestedPrice == null
                    ? S().homeServicePricePending
                    : S().currencyEgp(broadcast.suggestedPrice!),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.semantic.accentSoft,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
