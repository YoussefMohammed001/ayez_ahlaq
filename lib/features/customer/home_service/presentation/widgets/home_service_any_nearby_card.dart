import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';

class HomeServiceAnyNearbyCard extends StatelessWidget {
  final VoidCallback onPressed;

  const HomeServiceAnyNearbyCard({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S().homeServiceAnyNearbyTitle,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: context.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              S().homeServiceAnyNearbyDescription,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 12.h),
            PrimaryCtaButton(
              label: S().homeServiceAnyNearbyCta,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
