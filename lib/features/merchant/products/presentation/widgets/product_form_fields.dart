import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/image_picker_row.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../categories/presentation/widgets/category_picker_field.dart';
import '../manager/product_form_controllers.dart';
import 'existing_images_row.dart';
import 'product_number_field.dart';
import 'product_pricing_row.dart';
import '../../../../../generated/l10n.dart';

class ProductFormFields extends StatelessWidget {
  final ProductFormControllers controllers;
  final List<XFile> images;
  final ValueChanged<List<XFile>> onImagesChanged;
  final ValueChanged<int?> onCategoryChanged;
  final int? productId;
  final List<int> existingImageIds;
  final ValueChanged<int>? onDeleteImage;

  const ProductFormFields({
    super.key,
    required this.controllers,
    required this.images,
    required this.onImagesChanged,
    required this.onCategoryChanged,
    this.productId,
    this.existingImageIds = const [],
    this.onDeleteImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().productImages),
        if (productId != null && onDeleteImage != null)
          ExistingImagesRow(
            productId: productId!,
            imageIds: existingImageIds,
            onDelete: onDeleteImage!,
          ),
        ImagePickerRow(
          images: images,
          maxCount: 3 - existingImageIds.length,
          onChanged: onImagesChanged,
        ),
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
        CategoryPickerField(
          value: controllers.categoryId,
          onChanged: onCategoryChanged,
        ),
        ProductPricingRow(
          priceController: controllers.price,
          minOrderController: controllers.minOrder,
        ),
        ProductNumberField(
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
