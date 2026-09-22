import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_request.dart';
import 'home_service_adjustments_section.dart';

class HomeServiceRequestInfoCard extends StatelessWidget {
  final HomeServiceRequest request;

  const HomeServiceRequestInfoCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final total = request.finalPrice ?? request.price;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row(context, S().address, request.address),
          if (request.distanceKm != null)
            _row(
              context,
              S().distanceLabel,
              '${request.distanceKm!.toStringAsFixed(1)} ${S().kmUnit}',
            ),
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
