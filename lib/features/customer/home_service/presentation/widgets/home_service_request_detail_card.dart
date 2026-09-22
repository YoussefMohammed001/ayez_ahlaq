import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_request.dart';
import 'home_service_adjustments_section.dart';
import 'home_service_status_label.dart';
import 'home_service_status_tone.dart';

class HomeServiceRequestDetailCard extends StatelessWidget {
  final HomeServiceRequest request;

  const HomeServiceRequestDetailCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final total = request.finalPrice ?? request.price;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request.code,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.onSurface,
                ),
              ),
              StatusBadge(label: request.status.label, tone: request.status.tone),
            ],
          ),
          SizedBox(height: 12.h),
          _row(context, S().shopsTitle, request.shopName),
          _row(context, S().address, request.address),
          if ((request.note ?? '').isNotEmpty)
            _row(context, S().homeServiceNoteLabel, request.note!),
          HomeServiceAdjustmentsSection(adjustments: request.adjustments),
          _row(context, S().orderTotal, S().currencyEgp(total)),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: context.colorScheme.onSurfaceVariant),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
