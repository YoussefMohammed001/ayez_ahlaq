import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';

class StorefrontDeliveryFeeFields extends StatelessWidget {
  final TextEditingController feeController;
  final TextEditingController freeOverController;

  const StorefrontDeliveryFeeFields({
    super.key,
    required this.feeController,
    required this.freeOverController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().deliveryFeeLabel),
        AppTextField(
          controller: feeController,
          hint: S().deliveryFeeHint,
          isNumber: true,
          validator: (value) {
            final fee = int.tryParse(value?.trim() ?? '');
            return (fee == null || fee < 0) ? S().deliveryFeeRequired : null;
          },
        ),
        SectionTitle(title: S().deliveryFreeOverLabel),
        AppTextField(
          controller: freeOverController,
          hint: S().deliveryFreeOverHint,
          isNumber: true,
        ),
        SizedBox(height: 6.h),
        Text(
          S().deliveryFreeOverNote,
          style: TextStyle(
            fontSize: 11.5.sp,
            height: 1.7,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
