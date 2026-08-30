import 'package:flutter/material.dart';
import '../models/shop.dart';
import '../models/barber.dart';
import '../models/service.dart';
import '../models/product.dart';
import '../models/time_slot.dart';
import '../models/haircut_style.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'common.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const ShopCard({
    super.key,
    required this.shop,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.ink800,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.hairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  GradientTile(colors: shop.gradient, height: 86, width: double.infinity),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: GestureDetector(
                      onTap: onToggleFavorite,
                      child: Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 15,
                          color: isFavorite ? AppColors.rust400 : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              Text(shop.name, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700, fontSize: 14.5)),
              const SizedBox(height: 4),
              Row(
                children: [
                  StarRating(rating: shop.rating, size: 12),
                  const SizedBox(width: 4),
                  Text('· ${shop.reviews} تقييم', style: AppTextStyles.bodySmall),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 13, color: AppColors.ivory500),
                  const SizedBox(width: 4),
                  Expanded(child: Text('${shop.distance} · ${shop.area}', style: AppTextStyles.bodySmall)),
                ],
              ),
              const SizedBox(height: 9),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final tag in shop.tags) TagChip(label: tag),
                  StatusBadge(
                    label: shop.open ? 'مفتوح دلوقتي' : shop.closesAt,
                    tone: shop.open ? BadgeTone.open : BadgeTone.closed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BarberCard extends StatelessWidget {
  final Barber barber;
  final VoidCallback onTap;
  final bool showPortfolio;

  const BarberCard({super.key, required this.barber, required this.onTap, this.showPortfolio = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.ink800,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.hairline),
            ),
            child: Row(
              children: [
                AvatarCircle(initials: barber.name.substring(0, 1), size: 54),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(barber.name, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700, fontSize: 14.5)),
                      const SizedBox(height: 3),
                      Text(barber.tag, style: AppTextStyles.bodySmall),
                      const SizedBox(height: 4),
                      StarRating(rating: barber.rating, size: 12),
                      if (showPortfolio) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            for (final c in barber.portfolio)
                              Container(
                                margin: const EdgeInsetsDirectional.only(end: 4),
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(6)),
                              ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 7),
                      StatusBadge(
                        label: barber.status,
                        tone: barber.ok ? BadgeTone.open : BadgeTone.closed,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_left, color: AppColors.ivory700),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final BarberService service;
  final bool selected;
  final VoidCallback onTap;

  const ServiceCard({super.key, required this.service, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 6),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: selected ? AppColors.brass500.withOpacity(0.08) : AppColors.ink800,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: selected ? AppColors.brass500 : AppColors.hairline, width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 21,
                      height: 21,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected ? AppColors.brass500 : Colors.transparent,
                        border: Border.all(color: selected ? AppColors.brass500 : AppColors.ivory700, width: 1.5),
                      ),
                      child: selected ? const Icon(Icons.check, size: 13, color: AppColors.ink950) : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(service.name, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                          const SizedBox(height: 3),
                          Text(service.desc, style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${service.price} ج', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.brass300, fontWeight: FontWeight.w800, fontSize: 14.5)),
                        Text('${service.durationMinutes} د', style: AppTextStyles.bodySmall.copyWith(fontSize: 10.5)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (service.popular)
            Positioned(
              top: -9,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: AppColors.brass500, borderRadius: BorderRadius.circular(100)),
                child: const Text('الأكثر طلبًا', style: TextStyle(color: AppColors.ink950, fontSize: 9.5, fontWeight: FontWeight.w800)),
              ),
            ),
        ],
      ),
    );
  }
}

class DateChip extends StatelessWidget {
  final DateOption date;
  final bool selected;
  final VoidCallback onTap;

  const DateChip({super.key, required this.date, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 68,
        alignment: Alignment.center,
        margin: const EdgeInsetsDirectional.only(end: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.ink950 : AppColors.ink800,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? AppColors.ink950 : AppColors.hairline),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(date.day, style: TextStyle(fontSize: 11, color: selected ? AppColors.ivory100 : AppColors.ivory500)),
            const SizedBox(height: 3),
            Text('${date.num}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: selected ? AppColors.ivory100 : AppColors.ivory100)),
          ],
        ),
      ),
    );
  }
}

class TimeChip extends StatelessWidget {
  final TimeSlot slot;
  final bool selected;
  final VoidCallback? onTap;

  const TimeChip({super.key, required this.slot, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final booked = slot.status == SlotStatus.booked;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: booked ? null : onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? AppColors.brass500 : AppColors.ink800,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: selected ? AppColors.brass500 : AppColors.hairline),
            ),
            child: Text(
              slot.time,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: booked ? AppColors.ivory700 : (selected ? AppColors.ink950 : AppColors.ivory100),
                decoration: booked ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ),
        if (slot.queueAhead != null)
          Positioned(
            top: -7,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(color: AppColors.rust500, borderRadius: BorderRadius.circular(100)),
                child: Text('${slot.queueAhead}', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
              ),
            ),
          ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onQuickAdd;

  const ProductCard({super.key, required this.product, required this.onTap, required this.onQuickAdd});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.ink800,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.hairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientTile(colors: product.gradient, height: 92, width: double.infinity),
              const SizedBox(height: 7),
              SizedBox(
                height: 34,
                child: Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: AppColors.ivory100, height: 1.4),
                ),
              ),
              StarRating(rating: product.rating, size: 11),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${product.price} ج', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.brass300)),
                  GestureDetector(
                    onTap: onQuickAdd,
                    child: Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: AppColors.brass500, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.add, size: 16, color: AppColors.ink950),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom action bar pinned to the screen (price/total + a primary CTA),
/// used on checkout-style screens.
class StickyFooter extends StatelessWidget {
  final Widget child;
  const StickyFooter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 22),
      decoration: BoxDecoration(
        color: AppColors.ink900,
        border: const Border(top: BorderSide(color: AppColors.hairline)),
      ),
      child: SafeArea(top: false, child: Row(children: [Expanded(child: child)])),
    );
  }
}

class PriceTotalLabel extends StatelessWidget {
  final String label;
  final String value;
  const PriceTotalLabel({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyles.bodySmall.copyWith(fontSize: 10.5)),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.brass300)),
      ],
    );
  }
}

/// A named haircut style shown as a small square thumbnail + label — e.g.
/// "مولت" — with its price add-on, used in the style-picker grid.
class StyleSwatchCard extends StatelessWidget {
  final HaircutStyle style;
  final bool selected;
  final VoidCallback onTap;

  const StyleSwatchCard({super.key, required this.style, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: style.swatch, begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: selected ? AppColors.brass400 : Colors.transparent, width: 2.5),
                  ),
                ),
              ),
              if (selected)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColors.brass500, shape: BoxShape.circle),
                    child: const Icon(Icons.check, size: 13, color: AppColors.ink950),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            style.name,
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: selected ? AppColors.brass300 : AppColors.ivory100),
          ),
          const SizedBox(height: 2),
          Text(
            style.priceDelta == 0 ? 'من غير زيادة' : (style.priceDelta > 0 ? '+${style.priceDelta} ج' : '${style.priceDelta} ج'),
            style: const TextStyle(fontSize: 10.5, color: AppColors.ivory500),
          ),
        ],
      ),
    );
  }
}
