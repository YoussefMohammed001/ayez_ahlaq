import 'package:flutter/material.dart';
import '../../../core/helpers/alerts.dart';
import '../../../generated/l10n.dart';
import '../attachments/attachment_source_sheet.dart';
import 'document_file_picker.dart';

abstract class PickAttachmentFlow {
  static Future<String?> run(BuildContext context, {bool allowFiles = false}) async {
    final source = await AttachmentSourceSheet.show(context, allowFiles: allowFiles);
    if (source == null) return null;

    final picked = await DocumentFilePicker.pick(source);
    if (picked == null) return null;

    if (picked.exceedsMaxSize) {
      showError(S().documentTooLarge(DocumentFilePicker.maxSizeInMB));
      return null;
    }

    if (picked.isUnsupportedType) {
      showError(S().documentUnsupportedType);
      return null;
    }

    return picked.path;
  }
}
