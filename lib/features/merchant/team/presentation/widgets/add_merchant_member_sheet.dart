import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/form_sheet_frame.dart';
import '../../../../barber/salary/presentation/helpers/salary_amount_validator.dart';
import '../../../../barber/team/presentation/helpers/temp_password_validator.dart';
import '../../domain/entities/merchant_member_permissions.dart';
import 'merchant_member_permissions_section.dart';

typedef AddMerchantMemberSubmit =
    Future<void> Function({
      required String name,
      required String phone,
      String? password,
      double? salary,
      required MerchantMemberPermissions permissions,
    });

class AddMerchantMemberSheet extends StatefulWidget {
  final AddMerchantMemberSubmit onSubmit;

  const AddMerchantMemberSheet({super.key, required this.onSubmit});

  static Future<void> show(
    BuildContext context, {
    required AddMerchantMemberSubmit onSubmit,
  }) {
    return FormSheetFrame.show(
      context,
      (_) => AddMerchantMemberSheet(onSubmit: onSubmit),
    );
  }

  @override
  State<AddMerchantMemberSheet> createState() => _AddMerchantMemberSheetState();
}

class _AddMerchantMemberSheetState extends State<AddMerchantMemberSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _salaryController = TextEditingController();
  var _permissions = const MerchantMemberPermissions();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  String? _validateSalary(String? value) => (value ?? '').trim().isEmpty
      ? null
      : SalaryAmountValidator.validate(value);

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final password = _passwordController.text;
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final salary = SalaryAmountValidator.parse(_salaryController.text);
    final permissions = _permissions;

    Navigator.of(context).pop();
    widget.onSubmit(
      name: name,
      phone: phone,
      password: password.isEmpty ? null : password,
      salary: salary,
      permissions: permissions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormSheetFrame(
      formKey: _formKey,
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
        SectionTitle(title: S().memberTempPasswordOptionalLabel),
        AppTextField(
          controller: _passwordController,
          hint: S().passwordMinHint,
          validator: TempPasswordValidator.optional,
        ),
        SizedBox(height: 6.h),
        AppText(
          S().memberDefaultPasswordNote,
          style: font11w500.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SectionTitle(title: S().memberSalaryOptionalLabel),
        AppTextField(
          controller: _salaryController,
          hint: S().salaryAmountLabel,
          isNumber: true,
          validator: _validateSalary,
        ),
        MerchantMemberPermissionsSection(
          permissions: _permissions,
          onChanged: (value) => setState(() => _permissions = value),
        ),
        SizedBox(height: 12.h),
        PrimaryCtaButton(label: S().save, onPressed: _submit),
      ],
    );
  }
}
