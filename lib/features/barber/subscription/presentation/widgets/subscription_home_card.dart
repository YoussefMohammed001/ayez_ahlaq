import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_status.dart';
import 'subscription_status_label.dart';

class SubscriptionHomeCard extends StatelessWidget {
  final Subscription subscription;
  final VoidCallback onTap;

  const SubscriptionHomeCard({
    super.key,
    required this.subscription,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    if (!subscription.hasSubscription) {
      return AppCard(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              Icons.workspace_premium_outlined,
              color: scheme.onSurfaceVariant,
              size: 20.r,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                S().noActivePlan,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: scheme.onSurfaceVariant,
              size: 20.r,
            ),
          ],
        ),
      );
    }

    final statusColor = SubscriptionStatus.fromApi(
      subscription.status,
    ).colorOf(context);

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
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  subscription.planName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(S().view),
                  Icon(
                    Icons.chevron_right,
                    color: scheme.onSurfaceVariant,
                    size: 20.r,
                  ),
                ],
              ),
            ],
          ),
          if (subscription.nextRenewalDate != null) ...[
            SizedBox(height: 6.h),
            Text(
              '${S().nextRenewalLabel}: ${_formatDate(subscription.nextRenewalDate!)}',
              style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
