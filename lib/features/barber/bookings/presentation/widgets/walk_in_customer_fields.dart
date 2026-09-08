import 'package:flutter/material.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';

class WalkInCustomerFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController noteController;

  const WalkInCustomerFields({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().customerLabelOptional),
        AppTextField(
          controller: nameController,
          hint: S().customerLabelOptional,
        ),
        SectionTitle(title: S().customerPhoneLabelOptional),
        AppTextField(
          controller: phoneController,
          hint: S().customerPhoneLabelOptional,
          isNumber: true,
          validator: (value) {
            final phone = value?.trim() ?? '';
            if (phone.isEmpty) return null;
            return Validators.isEgyptianPhoneNumberValid(phone)
                ? null
                : S().please_enter_a_valid_phone_number;
          },
        ),
        SectionTitle(title: S().walkInNoteLabel),
        AppTextField(
          controller: noteController,
          hint: S().walkInNoteHint,
          maxLines: 2,
        ),
      ],
    );
  }
}
