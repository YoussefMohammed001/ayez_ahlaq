import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../core/theme/styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/otp_code_field.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/resend_button.dart';
import 'auth_brand_header.dart';

class OtpVerificationView extends StatefulWidget {
  final String phone;
  final bool isSubmitting;
  final ValueChanged<String> onVerify;
  final VoidCallback? onResend;

  const OtpVerificationView({
    super.key,
    required this.phone,
    required this.isSubmitting,
    required this.onVerify,
    this.onResend,
  });

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final code = _controller.text.trim();
    if (code.length < 6) return;
    widget.onVerify(code);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
      children: [
        AuthBrandHeader(
          title: S().verifyPhoneTitle,
          subtitle: S().verifyPhoneSubtitle,
        ),
        SizedBox(height: 22.h),
        AppCard(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
          child: Column(
            children: [
              Text(
                '${S().otpSentTo} ${widget.phone}',
                textAlign: TextAlign.center,
                style: font13w500.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 18.h),
              OtpCodeField(
                controller: _controller,
                onCompleted: widget.onVerify,
              ),
              SizedBox(height: 20.h),
              PrimaryCtaButton(
                label: S().verify,
                isLoading: widget.isSubmitting,
                onPressed: _submit,
              ),
              if (widget.onResend != null) ...[
                SizedBox(height: 14.h),
                ResendButton(onResend: widget.onResend!),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
