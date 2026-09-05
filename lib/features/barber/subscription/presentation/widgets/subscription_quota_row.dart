import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/subscription_quota.dart';

class SubscriptionQuotaRow extends StatelessWidget {
  final String label;
  final SubscriptionQuota quota;

  const SubscriptionQuotaRow({super.key, required this.label, required this.quota});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final cap = quota.cap;
    final valueLabel = cap == null
        ? S().quotaUnlimited
        : S().quotaUsedOfCap(quota.used, cap);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant),
          ),
          Text(
            valueLabel,
            style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
          ),
        ],
      ),
    );
  }
}
