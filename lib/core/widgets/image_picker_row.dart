import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/app_image_picker.dart';
import '../../core/extensions/ext_theme.dart';

class ImagePickerRow extends StatelessWidget {
  final List<XFile> images;
  final int maxCount;
  final ValueChanged<List<XFile>> onChanged;

  const ImagePickerRow({
    super.key,
    required this.images,
    required this.onChanged,
    this.maxCount = 3,
  });

  Future<void> _pick(BuildContext context) async {
    await AppImagePicker.showMultiPickerSheet(
      context: context,
      current: images,
      maxCount: maxCount,
      onPicked: (file) => onChanged([...images, file]),
    );
  }

  void _remove(XFile file) {
    onChanged(images.where((e) => e.path != file.path).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (final image in images) _buildThumb(context, image),
        if (images.length < maxCount) _buildAddButton(context),
      ],
    );
  }

  Widget _buildThumb(BuildContext context, XFile image) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
            File(image.path),
            width: 78.r,
            height: 78.r,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 2.r,
          left: 2.r,
          child: GestureDetector(
            onTap: () => _remove(image),
            child: Container(
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerLowest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 13.r,
                color: context.semantic.warning,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _pick(context),
      child: Container(
        width: 78.r,
        height: 78.r,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: context.colorScheme.outline),
        ),
        child: Icon(
          Icons.add_a_photo_outlined,
          size: 22.r,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
