import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_quota.dart';

class SubscriptionHomeCard extends StatelessWidget {
  final Subscription subscription;
  final VoidCallback onTap;

  const SubscriptionHomeCard({super.key, required this.subscription, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final semantic = context.semantic;

    if (!subscription.hasSubscription) {
      return AppCard(
        onTap: onTap,
        child: Row(
          children: [
            Icon(Icons.workspace_premium_outlined, color: scheme.onSurfaceVariant, size: 20.r),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                S().noActivePlan,
                style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant),
              ),
            ),
            Icon(Icons.chevron_right, color: scheme.onSurfaceVariant, size: 20.r),
          ],
        ),
      );
    }

    final isPending = subscription.status == 'PENDING';
    final statusColor = isPending ? semantic.warning : semantic.success;

    final quotas = <MapEntry<String, SubscriptionQuota>>[
      if (subscription.employees != null) MapEntry(S().quotaEmployees, subscription.employees!),
      if (subscription.notificationsAll != null)
        MapEntry(S().quotaNotificationsAll, subscription.notificationsAll!),
      if (subscription.notificationsZone != null)
        MapEntry(S().quotaNotificationsZone, subscription.notificationsZone!),
      if (subscription.products != null) MapEntry(S().quotaProducts, subscription.products!),
      if (subscription.ownCategories != null)
        MapEntry(S().quotaOwnCategories, subscription.ownCategories!),
    ];

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.r,
                height: 8.r,
                decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  subscription.planName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: scheme.onSurface),
                ),
              ),
              Icon(Icons.chevron_right, color: scheme.onSurfaceVariant, size: 20.r),
            ],
          ),
          if (subscription.nextRenewalDate != null) ...[
            SizedBox(height: 6.h),
            Text(
              '${S().nextRenewalLabel}: ${_formatDate(subscription.nextRenewalDate!)}',
              style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
            ),
          ],
          // if (quotas.isNotEmpty) ...[
          //   SizedBox(height: 10.h),
          //   Wrap(
          //     spacing: 8.w,
          //     runSpacing: 6.h,
          //     children: [
          //       for (final entry in quotas)
          //         _QuotaChip(label: entry.key, quota: entry.value),
          //     ],
          //   ),
         // ],
        ],
      ),

    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class _QuotaChip extends StatelessWidget {
  final String label;
  final SubscriptionQuota quota;

  const _QuotaChip({required this.label, required this.quota});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final cap = quota.cap;
    final valueLabel = cap == null ? S().quotaUnlimited : S().quotaUsedOfCap(quota.used, cap);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        '$label: $valueLabel',
        style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.w600, color: scheme.onSurfaceVariant),
      ),
    );
  }
}
