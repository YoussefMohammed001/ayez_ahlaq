import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../bookings/presentation/widgets/adjustment_type_toggle.dart';
import '../../domain/entities/home_service_request_adjustment.dart';
import 'home_service_adjustment_row.dart';

class HomeServiceAdjustmentsField extends StatefulWidget {
  final List<HomeServiceRequestAdjustment> adjustments;
  final ValueChanged<List<HomeServiceRequestAdjustment>> onChanged;

  const HomeServiceAdjustmentsField({
    super.key,
    required this.adjustments,
    required this.onChanged,
  });

  @override
  State<HomeServiceAdjustmentsField> createState() =>
      _HomeServiceAdjustmentsFieldState();
}

class _HomeServiceAdjustmentsFieldState
    extends State<HomeServiceAdjustmentsField> {
  late List<HomeServiceAdjustmentRow> _rows;

  @override
  void initState() {
    super.initState();
    _rows = widget.adjustments.map(HomeServiceAdjustmentRow.fromEntity).toList();
    for (final row in _rows) {
      _listen(row);
    }
  }

  @override
  void dispose() {
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  void _listen(HomeServiceAdjustmentRow row) {
    row.labelController.addListener(_emit);
    row.amountController.addListener(_emit);
  }

  void _emit() => widget.onChanged(_rows.map((r) => r.toEntity()).toList());

  void _add() {
    final row = HomeServiceAdjustmentRow.empty();
    _listen(row);
    setState(() => _rows = [..._rows, row]);
    _emit();
  }

  void _remove(int index) {
    final row = _rows[index];
    setState(() => _rows = [..._rows]..removeAt(index));
    row.dispose();
    _emit();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < _rows.length; i++) ...[
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              border: Border.all(color: context.colorScheme.outline),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _rows[i].labelController,
                        hint: S().adjustmentLabelHint,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _remove(i),
                      icon: Icon(
                        Icons.close_rounded,
                        size: 18.r,
                        color: context.semantic.warning,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _rows[i].isDiscountNotifier,
                        builder: (context, isDiscount, _) {
                          return AdjustmentTypeToggle(
                            isDiscount: isDiscount,
                            onChanged: (value) {
                              _rows[i].isDiscountNotifier.value = value;
                              _emit();
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: AppTextField(
                        controller: _rows[i].amountController,
                        hint: S().adjustmentAmountHint,
                        isNumber: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (i != _rows.length - 1) SizedBox(height: 10.h),
        ],
        SizedBox(height: 12.h),
        TextButton.icon(
          onPressed: _add,
          icon: Icon(Icons.add_rounded, size: 18.r),
          label: Text(S().addAdjustment, style: font12w600),
        ),
      ],
    );
  }
}
