import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/helpers/alerts.dart';
import '../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/wallet_request.dart';
import '../../domain/entities/wallet_request_status.dart';
import '../manager/wallet_requests_cubit.dart';
import '../manager/wallet_requests_state.dart';
import '../widgets/wallet_request_attachment_tile.dart';
import '../widgets/wallet_request_info_card.dart';
import '../wallet_routes.dart';

class WalletRequestDetailScreen extends StatefulWidget {
  final WalletRequest request;
  final WalletRoutes routes;

  const WalletRequestDetailScreen({
    super.key,
    required this.request,
    required this.routes,
  });

  @override
  State<WalletRequestDetailScreen> createState() =>
      _WalletRequestDetailScreenState();
}

class _WalletRequestDetailScreenState
    extends State<WalletRequestDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WalletRequestsCubit>().refreshRequest(widget.request.id);
  }

  Future<void> _refresh() =>
      context.read<WalletRequestsCubit>().refreshRequest(widget.request.id);

  Future<void> _viewAttachment(BuildContext context, WalletRequest request) async {
    final bytes = await context.read<WalletRequestsCubit>().attachment(request.id);

    if (!context.mounted) return;

    bytes.fold(
      (failure) => showError(failure.message),
      (data) =>
          context.push(widget.routes.requestAttachment, extra: data),
    );
  }

  Future<void> _cancel(BuildContext context, WalletRequest request) async {
    final cubit = context.read<WalletRequestsCubit>();

    final confirmed = await showConfirmDialog(
      context,
      title: S().cancelWalletRequestTitle,
      message: S().cancelWalletRequestConfirm,
      confirmLabel: S().cancel,
    );

    if (!confirmed) return;

    final cancelled = await cubit.cancelRequest(request.id);

    if (!context.mounted) return;

    if (cancelled) {
      showSuccess(S().walletRequestCancelledSuccess);
      context.pop();
    } else {
      final message = cubit.state.errorMessage;
      if (message != null) showError(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletRequestsCubit, WalletRequestsState>(
      builder: (context, state) {
        final current = state.requests.firstWhere(
          (r) => r.id == widget.request.id,
          orElse: () => widget.request,
        );

        return Scaffold(
          appBar: AppTopBar(title: current.code),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              children: [
                WalletRequestInfoCard(request: current),
                if (current.hasAttachment) ...[
                  SizedBox(height: 14.h),
                  WalletRequestAttachmentTile(
                    attachmentName: current.attachmentName,
                    onTap: () => _viewAttachment(context, current),
                  ),
                ],
                if (current.status == WalletRequestStatus.pending) ...[
                  SizedBox(height: 20.h),
                  PrimaryCtaButton(
                    label: S().cancelWalletRequestAction,
                    isLoading: state.isCancelling(current.id),
                    onPressed: () => _cancel(context, current),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
