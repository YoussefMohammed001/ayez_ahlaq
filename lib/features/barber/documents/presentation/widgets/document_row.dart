import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../domain/entities/barber_document.dart';
import 'document_row_actions.dart';
import 'document_type_icon.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DocumentRow extends StatelessWidget {
  final BarberDocument document;
  final bool isBusy;
  final VoidCallback onUpload;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const DocumentRow({
    super.key,
    required this.document,
    required this.isBusy,
    required this.onUpload,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 10.h),
      borderColor: document.isMissingRequired
          ? context.semantic.warning.withValues(alpha: 0.35)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DocumentTypeIcon(document: document, size: 42.r),
              SizedBox(width: 12.w),
              Expanded(child: _buildTitle(context)),
              SizedBox(width: 8.w),
              _buildStatusBadge(context),
            ],
          ),
          SizedBox(height: 10.h),
          DocumentRowActions(
            document: document,
            isBusy: isBusy,
            onUpload: onUpload,
            onView: onView,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          document.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13.sp,
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          _buildSubtitle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.sp,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  String _buildSubtitle() {
    if (!document.hasFile) return S().documentNotUploadedYet;

    if (document.isLockedByAdmin) return S().documentAddedByAdmin;

    return document.originalFileName ?? S().documentUploaded;
  }

  Widget _buildStatusBadge(BuildContext context) {
    if (document.hasFile) {
      return StatusBadge(
        label: S().documentUploaded,
        tone: BadgeTone.open,
        showDot: false,
      );
    }

    return StatusBadge(
      label: document.required ? S().documentRequired : S().documentOptional,
      tone: document.required ? BadgeTone.gold : BadgeTone.muted,
      showDot: false,
    );
  }
}
