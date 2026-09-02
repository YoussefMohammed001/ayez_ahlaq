import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../helpers/document_actions.dart';
import '../manager/merchant_documents_cubit.dart';
import '../manager/merchant_documents_state.dart';
import '../widgets/document_row.dart';
import '../widgets/documents_summary_card.dart';
import '../../../../../shared/widgets/documents/documents_blocked_notice.dart';
import '../../../../../generated/l10n.dart';
import '../helpers/document_file_picker.dart';
import '../../../../../core/extensions/ext_theme.dart';

class MerchantDocumentsScreen extends StatefulWidget {
  final bool blocking;

  const MerchantDocumentsScreen({super.key, this.blocking = false});

  @override
  State<MerchantDocumentsScreen> createState() =>
      _MerchantDocumentsScreenState();
}

class _MerchantDocumentsScreenState extends State<MerchantDocumentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MerchantDocumentsCubit>().loadDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.blocking ? null : AppTopBar(title: S().myDocuments),
      body: BlocBuilder<MerchantDocumentsCubit, MerchantDocumentsState>(
        builder: (context, state) {
          if (state.status == DocumentsStatus.loading &&
              state.documents.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == DocumentsStatus.failure &&
              state.documents.isEmpty) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: context.read<MerchantDocumentsCubit>().loadDocuments,
            );
          }

          if (state.documents.isEmpty) {
            return AppEmptyState(
              icon: Icons.folder_outlined,
              title: S().noDocuments,
              message: S().noDocumentsMessage,
            );
          }

          return RefreshIndicator(
            onRefresh: context.read<MerchantDocumentsCubit>().loadDocuments,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              children: [
                if (widget.blocking) const DocumentsBlockedNotice(),
                DocumentsSummaryCard(state: state),
                Text(
                  S().documentsNote(DocumentFilePicker.maxSizeInMB),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.8,
                  ),
                ),
                SizedBox(height: 14.h),
                for (final document in state.documents)
                  DocumentRow(
                    document: document,
                    isBusy: state.isBusy(document.id),
                    onUpload: () => DocumentActions.upload(context, document),
                    onView: () => DocumentActions.view(context, document),
                    onDelete: () => DocumentActions.delete(context, document),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
