import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/subscription_plan.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool isCurrentPlan;
  final bool isSubscribing;
  final VoidCallback onSubscribe;

  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.isCurrentPlan,
    required this.isSubscribing,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final semantic = context.semantic;

    final caps = <MapEntry<String, int?>>[
      MapEntry(S().quotaEmployees, plan.employeeCap),
      MapEntry(S().quotaOwnServices, plan.ownServiceCap),
      MapEntry(S().quotaNotificationsAll, plan.notificationQuotaAll),
      MapEntry(S().quotaNotificationsZone, plan.notificationQuotaZone),
      MapEntry(S().quotaProducts, plan.productCap),
      MapEntry(S().quotaDrinks, plan.drinkCap),
      MapEntry(S().quotaOwnCategories, plan.ownCategoryCap),
    ];

    return AppCard(
      margin: EdgeInsets.only(bottom: 12.h),
      borderColor: isCurrentPlan ? semantic.accentStrong : null,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  plan.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              if (isCurrentPlan)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: semantic.accentStrong.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    S().currentPlanBadge,
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w700,
                      color: semantic.accentStrong,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            S().currencyEgp(plan.price),
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: semantic.accentStrong,
            ),
          ),
          SizedBox(height: 12.h),
          for (final cap in caps)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cap.key,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    cap.value == null ? S().quotaUnlimited : '${cap.value}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          if (!isCurrentPlan) ...[
            SizedBox(height: 14.h),
            PrimaryCtaButton(
              label: S().subscribeAction,
              isLoading: isSubscribing,
              onPressed: onSubscribe,
            ),
          ],
        ],
      ),
    );
  }
}
