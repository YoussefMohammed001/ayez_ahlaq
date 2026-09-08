import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking_adjustment.dart';
import 'bill_adjustment_row.dart';

class BillAdjustmentsField extends StatefulWidget {
  final List<BookingAdjustment> adjustments;
  final ValueChanged<List<BookingAdjustment>> onChanged;

  const BillAdjustmentsField({
    super.key,
    required this.adjustments,
    required this.onChanged,
  });

  @override
  State<BillAdjustmentsField> createState() => _BillAdjustmentsFieldState();
}

class _BillAdjustmentsFieldState extends State<BillAdjustmentsField> {
  late List<BillAdjustmentRow> _rows;

  @override
  void initState() {
    super.initState();
    _rows = widget.adjustments.map(BillAdjustmentRow.fromEntity).toList();
  }

  @override
  void dispose() {
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  void _emit() => widget.onChanged(_rows.map((r) => r.toEntity()).toList());

  void _add() {
    setState(() => _rows = [..._rows, BillAdjustmentRow.empty()]);
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
        for (var i = 0; i < _rows.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: AppTextField(
                    controller: _rows[i].labelController,
                    hint: S().adjustmentLabelHint,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _rows[i].amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
                    ],
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                      fontSize: 13.5.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: S().adjustmentAmountHint,
                    ),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
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
          ),
        TextButton.icon(
          onPressed: _add,
          icon: Icon(Icons.add_rounded, size: 18.r),
          label: Text(S().addAdjustment, style: font12w600),
        ),
      ],
    );
  }
}
