import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/app_state_view.dart';
import '../../domain/entities/merchant_document.dart';
import '../helpers/document_opener.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DocumentUnsupportedView extends StatelessWidget {
  final MerchantDocument document;
  final Uint8List bytes;

  const DocumentUnsupportedView({
    super.key,
    required this.document,
    required this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    return AppStateView(
      icon: Icons.insert_drive_file_outlined,
      iconColor: context.semantic.accentSoft,
      title: document.originalFileName ?? document.name,
      message: S().documentLoadFailed,
      actionLabel: S().shareDocument,
      onAction: () => DocumentOpener.share(document, bytes),
    );
  }
}
