import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/queue_entry.dart';
import '../state/barber_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/barber_widgets.dart';
import '../widgets/common.dart';

class BookingDetailScreen extends StatelessWidget {
  final int index;
  const BookingDetailScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BarberState>();
    final entry = state.queueToday[index];

    return Scaffold(
      appBar: const AppTopBar(title: 'تفاصيل الحجز'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          Row(
            children: [
              AvatarCircle(initials: entry.customerName.substring(0, 1), size: 58),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.customerName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ivory100)),
                    const SizedBox(height: 3),
                    Text(entry.phone, textDirection: TextDirection.ltr, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, color: AppColors.ivory500)),
                  ],
                ),
              ),
              StatusBadge(label: entry.status.label, tone: toneForQueueStatus(entry.status)),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
            child: Column(
              children: [
                _Row(label: 'الحلاق', value: entry.barberName),
                _Row(label: 'الخدمة', value: entry.service),
                _Row(label: 'المعاد', value: '${entry.time} م · ${entry.durationMinutes} دقيقة'),
                _Row(label: 'السعر', value: '${entry.price} ج', valueColor: AppColors.brass300, valueSize: 14, last: true),
              ],
            ),
          ),
          const SectionTitle(title: 'ملاحظات العميل'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.hairline)),
            child: Text(entry.note, style: const TextStyle(fontSize: 12.5, color: AppColors.ivory300, height: 1.8)),
          ),
          const SizedBox(height: 20),
          if (entry.status == QueueStatus.next)
            _ActionButton(label: 'ابدأ الخدمة', onTap: () => state.startService(index)),
          if (entry.status == QueueStatus.active)
            _ActionButton(label: 'إنهاء الخدمة', onTap: () => state.finishService(index)),
          if (entry.status == QueueStatus.upcoming) ...[
            _ActionButton(label: 'إلغاء الحجز', dark: true, danger: true, onTap: () {
              state.cancelBooking(index);
              Navigator.of(context).maybePop();
            }),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 10),
          _ActionButton(label: 'اتصال بالعميل', dark: true, onTap: () {}),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final double valueSize;
  final bool last;
  const _Row({required this.label, required this.value, this.valueColor = AppColors.ivory100, this.valueSize = 13, this.last = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: AppColors.hairline))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.ivory500)),
          Text(value, style: TextStyle(fontSize: valueSize, color: valueColor, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool dark;
  final bool danger;
  const _ActionButton({required this.label, required this.onTap, this.dark = false, this.danger = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: dark ? AppColors.ink700 : AppColors.brass500,
          foregroundColor: danger ? AppColors.rust400 : (dark ? AppColors.ivory100 : AppColors.ink950),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: dark ? const BorderSide(color: AppColors.hairline) : BorderSide.none,
          ),
        ),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}
