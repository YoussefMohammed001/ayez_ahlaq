import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../profile/domain/entities/barber_permissions.dart';
import 'member_permissions_section.dart';

class AddTeamMemberSheet extends StatefulWidget {
  final Future<void> Function(
    String name,
    String phone,
    String? tagline,
    BarberPermissions permissions,
  ) onSubmit;

  const AddTeamMemberSheet({super.key, required this.onSubmit});

  static Future<void> show(
    BuildContext context, {
    required Future<void> Function(
      String name,
      String phone,
      String? tagline,
      BarberPermissions permissions,
    ) onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddTeamMemberSheet(onSubmit: onSubmit),
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
  BarberPermissions _permissions = BarberPermissions.none;
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    final tagline = _taglineController.text.trim();

    await widget.onSubmit(
      _nameController.text.trim(),
      _phoneController.text.trim(),
      tagline.isEmpty ? null : tagline,
      _permissions,
    );

    if (!mounted) return;
    setState(() => _submitting = false);
    Navigator.of(context).pop();
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
                  validator: Validators.validateEgyptianPhoneNumber,
                ),
                SectionTitle(title: S().memberTaglineOptionalLabel),
                AppTextField(
                  controller: _taglineController,
                  hint: S().memberTaglineHint,
                ),
                MemberPermissionsSection(
                  permissions: _permissions,
                  onChanged: (value) => setState(() => _permissions = value),
                ),
                SizedBox(height: 12.h),
                PrimaryCtaButton(
                  label: S().save,
                  isLoading: _submitting,
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
