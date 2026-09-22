import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_status.dart';
import 'subscription_quota_row.dart';
import 'subscription_status_label.dart';

class CurrentSubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  const CurrentSubscriptionCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    if (!subscription.hasSubscription) {
      return AppCard(
        child: Row(
          children: [
            Icon(
              Icons.workspace_premium_outlined,
              color: scheme.onSurfaceVariant,
              size: 22.r,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                S().noActivePlan,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final status = SubscriptionStatus.fromApi(subscription.status);
    final statusColor = status.colorOf(context);
    final statusLabel = status.label;

    final quotas = <MapEntry<String, dynamic>>[
      if (subscription.employees != null)
        MapEntry(S().quotaEmployees, subscription.employees),
      if (subscription.ownServices != null)
        MapEntry(S().quotaOwnServices, subscription.ownServices),
      if (subscription.notificationsAll != null)
        MapEntry(S().quotaNotificationsAll, subscription.notificationsAll),
      if (subscription.notificationsZone != null)
        MapEntry(S().quotaNotificationsZone, subscription.notificationsZone),
      if (subscription.products != null)
        MapEntry(S().quotaProducts, subscription.products),
      if (subscription.drinks != null)
        MapEntry(S().quotaDrinks, subscription.drinks),
      if (subscription.ownCategories != null)
        MapEntry(S().quotaOwnCategories, subscription.ownCategories),
    ];

    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S().currentPlanLabel,
            style: TextStyle(fontSize: 12.sp, color: scheme.onSurfaceVariant),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subscription.planName ?? '',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          if (subscription.cycleStartedAt != null ||
              subscription.nextRenewalDate != null) ...[
            SizedBox(height: 10.h),
            if (subscription.cycleStartedAt != null)
              Text(
                '${S().startedAtLabel}: ${_formatDate(subscription.cycleStartedAt!)}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            if (subscription.nextRenewalDate != null) ...[
              SizedBox(height: 4.h),
              Text(
                '${S().nextRenewalLabel}: ${_formatDate(subscription.nextRenewalDate!)}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
          if (quotas.isNotEmpty) ...[
            Divider(height: 22.h, color: scheme.outline),
            for (final entry in quotas)
              SubscriptionQuotaRow(label: entry.key, quota: entry.value),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
