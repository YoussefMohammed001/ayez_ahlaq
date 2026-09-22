import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/broadcast.dart';
import '../../domain/entities/broadcast_status.dart';
import 'broadcast_status_chip.dart';

class BroadcastRow extends StatelessWidget {
  final Broadcast broadcast;

  const BroadcastRow({super.key, required this.broadcast});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final reason = broadcast.decisionNote;
    final showRejectionReason =
        broadcast.status == BroadcastStatus.rejected &&
        reason != null &&
        reason.isNotEmpty;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      broadcast.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      S().broadcastRecipientCount(broadcast.recipientCount),
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              BroadcastStatusChip(status: broadcast.status),
            ],
          ),
          if (showRejectionReason) ...[
            SizedBox(height: 8.h),
            Text(
              '${S().broadcastRejectionReasonLabel}: $reason',
              style: TextStyle(
                fontSize: 11.sp,
                color: context.semantic.warning,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
