import 'dart:typed_data';
import '../../domain/entities/barber_document.dart';

class DocumentViewArgs {
  final BarberDocument document;
  final Uint8List bytes;

  const DocumentViewArgs({required this.document, required this.bytes});
}
