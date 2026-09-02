import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/entities/merchant_document.dart';

class DocumentOpener {
  DocumentOpener._();

  static Future<bool> share(MerchantDocument document, Uint8List bytes) async {
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/${_fileName(document)}');
      await file.writeAsBytes(bytes, flush: true);

      final result = await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], title: document.name),
      );

      return result.status != ShareResultStatus.unavailable;
    } catch (_) {
      return false;
    }
  }

  static String _fileName(MerchantDocument document) {
    final original = document.originalFileName;
    if (original != null && original.isNotEmpty) return original;

    return 'document_${document.id}${document.isPdf ? '.pdf' : '.jpg'}';
  }
}
