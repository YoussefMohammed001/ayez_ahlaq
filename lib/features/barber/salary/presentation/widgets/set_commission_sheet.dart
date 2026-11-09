import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../helpers/commission_percent_validator.dart';

typedef CommissionSubmit = Future<void> Function(double percent);

class SetCommissionSheet extends StatefulWidget {
  final double? initialPercent;
  final CommissionSubmit onSubmit;

  const SetCommissionSheet({
    super.key,
    required this.initialPercent,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    double? percent,
    required CommissionSubmit onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          SetCommissionSheet(initialPercent: percent, onSubmit: onSubmit),
    );
  }

  @override
  State<SetCommissionSheet> createState() => _SetCommissionSheetState();
}

class _SetCommissionSheetState extends State<SetCommissionSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _controller = TextEditingController(
    text: widget.initialPercent?.toStringAsFixed(0) ?? '',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final percent = CommissionPercentValidator.parse(_controller.text)!;
    Navigator.of(context).pop();
    widget.onSubmit(percent);
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
                SectionTitle(title: S().commissionSetTitle),
                AppTextField(
                  controller: _controller,
                  hint: S().commissionPercentLabel,
                  isNumber: true,
                  validator: CommissionPercentValidator.validate,
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
