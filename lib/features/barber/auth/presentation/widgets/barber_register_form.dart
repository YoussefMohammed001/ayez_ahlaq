import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_password_field.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/labeled_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../../data/requests/barber_register_request.dart';

class BarberRegisterForm extends StatefulWidget {
  final bool isSubmitting;
  final ValueChanged<BarberRegisterRequest> onSubmit;

  const BarberRegisterForm({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  State<BarberRegisterForm> createState() => _BarberRegisterFormState();
}

class _BarberRegisterFormState extends State<BarberRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _areaController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _shopNameController.dispose();
    _areaController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSubmit(
      BarberRegisterRequest(
        name: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text,
        shopName: _shopNameController.text.trim(),
        area: _areaController.text.trim(),
        address: _addressController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LabeledField(
            label: S().barberName,
            child: AppTextField(
              controller: _nameController,
              hint: S().userNameHint,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? S().barberNameRequired
                  : null,
            ),
          ),
          LabeledField(
            label: S().phoneNumber,
            child: AppTextField(
              controller: _phoneController,
              hint: '01001234567',
              isNumber: true,
              validator: (v) => (v == null || v.trim().length < 10)
                  ? S().please_enter_a_valid_phone_number
                  : null,
            ),
          ),
          LabeledField(
            label: S().password,
            child: AppPasswordField(
              controller: _passwordController,
              hint: S().passwordMinHint,
              validator: (v) =>
                  (v == null || v.length < 6) ? S().passwordTooShort : null,
            ),
          ),
          LabeledField(
            label: S().shopName,
            child: AppTextField(
              controller: _shopNameController,
              hint: S().shopNameHint,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? S().shopNameRequired : null,
            ),
          ),
          LabeledField(
            label: S().area,
            child: AppTextField(
              controller: _areaController,
              hint: S().areaHint,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? S().areaRequired : null,
            ),
          ),
          LabeledField(
            label: S().address,
            child: AppTextField(
              controller: _addressController,
              hint: S().addressHint,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? S().addressRequired : null,
            ),
          ),
          SizedBox(height: 6.h),
          PrimaryCtaButton(
            label: S().createAccount,
            isLoading: widget.isSubmitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
