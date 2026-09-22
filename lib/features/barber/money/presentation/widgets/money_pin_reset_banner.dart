import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/money_pin_reset_status.dart';

class MoneyPinResetBanner extends StatelessWidget {
  final MoneyPinResetStatus status;

  const MoneyPinResetBanner({super.key, required this.status});

  bool get _isRejected =>
      !status.pending && status.lastResolution?.toUpperCase() == 'REJECTED';

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final color = _isRejected ? context.semantic.warning : scheme.primary;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isRejected
                ? S().moneyPinResetRejectedTitle
                : S().moneyPinResetPendingTitle,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5.sp, color: color),
          ),
          SizedBox(height: 6.h),
          Text(
            status.lastAdminNote?.isNotEmpty == true
                ? status.lastAdminNote!
                : S().moneyPinResetPendingMessage,
            style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
