import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../domain/entities/merchant_profile.dart';
import '../manager/merchant_profile_cubit.dart';
import '../manager/merchant_profile_state.dart';
import '../../../../../generated/l10n.dart';

class EditProfileScreen extends StatefulWidget {
  final MerchantProfile profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _businessController = TextEditingController(
    text: widget.profile.businessName,
  );
  late final _ownerController = TextEditingController(
    text: widget.profile.ownerName,
  );
  late final _emailController = TextEditingController(
    text: widget.profile.email,
  );

  @override
  void dispose() {
    _businessController.dispose();
    _ownerController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<MerchantProfileCubit>();
    final saved = await cubit.updateProfile(
      businessName: _businessController.text.trim(),
      ownerName: _ownerController.text.trim(),
      email: _emailController.text.trim(),
    );

    if (!mounted) return;

    if (saved) {
      context.pop();
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().editMyInfo),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
          children: [
            SectionTitle(title: S().businessName),
            AppTextField(
              controller: _businessController,
              hint: S().businessNameHint,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? S().businessNameRequired : null,
            ),
            SectionTitle(title: S().ownerName),
            AppTextField(
              controller: _ownerController,
              hint: S().ownerNameHint,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? S().ownerNameRequired : null,
            ),
            SectionTitle(title: S().emailOptional),
            AppTextField(
              controller: _emailController,
              hint: 'owner@example.com',
            ),
            SizedBox(height: 20.h),
            BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
              builder: (context, state) => PrimaryCtaButton(
                label: S().saveChanges,
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
