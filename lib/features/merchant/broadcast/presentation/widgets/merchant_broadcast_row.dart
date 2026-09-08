import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/broadcast.dart';
import 'merchant_broadcast_status_chip.dart';

class MerchantBroadcastRow extends StatelessWidget {
  final Broadcast broadcast;

  const MerchantBroadcastRow({super.key, required this.broadcast});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  broadcast.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
                SizedBox(height: 3.h),
                Text(
                  S().broadcastRecipientCount(broadcast.recipientCount),
                  style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          MerchantBroadcastStatusChip(status: broadcast.status),
        ],
      ),
    );
  }
}
