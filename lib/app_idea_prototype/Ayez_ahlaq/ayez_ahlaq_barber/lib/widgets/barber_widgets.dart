import 'package:flutter/material.dart';
import '../models/queue_entry.dart';
import '../models/week_day.dart';
import '../models/shop_service.dart';
import '../models/review.dart';
import '../theme/app_colors.dart';
import 'common.dart';

/// A tappable pill switch matching the HTML prototype's toggle-track look.
class ToggleSwitch extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;
  const ToggleSwitch({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 44,
        height: 26,
        padding: const EdgeInsets.all(2),
        alignment: value ? Alignment.centerLeft : Alignment.centerRight,
        decoration: BoxDecoration(
          color: value ? AppColors.moss600 : AppColors.ink700,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: value ? AppColors.moss600 : AppColors.hairline),
        ),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: value ? Colors.white : AppColors.ivory500, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  final String value;
  final String label;
  const StatTile({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.hairline)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 18, color: AppColors.brass300, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.ivory500), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

BadgeTone toneForQueueStatus(QueueStatus status) => switch (status) {
      QueueStatus.done => BadgeTone.muted,
      QueueStatus.active => BadgeTone.open,
      QueueStatus.next => BadgeTone.gold,
      QueueStatus.upcoming => BadgeTone.info,
      QueueStatus.cancelled => BadgeTone.danger,
    };

class QueueItemTile extends StatelessWidget {
  final QueueEntry entry;
  final VoidCallback onTap;
  final VoidCallback? onStart;
  final VoidCallback? onFinish;

  const QueueItemTile({super.key, required this.entry, required this.onTap, this.onStart, this.onFinish});

  @override
  Widget build(BuildContext context) {
    Widget? action;
    if (entry.status == QueueStatus.next && onStart != null) {
      action = _MiniActionButton(label: 'ابدأ', onTap: onStart!);
    } else if (entry.status == QueueStatus.active && onFinish != null) {
      action = _MiniActionButton(label: 'إنهاء', dark: true, onTap: onFinish!);
    }

    return Material(
      color: entry.status == QueueStatus.active ? AppColors.moss500.withOpacity(0.06) : AppColors.ink800,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: entry.status == QueueStatus.active ? AppColors.moss600 : AppColors.hairline),
          ),
          child: Row(
            children: [
              SizedBox(width: 44, child: Text(entry.time, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.ivory100))),
              const SizedBox(width: 8),
              AvatarCircle(initials: entry.customerName.substring(0, 1), size: 38),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(child: Text(entry.customerName, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13.5, color: AppColors.ivory100, fontWeight: FontWeight.w700))),
                        if (entry.walkIn) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.directions_walk_rounded, size: 13, color: AppColors.brass400),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text('${entry.service} · ${entry.price} ج · ${entry.barberName}', style: const TextStyle(fontSize: 11, color: AppColors.ivory500)),
                  ],
                ),
              ),
              StatusBadge(label: entry.status.label, tone: toneForQueueStatus(entry.status)),
              if (action != null) ...[const SizedBox(width: 8), action],
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniActionButton extends StatelessWidget {
  final String label;
  final bool dark;
  final VoidCallback onTap;
  const _MiniActionButton({required this.label, required this.onTap, this.dark = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: dark ? AppColors.ink700 : AppColors.brass500,
          borderRadius: BorderRadius.circular(11),
          border: dark ? Border.all(color: AppColors.hairline) : null,
        ),
        child: Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: dark ? AppColors.ivory100 : AppColors.ink950)),
      ),
    );
  }
}

class WeekRow extends StatelessWidget {
  final WeekDay day;
  final VoidCallback onTap;
  const WeekRow({super.key, required this.day, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        margin: const EdgeInsets.only(bottom: 9),
        decoration: BoxDecoration(
          color: AppColors.ink800,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: day.isToday ? AppColors.brass600 : AppColors.hairline),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Row(
                children: [
                  Text(day.day, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.ivory100)),
                  if (day.isToday)
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.brass100, borderRadius: BorderRadius.circular(100)),
                      child: const Text('النهاردة', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppColors.brass400)),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                day.isOff ? 'إجازة' : day.hours,
                style: TextStyle(fontSize: 12, color: day.isOff ? AppColors.rust400 : AppColors.ivory500),
              ),
            ),
            ToggleSwitch(value: !day.isOff, onTap: onTap),
          ],
        ),
      ),
    );
  }
}

class ServiceRow extends StatelessWidget {
  final ShopService service;
  final VoidCallback onToggle;
  const ServiceRow({super.key, required this.service, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: service.active ? 1 : 0.5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        margin: const EdgeInsets.only(bottom: 9),
        decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.name, style: const TextStyle(fontSize: 13.5, color: AppColors.ivory100, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 3),
                  Text('${service.price} ج · ${service.durationMinutes} د', style: const TextStyle(fontSize: 11, color: AppColors.ivory500)),
                ],
              ),
            ),
            const Icon(Icons.edit_outlined, size: 16, color: AppColors.ivory300),
            const SizedBox(width: 12),
            ToggleSwitch(value: service.active, onTap: onToggle),
          ],
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(review.name, style: const TextStyle(fontSize: 13, color: AppColors.ivory100, fontWeight: FontWeight.w700)),
              Text(review.date, style: const TextStyle(fontSize: 10.5, color: AppColors.ivory700)),
            ],
          ),
          const SizedBox(height: 6),
          StarRating(rating: review.stars.toDouble(), size: 12),
          const SizedBox(height: 6),
          Text(review.text, style: const TextStyle(fontSize: 12.5, color: AppColors.ivory300, height: 1.7)),
        ],
      ),
    );
  }
}

class EarningsBarChart extends StatelessWidget {
  final List<MapEntry<String, int>> data;
  final int todayIndex;
  const EarningsBarChart({super.key, required this.data, required this.todayIndex});

  @override
  Widget build(BuildContext context) {
    final maxVal = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < data.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: (data[i].value / maxVal) * 90 + 8,
                      decoration: BoxDecoration(
                        color: i == todayIndex ? AppColors.brass500 : AppColors.ink700,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6), bottom: Radius.circular(3)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(data[i].key, style: const TextStyle(fontSize: 10, color: AppColors.ivory500)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
