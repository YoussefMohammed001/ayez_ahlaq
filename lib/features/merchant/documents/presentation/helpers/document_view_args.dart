import 'dart:typed_data';
import '../../domain/entities/merchant_document.dart';

class DocumentViewArgs {
  final MerchantDocument document;
  final Uint8List bytes;

  const DocumentViewArgs({required this.document, required this.bytes});
}
