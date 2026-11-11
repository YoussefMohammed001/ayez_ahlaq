import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/form_sheet_frame.dart';
import '../../domain/entities/merchant_member.dart';

typedef EditMerchantMemberSubmit =
    Future<void> Function(String name, String phone);

class EditMerchantMemberSheet extends StatefulWidget {
  final MerchantMember member;
  final EditMerchantMemberSubmit onSubmit;

  const EditMerchantMemberSheet({
    super.key,
    required this.member,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required MerchantMember member,
    required EditMerchantMemberSubmit onSubmit,
  }) {
    return FormSheetFrame.show(
      context,
      (_) => EditMerchantMemberSheet(member: member, onSubmit: onSubmit),
    );
  }

  @override
  State<EditMerchantMemberSheet> createState() =>
      _EditMerchantMemberSheetState();
}

class _EditMerchantMemberSheetState extends State<EditMerchantMemberSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.member.name);
  late final _phoneController = TextEditingController(
    text: widget.member.phoneNumber,
  );

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    Navigator.of(context).pop();
    widget.onSubmit(name, phone);
  }

  @override
  Widget build(BuildContext context) {
    return FormSheetFrame(
      formKey: _formKey,
      children: [
        SectionTitle(title: S().editMemberTitle),
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
        SizedBox(height: 20.h),
        PrimaryCtaButton(label: S().save, onPressed: _submit),
      ],
    );
  }
}
