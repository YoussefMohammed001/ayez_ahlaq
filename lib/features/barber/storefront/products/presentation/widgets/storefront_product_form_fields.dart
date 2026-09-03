import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import '../../../../../../core/widgets/image_picker_row.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../generated/l10n.dart';
import '../../../categories/presentation/widgets/storefront_category_picker_field.dart';
import '../manager/storefront_product_form_controllers.dart';
import 'storefront_product_number_field.dart';
import 'storefront_product_pricing_row.dart';

class StorefrontProductFormFields extends StatelessWidget {
  final StorefrontProductFormControllers controllers;
  final List<XFile> images;
  final ValueChanged<List<XFile>> onImagesChanged;
  final ValueChanged<int?> onCategoryChanged;

  const StorefrontProductFormFields({
    super.key,
    required this.controllers,
    required this.images,
    required this.onImagesChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().productImages),
        ImagePickerRow(images: images, maxCount: 3, onChanged: onImagesChanged),
        SectionTitle(title: S().productName),
        AppTextField(
          controller: controllers.name,
          hint: S().productNameHint,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? S().productNameRequired : null,
        ),
        SectionTitle(title: S().brand),
        AppTextField(controller: controllers.brand, hint: S().brandHint),
        SectionTitle(title: S().category),
        StorefrontCategoryPickerField(
          value: controllers.categoryId,
          onChanged: onCategoryChanged,
        ),
        StorefrontProductPricingRow(
          priceController: controllers.price,
          minOrderController: controllers.minOrder,
        ),
        StorefrontProductNumberField(
          title: S().stockQuantity,
          controller: controllers.stock,
          hint: '50',
          validator: (v) =>
              (int.tryParse(v ?? '') ?? -1) < 0 ? S().invalidNumber : null,
        ),
        SectionTitle(title: S().productDescription),
        AppTextField(
          controller: controllers.description,
          hint: S().productDescriptionHint,
          maxLines: 4,
        ),
      ],
    );
  }
}
