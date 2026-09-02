import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../shared/widgets/attachments/attachment_source.dart';
import 'document_pick_result.dart';

class DocumentFilePicker {
  DocumentFilePicker._();

  static const int maxSizeInMB = 15;

  static const List<String> allowedExtensions = [
    'jpg',
    'jpeg',
    'png',
    'webp',
    'heic',
    'pdf',
  ];

  static final _imagePicker = ImagePicker();

  static Future<DocumentPickResult?> pick(AttachmentSource source) {
    return switch (source) {
      AttachmentSource.camera => _pickImage(ImageSource.camera),
      AttachmentSource.gallery => _pickImage(ImageSource.gallery),
      AttachmentSource.files => _pickFile(),
    };
  }

  static Future<DocumentPickResult?> _pickImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(source: source);
    if (image == null) return null;

    final size = await File(image.path).length();

    return _validate(image.path, size);
  }

  static Future<DocumentPickResult?> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      withData: false,
    );

    final file = result?.files.single;
    if (file?.path == null) return null;

    return _validate(file!.path!, file.size);
  }

  static DocumentPickResult _validate(String path, int sizeInBytes) {
    if (sizeInBytes > maxSizeInMB * 1024 * 1024) {
      return const DocumentPickResult.tooLarge();
    }

    if (!_hasAllowedExtension(path)) {
      return const DocumentPickResult.unsupportedType();
    }

    return DocumentPickResult.picked(path);
  }

  static bool _hasAllowedExtension(String path) {
    final extension = path.split('.').last.toLowerCase();
    return allowedExtensions.contains(extension);
  }
}
