import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import 'main_shell.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 72,
                height: 72,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.brass100, borderRadius: BorderRadius.circular(20)),
                child: const Text('✂', style: TextStyle(fontSize: 30, color: AppColors.brass400)),
              ),
              const SizedBox(height: 28),
              Text('أهلاً بيك 👋', style: AppTextStyles.displayH1.copyWith(fontSize: 24)),
              const SizedBox(height: 10),
              Text(
                'سجّل برقم موبايلك عشان تقدر تحجز عند حلاقك المفضل',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.ivory500),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.ink800,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.brass500, width: 1.5),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: '01xxxxxxxxx',
                          hintStyle: TextStyle(color: AppColors.ivory700),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text('+20', style: TextStyle(color: AppColors.ivory300, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppButton(
                label: 'إرسال الكود',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OtpScreen()));
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const MainShell()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'المتابعة كزائر بدون تسجيل',
                    style: TextStyle(color: AppColors.brass400, fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
