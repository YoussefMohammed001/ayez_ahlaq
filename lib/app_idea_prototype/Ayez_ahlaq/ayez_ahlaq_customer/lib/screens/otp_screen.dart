import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import '../widgets/app_top_bar.dart';
import 'main_shell.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'تأكيد الرقم'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.ivory500, height: 1.8),
                children: const [
                  TextSpan(text: 'بعتنالك كود مكوّن من 4 أرقام على الرقم\n'),
                  TextSpan(text: '01012345678', style: TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) {
                final filled = i == 0 || i == 1;
                return Container(
                  width: 58,
                  height: 64,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.ink800,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: i == 1 ? AppColors.brass500 : AppColors.hairline, width: i == 1 ? 2 : 1),
                  ),
                  child: Text(
                    filled ? (i == 0 ? '5' : '2') : '',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ivory100),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            AppButton(
              label: 'تأكيد',
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MainShell()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text('إعادة إرسال الكود بعد 00:59', style: TextStyle(color: AppColors.ivory700, fontSize: 12.5, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
