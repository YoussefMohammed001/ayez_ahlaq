import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import '../widgets/common.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ink950,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AvatarCircle(initials: 'ح', size: 96, background: AppColors.brass500, foreground: AppColors.ink950),
              const SizedBox(height: 16),
              Text('عايز أحلق', style: AppTextStyles.displayH1.copyWith(fontSize: 30), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                'احجز مع أفضل الحلاقين في منطقتك من غير ما تستنى',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.ivory500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: 220,
                child: AppButton(
                  label: 'ابدأ الآن',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
