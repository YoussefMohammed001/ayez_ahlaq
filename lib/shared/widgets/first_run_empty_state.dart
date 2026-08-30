import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';
import 'package:ayez_ahlaq/core/widgets/app_button.dart';

class FirstRunEmptyState extends StatelessWidget {
  const FirstRunEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.ctaLabel,
    this.onCta,
    this.ctaChild,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? ctaLabel;
  final VoidCallback? onCta;
  final Widget? ctaChild;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96.w,
              height: 96.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 44.r, color: cs.primary),
            ),
            20.hSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              style: font18w700.copyWith(color: cs.onSurface),
            ),
            8.hSpace,
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: font13w500.copyWith(color: cs.tertiary),
            ),
            if (ctaChild != null) ...[24.hSpace, ctaChild!],
            if (ctaChild == null && ctaLabel != null && onCta != null) ...[
              24.hSpace,
              AppButton(
                text: ctaLabel!,
                onPressed: onCta,
                prefixIcon: Icon(Icons.add, color: cs.onPrimary, size: 20.r),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
