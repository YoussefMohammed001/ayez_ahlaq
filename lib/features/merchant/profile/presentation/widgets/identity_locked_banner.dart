import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../helpers/merchant_access.dart';

class IdentityLockedBanner extends StatelessWidget {
  const IdentityLockedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.canEditIdentity) return const SizedBox.shrink();

    return AppCard(
      margin: EdgeInsets.only(bottom: 6.h),
      borderColor: context.semantic.accentStrong.withValues(alpha: 0.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_outlined,
            size: 20.r,
            color: context.semantic.accentStrong,
          ),
          SizedBox(width: 10.w),
          Expanded(child: _buildText(context)),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S().identityLockedTitle,
          style: font14w400.copyWith(
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          S().identityLockedMessage,
          style: font12w400.copyWith(
            height: 1.7,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
