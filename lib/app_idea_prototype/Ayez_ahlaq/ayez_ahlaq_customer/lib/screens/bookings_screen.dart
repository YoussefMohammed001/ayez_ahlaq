import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/booking.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/common.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final upcoming = state.bookings.where((b) => !b.done).toList();
    final past = state.bookings.where((b) => b.done).toList();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Text('حجوزاتي', style: AppTextStyles.headingH2),
            const SizedBox(height: 14),
            if (upcoming.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text('مفيش حجوزات قادمة', style: AppTextStyles.bodySmall.copyWith(color: AppColors.ivory700), textAlign: TextAlign.center),
              )
            else
              for (final b in upcoming) _UpcomingCard(booking: b),
            const SectionTitle(title: 'حجوزات سابقة'),
            for (final b in past) _PastCard(booking: b, onRate: (r) => state.rateBooking(b, r)),
          ],
        ),
      ),
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  final Booking booking;
  const _UpcomingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.brass600),
        gradient: LinearGradient(colors: [AppColors.brass500.withOpacity(0.14), AppColors.ink800]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('${booking.shop.name} · ${booking.barber.name}', style: const TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w700, fontSize: 14.5)),
              ),
              const StatusBadge(label: 'قادم', tone: BadgeTone.gold),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.ivory300),
              const SizedBox(width: 6),
              Text('${booking.dateLabel} — ${booking.time}', style: const TextStyle(fontSize: 12, color: AppColors.ivory300)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 13, color: AppColors.ivory300),
              const SizedBox(width: 6),
              Text('${booking.service.name} (${booking.styleName}) · ${booking.totalPrice} ج', style: const TextStyle(fontSize: 12, color: AppColors.ivory300)),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.hairline)),
            child: Row(
              children: [
                Container(width: 9, height: 9, decoration: const BoxDecoration(color: AppColors.moss500, shape: BoxShape.circle)),
                const SizedBox(width: 10),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.ivory300, fontSize: 12.5),
                      children: [
                        const TextSpan(text: 'قدامك '),
                        TextSpan(text: '${booking.queueAhead}', style: const TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                        const TextSpan(text: ' عميل دلوقتي — معادك متوقع الساعة '),
                        TextSpan(text: booking.time, style: const TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                        const TextSpan(text: ' تقريبًا'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _MiniBtn(label: 'تعديل')),
              const SizedBox(width: 10),
              Expanded(child: _MiniBtn(label: 'إلغاء الحجز', danger: true)),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniBtn extends StatelessWidget {
  final String label;
  final bool danger;
  const _MiniBtn({required this.label, this.danger = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.ink700,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: danger ? AppColors.rust400 : AppColors.ivory100)),
    );
  }
}

class _PastCard extends StatelessWidget {
  final Booking booking;
  final ValueChanged<double> onRate;
  const _PastCard({required this.booking, required this.onRate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text('${booking.shop.name} · ${booking.barber.name}', style: const TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w600, fontSize: 13.5))),
              Text(booking.dateLabel, style: const TextStyle(fontSize: 11, color: AppColors.ivory500)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 12, color: AppColors.ivory500),
              const SizedBox(width: 6),
              Text('${booking.service.name} (${booking.styleName})', style: const TextStyle(fontSize: 11.5, color: AppColors.ivory500)),
            ],
          ),
          const SizedBox(height: 6),
          StarRatingInput(rating: booking.rating, onChanged: onRate, size: 19),
        ],
      ),
    );
  }
}
