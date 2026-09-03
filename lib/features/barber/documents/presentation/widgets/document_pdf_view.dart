import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import '../../domain/entities/barber_document.dart';
import 'document_unsupported_view.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DocumentPdfView extends StatefulWidget {
  final Uint8List bytes;
  final BarberDocument document;

  const DocumentPdfView({
    super.key,
    required this.bytes,
    required this.document,
  });

  @override
  State<DocumentPdfView> createState() => _DocumentPdfViewState();
}

class _DocumentPdfViewState extends State<DocumentPdfView> {
  late final PdfControllerPinch _controller = PdfControllerPinch(
    document: PdfDocument.openData(widget.bytes),
  );

  bool _failed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return DocumentUnsupportedView(
        document: widget.document,
        bytes: widget.bytes,
      );
    }

    return PdfViewPinch(
      controller: _controller,
      onDocumentError: (_) {
        if (mounted) setState(() => _failed = true);
      },
      backgroundDecoration: BoxDecoration(
        color: context.colorScheme.surface,
      ),
    );
  }
}
