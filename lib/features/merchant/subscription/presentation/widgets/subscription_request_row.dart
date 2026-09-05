import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/subscription_request.dart';

class SubscriptionRequestRow extends StatelessWidget {
  final SubscriptionRequest request;

  const SubscriptionRequestRow({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final semantic = context.semantic;
    final statusColor = switch (request.status) {
      'APPROVED' => semantic.success,
      'REJECTED' => semantic.warning,
      _ => semantic.info,
    };
    final statusLabel = switch (request.status) {
      'APPROVED' => S().requestStatusApproved,
      'REJECTED' => S().requestStatusRejected,
      _ => S().requestStatusPending,
    };
    final typeLabel = request.type == 'RENEW' ? S().requestTypeRenew : S().requestTypeSubscribe;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${request.planName} · $typeLabel',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700, color: statusColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request.code,
                style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
              ),
              Text(
                RelativeDateLabel.format(request.createdAt),
                style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
          if (request.decisionNote != null && request.decisionNote!.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              request.decisionNote!,
              style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}
