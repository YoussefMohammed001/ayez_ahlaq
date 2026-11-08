import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';

typedef DecisionSubmit = Future<void> Function(String? note);

class DecideDeductionSheet extends StatefulWidget {
  final bool waive;
  final DecisionSubmit onSubmit;

  const DecideDeductionSheet({
    super.key,
    required this.waive,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required bool waive,
    required DecisionSubmit onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DecideDeductionSheet(waive: waive, onSubmit: onSubmit),
    );
  }

  @override
  State<DecideDeductionSheet> createState() => _DecideDeductionSheetState();
}

class _DecideDeductionSheetState extends State<DecideDeductionSheet> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    final note = _noteController.text.trim();
    Navigator.of(context).pop();
    widget.onSubmit(note.isEmpty ? null : note);
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(
                title: widget.waive
                    ? S().deductionWaiveTitle
                    : S().deductionConfirmTitle,
              ),
              AppTextField(
                controller: _noteController,
                hint: S().deductionNoteLabel,
                maxLines: 3,
              ),
              SizedBox(height: 20.h),
              PrimaryCtaButton(
                label: widget.waive
                    ? S().deductionWaiveAction
                    : S().deductionConfirmAction,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
