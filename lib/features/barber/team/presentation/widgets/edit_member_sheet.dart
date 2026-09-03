import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/team_member_detail.dart';

class EditMemberSheet extends StatefulWidget {
  final TeamMemberDetail member;
  final bool isSubmitting;
  final Future<bool> Function(String name, String tagline) onSubmit;

  const EditMemberSheet({
    super.key,
    required this.member,
    required this.isSubmitting,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required TeamMemberDetail member,
    required bool isSubmitting,
    required Future<bool> Function(String name, String tagline) onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditMemberSheet(
        member: member,
        isSubmitting: isSubmitting,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  State<EditMemberSheet> createState() => _EditMemberSheetState();
}

class _EditMemberSheetState extends State<EditMemberSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.member.name);
  late final _taglineController =
      TextEditingController(text: widget.member.tagline);

  @override
  void dispose() {
    _nameController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final saved = await widget.onSubmit(
      _nameController.text.trim(),
      _taglineController.text.trim(),
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
                SectionTitle(title: S().editMemberTitle),
                AppTextField(
                  controller: _nameController,
                  hint: S().memberNameHint,
                  validator: (v) =>
                      (v ?? '').trim().isEmpty ? S().memberNameLabel : null,
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
