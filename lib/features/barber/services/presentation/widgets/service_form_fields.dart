import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/switch_row_widget.dart';

class ServiceFormFields extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController durationController;
  final bool popular;
  final ValueChanged<bool> onPopularChanged;

  const ServiceFormFields({
    super.key,
    required this.priceController,
    required this.durationController,
    required this.popular,
    required this.onPopularChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().servicePriceLabel),
        AppTextField(
          controller: priceController,
          hint: S().servicePriceHint,
          isNumber: true,
          validator: (v) =>
              (int.tryParse(v ?? '') ?? -1) <= 0 ? S().invalidPrice : null,
        ),
        SectionTitle(title: S().serviceDurationLabel),
        AppTextField(
          controller: durationController,
          hint: S().serviceDurationHint,
          isNumber: true,
          validator: (v) =>
              (int.tryParse(v ?? '') ?? -1) <= 0 ? S().invalidNumber : null,
        ),
        SizedBox(height: 12.h),
        SwitchRow(
          label: S().servicePopularLabel,
          value: popular,
          cs: context.colorScheme,
          onChanged: onPopularChanged,
        ),
      ],
    );
  }
}
