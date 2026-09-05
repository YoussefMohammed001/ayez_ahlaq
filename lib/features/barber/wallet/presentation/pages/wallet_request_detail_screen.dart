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
import '../manager/barber_wallet_requests_cubit.dart';
import '../manager/barber_wallet_requests_state.dart';
import '../widgets/wallet_request_attachment_tile.dart';
import '../widgets/wallet_request_info_card.dart';

class WalletRequestDetailScreen extends StatelessWidget {
  final WalletRequest request;

  const WalletRequestDetailScreen({super.key, required this.request});

  Future<void> _viewAttachment(BuildContext context) async {
    final bytes = await sl<GetWalletRequestAttachmentUseCase>().call(request.id);

    if (!context.mounted) return;

    bytes.fold(
      (failure) => showError(failure.message),
      (data) => context.push(Routes.barberWalletRequestAttachmentScreen, extra: data),
    );
  }

  Future<void> _cancel(BuildContext context) async {
    final cubit = context.read<BarberWalletRequestsCubit>();

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
    return Scaffold(
      appBar: AppTopBar(title: request.code),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        children: [
          WalletRequestInfoCard(request: request),
          if (request.hasAttachment) ...[
            SizedBox(height: 14.h),
            WalletRequestAttachmentTile(
              attachmentName: request.attachmentName,
              onTap: () => _viewAttachment(context),
            ),
          ],
          if (request.status == WalletRequestStatus.pending) ...[
            SizedBox(height: 20.h),
            BlocBuilder<BarberWalletRequestsCubit, BarberWalletRequestsState>(
              builder: (context, state) => PrimaryCtaButton(
                label: S().cancelWalletRequestAction,
                isLoading: state.isCancelling(request.id),
                onPressed: () => _cancel(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
