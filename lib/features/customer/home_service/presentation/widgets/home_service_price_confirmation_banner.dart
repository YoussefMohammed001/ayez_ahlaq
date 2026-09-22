import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class HomeServicePriceConfirmationBanner extends StatelessWidget {
  final num basePrice;
  final num finalPrice;
  final bool isConfirming;
  final VoidCallback onConfirm;

  const HomeServicePriceConfirmationBanner({
    super.key,
    required this.basePrice,
    required this.finalPrice,
    required this.isConfirming,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: context.semantic.warning,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S().homeServicePriceChangedTitle,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            S().homeServicePriceChangedMessage(
              S().currencyEgp(basePrice),
              S().currencyEgp(finalPrice),
            ),
            style: TextStyle(fontSize: 12.sp, color: context.colorScheme.onSurfaceVariant),
          ),
          SizedBox(height: 12.h),
          PrimaryCtaButton(
            label: S().homeServiceConfirmNewPrice,
            isLoading: isConfirming,
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}
