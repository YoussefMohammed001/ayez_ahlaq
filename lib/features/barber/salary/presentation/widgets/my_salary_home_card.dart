import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';

class MySalaryHomeCard extends StatelessWidget {
  const MySalaryHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: AppCard(
        padding: EdgeInsets.all(14.r),
        onTap: () => context.push(Routes.barberMySalaryScreen),
        child: Row(
          children: [
            Icon(Icons.payments_outlined, color: scheme.primary, size: 28.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S().mySalaryTitle, style: font14w700),
                  SizedBox(height: 2.h),
                  Text(
                    S().mySalaryHomeHint,
                    style: font12w400.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: scheme.onSurfaceVariant,
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}
