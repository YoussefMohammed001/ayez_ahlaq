import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/widgets/authorized_network_image.dart';
import '../../domain/entities/merchant_document.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DocumentTypeIcon extends StatelessWidget {
  final MerchantDocument document;
  final double size;

  const DocumentTypeIcon({
    super.key,
    required this.document,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final corner = BorderRadius.circular(10.r);

    if (document.hasFile && document.isImage) {
      return ClipRRect(
        borderRadius: corner,
        child: AuthorizedNetworkImage(
          endPoint: EndPoints.merchantAttachmentFile(document.id),
          width: size,
          height: size,
          placeholderBuilder: (context) => _buildPlaceholder(context, corner),
        ),
      );
    }

    return _buildPlaceholder(context, corner);
  }

  Widget _buildPlaceholder(BuildContext context, BorderRadius corner) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: corner,
      ),
      child: Icon(_icon, size: size * 0.45, color: _iconColor(context)),
    );
  }

  IconData get _icon {
    if (!document.hasFile) return Icons.upload_file_outlined;
    return document.isPdf
        ? Icons.picture_as_pdf_outlined
        : Icons.insert_drive_file_outlined;
  }

  Color _iconColor(BuildContext context) {
    if (document.isMissingRequired) return context.semantic.warning;
    return context.semantic.accentSoft;
  }
}
