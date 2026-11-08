import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/filter_chip_row.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/deduction_status.dart';
import '../helpers/salary_labels.dart';

class DeductionsFilterHeader extends StatelessWidget {
  final DeductionStatus? selected;
  final ValueChanged<DeductionStatus?> onSelected;

  const DeductionsFilterHeader({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        FilterChipRow<DeductionStatus>(
          options: DeductionStatus.values,
          selected: selected,
          allLabel: S().filterAll,
          labelBuilder: SalaryLabels.filter,
          onSelected: onSelected,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 4.h),
          child: Text(
            S().deductionsAutoNote,
            style: font12w400.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
