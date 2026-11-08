import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/salary_type.dart';
import '../helpers/salary_amount_validator.dart';
import '../helpers/salary_labels.dart';

typedef SalarySubmit = Future<void> Function(SalaryType type, double amount);

class SetSalarySheet extends StatefulWidget {
  final SalaryType initialType;
  final double? initialAmount;
  final SalarySubmit onSubmit;

  const SetSalarySheet({
    super.key,
    required this.initialType,
    required this.initialAmount,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    SalaryType? type,
    double? amount,
    required SalarySubmit onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SetSalarySheet(
        initialType: type ?? SalaryType.monthly,
        initialAmount: amount,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  State<SetSalarySheet> createState() => _SetSalarySheetState();
}

class _SetSalarySheetState extends State<SetSalarySheet> {
  final _formKey = GlobalKey<FormState>();
  late final _amountController = TextEditingController(
    text: widget.initialAmount?.toStringAsFixed(0) ?? '',
  );
  late SalaryType _type = widget.initialType;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final amount = SalaryAmountValidator.parse(_amountController.text)!;
    Navigator.of(context).pop();
    widget.onSubmit(_type, amount);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: S().salaryTypeLabel),
                SegmentedButton<SalaryType>(
                  showSelectedIcon: false,
                  segments: [
                    for (final type in SalaryType.values)
                      ButtonSegment(
                        value: type,
                        label: Text(SalaryLabels.type(type)),
                      ),
                  ],
                  selected: {_type},
                  onSelectionChanged: (value) =>
                      setState(() => _type = value.first),
                ),
                SizedBox(height: 8.h),
                Text(
                  SalaryLabels.typeHint(_type),
                  style: font12w400.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 14.h),
                AppTextField(
                  controller: _amountController,
                  hint: S().salaryAmountLabel,
                  isNumber: true,
                  validator: SalaryAmountValidator.validate,
                ),
                SizedBox(height: 20.h),
                PrimaryCtaButton(label: S().save, onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
