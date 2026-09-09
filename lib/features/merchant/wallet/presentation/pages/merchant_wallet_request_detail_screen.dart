import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/di/services_locator.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/wallet_request.dart';
import '../../domain/entities/wallet_request_status.dart';
import '../../domain/use_cases/get_wallet_request_attachment_use_case.dart';
import '../manager/merchant_wallet_requests_cubit.dart';
import '../manager/merchant_wallet_requests_state.dart';
import '../widgets/wallet_request_attachment_tile.dart';
import '../widgets/wallet_request_info_card.dart';

class MerchantWalletRequestDetailScreen extends StatefulWidget {
  final WalletRequest request;

  const MerchantWalletRequestDetailScreen({super.key, required this.request});

  @override
  State<MerchantWalletRequestDetailScreen> createState() =>
      _MerchantWalletRequestDetailScreenState();
}

class _MerchantWalletRequestDetailScreenState
    extends State<MerchantWalletRequestDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MerchantWalletRequestsCubit>().refreshRequest(widget.request.id);
  }

  Future<void> _refresh() =>
      context.read<MerchantWalletRequestsCubit>().refreshRequest(widget.request.id);

  Future<void> _viewAttachment(BuildContext context, WalletRequest request) async {
    final bytes = await sl<GetWalletRequestAttachmentUseCase>().call(request.id);

    if (!context.mounted) return;

    bytes.fold(
      (failure) => showError(failure.message),
      (data) =>
          context.push(Routes.merchantWalletRequestAttachmentScreen, extra: data),
    );
  }

  Future<void> _cancel(BuildContext context, WalletRequest request) async {
    final cubit = context.read<MerchantWalletRequestsCubit>();

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantWalletRequestsCubit, MerchantWalletRequestsState>(
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
