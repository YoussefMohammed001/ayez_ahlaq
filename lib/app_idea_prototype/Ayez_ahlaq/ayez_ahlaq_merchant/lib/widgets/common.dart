import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Small shared building blocks used across many screens: section titles,
/// star ratings, status badges, avatars and a quantity stepper. Keeping
/// them here avoids re-implementing the same row of stars in five files.

class SectionTitle extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionTitle({super.key, required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.headingH3),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.brass400, fontWeight: FontWeight.w700),
              ),
            ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final bool showValue;

  const StarRating({super.key, required this.rating, this.size = 14, this.showValue = true});

  @override
  Widget build(BuildContext context) {
    final rounded = rating.round();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          Icon(
            i <= rounded ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: AppColors.brass400,
          ),
        if (showValue) ...[
          const SizedBox(width: 3),
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.ivory100, fontWeight: FontWeight.w700),
          ),
        ],
      ],
    );
  }
}

/// Interactive star picker used for rating a past booking.
class StarRatingInput extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onChanged;
  final double size;

  const StarRatingInput({super.key, required this.rating, required this.onChanged, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () => onChanged(i.toDouble()),
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(
                i <= rating ? Icons.star_rounded : Icons.star_outline_rounded,
                size: size,
                color: i <= rating ? AppColors.brass400 : AppColors.ivory700,
              ),
            ),
          ),
      ],
    );
  }
}

enum BadgeTone { open, closed, gold, danger, muted, info }

class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeTone tone;
  final bool showDot;

  const StatusBadge({super.key, required this.label, required this.tone, this.showDot = true});

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color fg;
    switch (tone) {
      case BadgeTone.open:
        bg = AppColors.moss500.withOpacity(0.16);
        fg = AppColors.moss500;
        break;
      case BadgeTone.closed:
        bg = AppColors.rust500.withOpacity(0.16);
        fg = AppColors.rust400;
        break;
      case BadgeTone.gold:
        bg = AppColors.brass400.withOpacity(0.16);
        fg = AppColors.brass300;
        break;
      case BadgeTone.danger:
        bg = AppColors.rust500.withOpacity(0.16);
        fg = AppColors.rust400;
        break;
      case BadgeTone.muted:
        bg = AppColors.ivory500.withOpacity(0.16);
        fg = AppColors.ivory500;
        break;
      case BadgeTone.info:
        bg = const Color(0xFF6E93A8).withOpacity(0.16);
        fg = const Color(0xFF8FB2C6);
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(100)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(width: 5, height: 5, decoration: BoxDecoration(color: fg, shape: BoxShape.circle)),
            const SizedBox(width: 5),
          ],
          Text(label, style: TextStyle(color: fg, fontSize: 10.5, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class AvatarCircle extends StatelessWidget {
  final String initials;
  final double size;
  final Color? background;
  final Color? foreground;

  const AvatarCircle({super.key, required this.initials, this.size = 56, this.background, this.foreground});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background ?? AppColors.brass600, shape: BoxShape.circle),
      child: Text(
        initials,
        style: TextStyle(
          fontFamily: AppTextStyles.displayH1.fontFamily,
          fontWeight: FontWeight.w800,
          fontSize: size * 0.36,
          color: foreground ?? AppColors.ink950,
        ),
      ),
    );
  }
}

class QtyStepper extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final double buttonSize;

  const QtyStepper({super.key, required this.value, required this.onChanged, this.buttonSize = 30});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.ink800,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepBtn(icon: Icons.remove, size: buttonSize, onTap: () => onChanged(value - 1)),
          SizedBox(
            width: 28,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          _StepBtn(icon: Icons.add, size: buttonSize, onTap: () => onChanged(value + 1)),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;

  const _StepBtn({required this.icon, required this.size, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.ink700,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, size: size * 0.5, color: AppColors.ivory100),
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final String label;
  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.ink750,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Text(label, style: const TextStyle(color: AppColors.ivory300, fontSize: 10.5)),
    );
  }
}

/// Rounded gradient placeholder standing in for a product/shop photo.
class GradientTile extends StatelessWidget {
  final List<Color> colors;
  final double? height;
  final double? width;
  final double radius;

  const GradientTile({super.key, required this.colors, this.height, this.width, this.radius = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
