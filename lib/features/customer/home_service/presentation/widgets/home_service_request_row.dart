import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_request.dart';
import 'home_service_status_label.dart';
import 'home_service_status_tone.dart';

class HomeServiceRequestRow extends StatelessWidget {
  final HomeServiceRequest request;
  final VoidCallback onTap;

  const HomeServiceRequestRow({
    super.key,
    required this.request,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final total = request.finalPrice ?? request.price;

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
                  request.anyNearby
                      ? S().homeServiceAnyNearbyTitle
                      : request.shopName ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                request.code,
                style: TextStyle(
                  fontSize: 10.5.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            request.address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.5.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusBadge(
                label: request.status.label,
                tone: request.status.tone,
              ),
              Text(
                total == null
                    ? S().homeServicePricePending
                    : S().currencyEgp(total),
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
