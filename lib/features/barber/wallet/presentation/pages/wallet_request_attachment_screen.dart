import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../documents/presentation/widgets/document_image_view.dart';

class WalletRequestAttachmentScreen extends StatelessWidget {
  final Uint8List bytes;

  const WalletRequestAttachmentScreen({super.key, required this.bytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppTopBar(title: S().walletRequestAttachmentLabel),
      body: DocumentImageView(bytes: bytes),
    );
  }
}
