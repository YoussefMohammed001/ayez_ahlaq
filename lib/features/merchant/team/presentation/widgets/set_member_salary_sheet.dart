import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/form_sheet_frame.dart';
import '../../../../barber/salary/presentation/helpers/salary_amount_validator.dart';

class SetMemberSalarySheet extends StatefulWidget {
  final double? initialAmount;
  final Future<void> Function(double amount) onSubmit;

  const SetMemberSalarySheet({
    super.key,
    required this.initialAmount,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required double? amount,
    required Future<void> Function(double amount) onSubmit,
  }) {
    return FormSheetFrame.show(
      context,
      (_) => SetMemberSalarySheet(initialAmount: amount, onSubmit: onSubmit),
    );
  }

  @override
  State<SetMemberSalarySheet> createState() => _SetMemberSalarySheetState();
}

class _SetMemberSalarySheetState extends State<SetMemberSalarySheet> {
  final _formKey = GlobalKey<FormState>();
  late final _amountController = TextEditingController(
    text: widget.initialAmount?.toStringAsFixed(0) ?? '',
  );

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final amount = SalaryAmountValidator.parse(_amountController.text)!;
    Navigator.of(context).pop();
    widget.onSubmit(amount);
  }

  @override
  Widget build(BuildContext context) {
    return FormSheetFrame(
      formKey: _formKey,
      children: [
        SectionTitle(title: S().salaryTitle),
        AppTextField(
          controller: _amountController,
          hint: S().salaryAmountLabel,
          isNumber: true,
          validator: SalaryAmountValidator.validate,
        ),
        SizedBox(height: 20.h),
        PrimaryCtaButton(label: S().save, onPressed: _submit),
      ],
    );
  }
}
