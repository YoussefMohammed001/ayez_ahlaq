import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import 'main_shell.dart';
import 'my_orders_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderCode;
  const OrderSuccessScreen({super.key, required this.orderCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 88,
                height: 88,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.moss500.withOpacity(0.14), shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, size: 44, color: AppColors.moss500),
              ),
              const SizedBox(height: 14),
              Text('تم تأكيد طلبك 🎉', style: AppTextStyles.headingH2, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.ivory500, fontSize: 13, height: 1.8),
                  children: [
                    const TextSpan(text: 'هيوصلك خلال يومين لتلاتة. رقم الطلب '),
                    TextSpan(text: orderCode, style: const TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              AppButton(
                label: 'تتبع طلباتي',
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MyOrdersScreen())),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'رجوع للمتجر',
                style: AppButtonStyle.dark,
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MainShell(initialIndex: 2)),
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
