import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '/generated/l10n.dart';
import 'helpers.dart';

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

  static Future<void> showPickerSheet({
    required BuildContext context,
    required void Function(XFile file) onPicked,
    int imageQuality = 80,
  }) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text(S().choose_image_source),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.of(ctx).pop();
              final xfile = await _picker.pickImage(
                source: ImageSource.gallery,
                imageQuality: imageQuality,
              );
              if (xfile != null) onPicked(xfile);
            },
            child: Text(S().gallery),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.of(ctx).pop();
              final xfile = await _picker.pickImage(
                source: ImageSource.camera,
                imageQuality: imageQuality,
              );
              if (xfile != null) onPicked(xfile);
            },
            child: Text(S().camera),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(S().cancel),
        ),
      ),
    );
  }

  static Future<void> showMultiPickerSheet({
    required BuildContext context,
    required List<XFile> current,
    required int maxCount,
    required void Function(XFile file) onPicked,
    int imageQuality = 80,
  }) async {
    if (current.length >= maxCount) return;

    await showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text(S().choose_image_source),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.of(ctx).pop();
              final xfile = await _picker.pickImage(
                source: ImageSource.gallery,
                imageQuality: imageQuality,
              );
              if (xfile != null) onPicked(xfile);
            },
            child: Text(S().gallery),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.of(ctx).pop();
              final xfile = await _picker.pickImage(
                source: ImageSource.camera,
                imageQuality: imageQuality,
              );
              if (xfile != null) onPicked(xfile);
            },
            child: Text(S().camera),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(S().cancel),
        ),
      ),
    );
  }
}
