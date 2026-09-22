import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class SettleBookingsBar extends StatelessWidget {
  final int selectedCount;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const SettleBookingsBar({
    super.key,
    required this.selectedCount,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(top: BorderSide(color: context.colorScheme.outline)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              S().settleSelectedCount(selectedCount),
              style: TextStyle(
                fontSize: 12.5.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: PrimaryCtaButton(
              label: S().settleSubmitAction,
              isLoading: isSubmitting,
              onPressed: onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
