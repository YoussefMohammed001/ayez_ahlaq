import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return Row(
      children: [
        if (canWaive)
          Expanded(
            child: OutlinedButton(
              onPressed: onWaive,
              child: Text(S().deductionWaiveAction),
            ),
          ),
        if (canWaive && canConfirm) SizedBox(width: 10.w),
        if (canConfirm)
          Expanded(
            child: ElevatedButton(
              onPressed: onConfirm,
              child: Text(S().deductionConfirmAction),
            ),
          ),
      ],
    );
  }
}
