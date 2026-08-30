import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../manager/merchant_phones_cubit.dart';
import '../manager/merchant_phones_state.dart';

class AddPhoneSheet extends StatefulWidget {
  const AddPhoneSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<MerchantPhonesCubit>(),
        child: const AddPhoneSheet(),
      ),
    );
  }

  @override
  State<AddPhoneSheet> createState() => _AddPhoneSheetState();
}

class _AddPhoneSheetState extends State<AddPhoneSheet> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _labelController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<MerchantPhonesCubit>();
    final added = await cubit.addPhone(
      _phoneController.text.trim(),
      _labelController.text.trim(),
    );

    if (!mounted) return;

    if (added) {
      Navigator.of(context).pop();
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20.w,
          0,
          20.w,
          MediaQuery.viewInsetsOf(context).bottom + 24.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: S().addPhoneTitle),
            AppTextField(
              controller: _phoneController,
              hint: '01112223334',
              isNumber: true,
              validator: (v) => (v == null || v.trim().length < 10)
                  ? S().please_enter_a_valid_phone_number
                  : null,
            ),
            SectionTitle(title: S().phoneLabel),
            AppTextField(
              controller: _labelController,
              hint: S().phoneLabelHint,
            ),
            SizedBox(height: 16.h),
            BlocBuilder<MerchantPhonesCubit, MerchantPhonesState>(
              builder: (context, state) => PrimaryCtaButton(
                label: S().add,
                isLoading: state.isSubmitting,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
