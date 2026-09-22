import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';

class HomeServicePriceFields extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController noteController;

  const HomeServicePriceFields({
    super.key,
    required this.priceController,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().homeServicePriceLabel),
        AppTextField(
          controller: priceController,
          hint: S().homeServicePriceHint,
          isNumber: true,
          validator: (value) {
            final price = int.tryParse(value?.trim() ?? '');
            return (price == null || price <= 0)
                ? S().homeServicePriceRequired
                : null;
          },
        ),
        SizedBox(height: 12.h),
        SectionTitle(title: S().homeServiceNoteLabel),
        AppTextField(
          controller: noteController,
          hint: S().homeServiceNoteHint,
          maxLines: 3,
        ),
      ],
    );
  }
}
