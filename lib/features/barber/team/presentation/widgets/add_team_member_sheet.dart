import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class AddTeamMemberSheet extends StatefulWidget {
  final bool isSubmitting;
  final Future<bool> Function(String name, String phone, String? tagline) onSubmit;

  const AddTeamMemberSheet({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required bool isSubmitting,
    required Future<bool> Function(String name, String phone, String? tagline) onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          AddTeamMemberSheet(isSubmitting: isSubmitting, onSubmit: onSubmit),
    );
  }

  @override
  State<AddTeamMemberSheet> createState() => _AddTeamMemberSheetState();
}

class _AddTeamMemberSheetState extends State<AddTeamMemberSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _taglineController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final tagline = _taglineController.text.trim();

    final saved = await widget.onSubmit(
      _nameController.text.trim(),
      _phoneController.text.trim(),
      tagline.isEmpty ? null : tagline,
    );

    if (saved && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                SectionTitle(title: S().addMemberTitle),
                AppTextField(
                  controller: _nameController,
                  hint: S().memberNameHint,
                  validator: (v) =>
                      (v ?? '').trim().isEmpty ? S().memberNameLabel : null,
                ),
                SectionTitle(title: S().memberPhoneLabel),
                AppTextField(
                  controller: _phoneController,
                  hint: S().memberPhoneHint,
                  isNumber: true,
                  validator: (v) =>
                      (v ?? '').trim().isEmpty ? S().memberPhoneLabel : null,
                ),
                SectionTitle(title: S().memberTaglineOptionalLabel),
                AppTextField(
                  controller: _taglineController,
                  hint: S().memberTaglineHint,
                ),
                SizedBox(height: 20.h),
                PrimaryCtaButton(
                  label: S().save,
                  isLoading: widget.isSubmitting,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
