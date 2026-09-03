import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../domain/entities/barber_document.dart';
import '../helpers/document_opener.dart';
import '../widgets/document_image_view.dart';
import '../widgets/document_pdf_view.dart';
import '../widgets/document_unsupported_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DocumentViewerScreen extends StatelessWidget {
  final BarberDocument document;
  final Uint8List bytes;

  const DocumentViewerScreen({
    super.key,
    required this.document,
    required this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppTopBar(
        title: document.name,
        trailing: IconButton(
          tooltip: S().shareDocument,
          icon: Icon(
            Icons.ios_share_rounded,
            size: 20.r,
            color: context.colorScheme.onSurface,
          ),
          onPressed: () => DocumentOpener.share(document, bytes),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (document.isImage) return DocumentImageView(bytes: bytes);

    if (document.isPdf) {
      return DocumentPdfView(bytes: bytes, document: document);
    }

    return DocumentUnsupportedView(document: document, bytes: bytes);
  }
}
