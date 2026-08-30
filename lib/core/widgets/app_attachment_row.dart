import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class AppAttachmentRow extends StatelessWidget {
  const AppAttachmentRow({
    super.key,
    required this.attachments,
    required this.onAdd,
    required this.onRemove,
    this.maxCount = 3,
    this.size = 90,
  });

  final List<XFile> attachments;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final int maxCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: size.r,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...attachments.asMap().entries.map(
            (e) => Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: _AttachmentThumb(
                file: e.value,
                size: size,
                onRemove: () => onRemove(e.key),
              ),
            ),
          ),
          if (attachments.length < maxCount)
            GestureDetector(
              onTap: onAdd,
              child: Container(
                width: size.r,
                height: size.r,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: colorScheme.tertiary.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_rounded,
                      size: 28.r,
                      color: Theme.of(context).primaryColor,
                    ),
                    4.hSpace,
                    Text(
                      S().addPhoto,
                      style: font11w400.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AttachmentThumb extends StatelessWidget {
  const _AttachmentThumb({
    required this.file,
    required this.onRemove,
    required this.size,
  });

  final XFile file;
  final VoidCallback onRemove;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
            File(file.path),
            width: size.r,
            height: size.r,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4.r,
          right: 4.r,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 22.r,
              height: 22.r,
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close_rounded, size: 14.r, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
