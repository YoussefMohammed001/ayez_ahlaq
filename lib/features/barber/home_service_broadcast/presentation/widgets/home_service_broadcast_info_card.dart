import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_broadcast.dart';

class HomeServiceBroadcastInfoCard extends StatelessWidget {
  final HomeServiceBroadcast broadcast;

  const HomeServiceBroadcastInfoCard({super.key, required this.broadcast});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row(context, S().address, broadcast.address),
          _row(context, S().homeServiceDateLabel, broadcast.date),
          _row(context, S().homeServiceTimeLabel, _shortTime(broadcast.time)),
          if (broadcast.distanceKm != null)
            _row(
              context,
              S().distanceLabel,
              '${broadcast.distanceKm!.toStringAsFixed(1)} ${S().kmUnit}',
            ),
          if ((broadcast.note ?? '').isNotEmpty)
            _row(context, S().homeServiceNoteLabel, broadcast.note!),
          _row(
            context,
            S().orderTotal,
            broadcast.suggestedPrice == null
                ? S().homeServicePricePending
                : S().currencyEgp(broadcast.suggestedPrice!),
          ),
        ],
      ),
    );
  }

  String _shortTime(String time) {
    final parts = time.split(':');
    if (parts.length < 2) return time;
    return '${parts[0]}:${parts[1]}';
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
              style: TextStyle(
                fontSize: 12.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
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
