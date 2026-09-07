import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/widgets/attachments/attachment_source.dart';
import '../../shared/widgets/attachments/attachment_source_sheet.dart';
import 'helpers.dart';

const _imageExtensions = ['jpg', 'jpeg', 'png', 'webp', 'heic'];

class AppImagePicker {
  AppImagePicker._();

  static final _picker = ImagePicker();

  static Future<File?> pickSingle() async {
    return Helpers.getImageFromCameraOrDevice();
  }

  static Future<List<File>> pickMultiple({
    int maxCount = 10,
    int maxSizeInMB = 5,
  }) async {
    return Helpers.pickLimitedImagesWithMaxSize(
      maxCount: maxCount,
      maxSizeInMB: maxSizeInMB,
    );
  }

  static Future<List<XFile>> pickLimitedXFiles({
    int maxCount = 3,
    int maxSizeInMB = 5,
    int imageQuality = 80,
  }) async {
    final result = await _picker.pickMultiImage(imageQuality: imageQuality);
    if (result.isEmpty) return [];

    final List<XFile> valid = [];
    for (final xfile in result) {
      if (valid.length >= maxCount) break;
      final bytes = await File(xfile.path).length();
      if (bytes / (1024 * 1024) <= maxSizeInMB) {
        valid.add(xfile);
      }
    }
    return valid;
  }

  static Future<XFile?> pickSingleXFile({int imageQuality = 80}) async {
    final file = await Helpers.getImageFromCameraOrDevice();
    if (file == null) return null;
    return XFile(file.path);
  }

  static Future<void> showMultiPickerSheet({
    required BuildContext context,
    required List<XFile> current,
    required int maxCount,
    required void Function(XFile file) onPicked,
    int imageQuality = 80,
  }) async {
    if (current.length >= maxCount) return;

    final source = await AttachmentSourceSheet.show(context);
    if (source == null || !context.mounted) return;

    final xfile = await _pickFrom(source, imageQuality: imageQuality);
    if (xfile != null) onPicked(xfile);
  }

  static Future<XFile?> _pickFrom(
    AttachmentSource source, {
    required int imageQuality,
  }) {
    return switch (source) {
      AttachmentSource.camera => _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
      ),
      AttachmentSource.gallery => _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
      ),
      AttachmentSource.files => _pickImageFile(),
    };
  }

  static Future<XFile?> _pickImageFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _imageExtensions,
      withData: false,
    );

    final path = result?.files.single.path;
    if (path == null) return null;

    return XFile(path);
  }
}
