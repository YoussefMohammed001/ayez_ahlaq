import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../manager/merchant_documents_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DocumentsSummaryCard extends StatelessWidget {
  final MerchantDocumentsState state;

  const DocumentsSummaryCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final complete = state.isComplete;
    final tone = complete
        ? context.semantic.success
        : context.semantic.warning;

    return AppCard(
      margin: EdgeInsets.only(bottom: 14.h),
      borderColor: tone.withValues(alpha: 0.35),
      child: Row(
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(
              complete
                  ? Icons.verified_outlined
                  : Icons.pending_actions_outlined,
              size: 20.r,
              color: tone,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  complete
                      ? S().documentsAllUploaded
                      : S().documentsMissingRequired(
                          state.missingRequiredCount,
                        ),
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  S().documentsProgress(
                    state.uploadedCount,
                    state.documents.length,
                  ),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
