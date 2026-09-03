import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/barber_document.dart';
import 'document_action_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DocumentRowActions extends StatelessWidget {
  final BarberDocument document;
  final bool isBusy;
  final VoidCallback onUpload;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const DocumentRowActions({
    super.key,
    required this.document,
    required this.isBusy,
    required this.onUpload,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (isBusy) {
      return SizedBox(
        height: 32.h,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: SizedBox(
            width: 18.r,
            height: 18.r,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        DocumentActionButton(
          icon: document.hasFile
              ? Icons.sync_rounded
              : Icons.file_upload_outlined,
          label: document.hasFile ? S().replaceDocument : S().uploadDocument,
          onTap: onUpload,
          emphasized: !document.hasFile,
        ),
        if (document.hasFile) ...[
          SizedBox(width: 8.w),
          DocumentActionButton(
            icon: Icons.visibility_outlined,
            label: S().viewDocument,
            onTap: onView,
          ),
          const Spacer(),
          DocumentActionButton(
            icon: Icons.delete_outline_rounded,
            label: S().delete,
            onTap: onDelete,
            danger: true,
          ),
        ],
      ],
    );
  }
}
