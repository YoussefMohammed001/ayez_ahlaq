import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/deduction_status.dart';

class DeductionActions extends StatelessWidget {
  final DeductionStatus status;
  final VoidCallback onWaive;
  final VoidCallback onConfirm;

  const DeductionActions({
    super.key,
    required this.status,
    required this.onWaive,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final canWaive = status != DeductionStatus.waived;
    final canConfirm = status != DeductionStatus.deducted;

    final scheme = context.colorScheme;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    );
    final size = Size.fromHeight(46.h);
    final label = font14w700;

    return Row(
      children: [
        if (canWaive)
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: scheme.primary,
                side: BorderSide(color: scheme.primary),
                minimumSize: size,
                shape: shape,
              ),
              onPressed: onWaive,
              child: Text(S().deductionWaiveAction, style: label),
            ),
          ),
        if (canWaive && canConfirm) SizedBox(width: 10.w),
        if (canConfirm)
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: scheme.primary,
                foregroundColor: scheme.surfaceContainerLowest,
                elevation: 0,
                minimumSize: size,
                shape: shape,
              ),
              onPressed: onConfirm,
              child: Text(S().deductionConfirmAction, style: label),
            ),
          ),
      ],
    );
  }
}
