import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import 'main_shell.dart';

class BookingSuccessScreen extends StatefulWidget {
  final String bookingCode;
  const BookingSuccessScreen({super.key, required this.bookingCode});

  @override
  State<BookingSuccessScreen> createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    final barberName = context.read<AppState>().selectedBarber.name;

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
              Text('تم تأكيد حجزك 🎉', style: AppTextStyles.headingH2, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.ivory500, fontSize: 13, height: 1.8),
                  children: [
                    const TextSpan(text: 'هنبعتلك تذكير قبل معادك بساعة. رقم حجزك '),
                    TextSpan(text: widget.bookingCode, style: const TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              AppButton(
                label: _copied ? 'تم نسخ رابط $barberName 🔗' : 'شارك رابط الحلاق مع صحابك',
                style: AppButtonStyle.dark,
                icon: const Icon(Icons.ios_share_rounded, size: 16, color: AppColors.ivory100),
                onPressed: () => setState(() => _copied = true),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'حجوزاتي',
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainShell(initialIndex: 3)),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
