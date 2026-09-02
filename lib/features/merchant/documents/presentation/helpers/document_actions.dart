import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../domain/entities/merchant_document.dart';
import '../manager/merchant_documents_cubit.dart';
import '../../../../../shared/widgets/attachments/attachment_source_sheet.dart';
import 'document_file_picker.dart';
import 'document_view_args.dart';
import '../../../../../generated/l10n.dart';

class DocumentActions {
  DocumentActions._();

  static Future<void> upload(
    BuildContext context,
    MerchantDocument document,
  ) async {
    final cubit = context.read<MerchantDocumentsCubit>();
    final source = await AttachmentSourceSheet.show(context);

    if (source == null) return;

    final picked = await DocumentFilePicker.pick(source);

    if (picked == null) return;

    if (picked.exceedsMaxSize) {
      showError(S().documentTooLarge(DocumentFilePicker.maxSizeInMB));
      return;
    }

    if (picked.isUnsupportedType) {
      showError(S().documentUnsupportedType);
      return;
    }

    final uploaded = await cubit.uploadFile(document.id, picked.path!);

    if (uploaded) showSuccess(S().documentUploadedSuccess);
  }

  static Future<void> view(
    BuildContext context,
    MerchantDocument document,
  ) async {
    final cubit = context.read<MerchantDocumentsCubit>();
    final bytes = await cubit.downloadFile(document.id);

    if (bytes == null || !context.mounted) return;

    context.push(
      Routes.merchantDocumentViewerScreen,
      extra: DocumentViewArgs(document: document, bytes: bytes),
    );
  }

  static Future<void> delete(
    BuildContext context,
    MerchantDocument document,
  ) async {
    final cubit = context.read<MerchantDocumentsCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().deleteDocument,
      message: S().deleteDocumentConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
    );

    if (!confirmed) return;

    final deleted = await cubit.deleteFile(document.id);

    if (deleted) showSuccess(S().documentDeletedSuccess);
  }
}
