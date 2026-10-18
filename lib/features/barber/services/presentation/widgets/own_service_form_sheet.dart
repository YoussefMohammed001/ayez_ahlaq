import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class OwnServiceFormSheet extends StatefulWidget {
  final Future<bool> Function(String name, String description) onSubmit;

  const OwnServiceFormSheet({super.key, required this.onSubmit});

  static Future<void> show(
    BuildContext context, {
    required Future<bool> Function(String name, String description) onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OwnServiceFormSheet(onSubmit: onSubmit),
    );
  }

  @override
  State<OwnServiceFormSheet> createState() => _OwnServiceFormSheetState();
}

class _OwnServiceFormSheetState extends State<OwnServiceFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    final saved = await widget.onSubmit(
      _nameController.text.trim(),
      _descriptionController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _submitting = false);
    if (saved) Navigator.of(context).pop();
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
                SectionTitle(title: S().addOwnServiceTitle),
                SectionTitle(title: S().ownServiceNameLabel),
                AppTextField(
                  controller: _nameController,
                  hint: S().ownServiceNameHint,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? S().requiredField : null,
                ),
                SectionTitle(title: S().ownServiceDescriptionLabel),
                AppTextField(
                  controller: _descriptionController,
                  hint: S().ownServiceDescriptionHint,
                  maxLines: 3,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? S().requiredField : null,
                ),
                SizedBox(height: 20.h),
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
