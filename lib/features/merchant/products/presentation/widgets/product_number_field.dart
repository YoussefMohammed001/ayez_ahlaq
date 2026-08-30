import 'package:flutter/material.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/section_title.dart';

class ProductNumberField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hint;
  final String? Function(String?) validator;

  const ProductNumberField({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        AppTextField(
          controller: controller,
          hint: hint,
          isNumber: true,
          validator: validator,
        ),
      ],
    );
  }
}
