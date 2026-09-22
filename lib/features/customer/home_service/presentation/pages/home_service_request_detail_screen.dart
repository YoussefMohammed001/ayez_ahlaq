import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/home_service_request_detail_cubit.dart';
import '../manager/home_service_request_detail_state.dart';
import '../widgets/home_service_price_confirmation_banner.dart';
import '../widgets/home_service_request_detail_card.dart';

class HomeServiceRequestDetailScreen extends StatefulWidget {
  final int requestId;

  const HomeServiceRequestDetailScreen({super.key, required this.requestId});

  @override
  State<HomeServiceRequestDetailScreen> createState() =>
      _HomeServiceRequestDetailScreenState();
}

class _HomeServiceRequestDetailScreenState
    extends State<HomeServiceRequestDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeServiceRequestDetailCubit>().loadRequest(widget.requestId);
  }

  Future<void> _confirmPrice() async {
    final cubit = context.read<HomeServiceRequestDetailCubit>();
    final success = await cubit.confirmPrice(widget.requestId);
    if (!mounted) return;
    if (success) {
      showSuccess(S().homeServicePriceConfirmed);
    } else if (cubit.state.errorMessage != null) {
      showError(cubit.state.errorMessage!);
    }
  }

  Future<void> _cancel() async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().homeServiceCancelTitle,
      message: S().homeServiceCancelMessage,
      confirmLabel: S().homeServiceCancelConfirm,
    );
    if (!confirmed || !mounted) return;

    final cubit = context.read<HomeServiceRequestDetailCubit>();
    final success = await cubit.cancel(widget.requestId);
    if (!mounted) return;
    if (success) {
      showSuccess(S().homeServiceRequestCancelled);
    } else if (cubit.state.errorMessage != null) {
      showError(cubit.state.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().homeServiceRequestDetailTitle),
      body: BlocBuilder<HomeServiceRequestDetailCubit, HomeServiceRequestDetailState>(
        builder: (context, state) {
          final cubit = context.read<HomeServiceRequestDetailCubit>();
          Future<void> reload() => cubit.loadRequest(widget.requestId);

          if (state.status == HomeServiceRequestDetailStatus.loading &&
              state.request == null) {
            return const ListSkeleton();
          }

          final request = state.request;
          if (state.status == HomeServiceRequestDetailStatus.failure &&
              request == null) {
            return RefreshableStateView(
              onRefresh: reload,
              child: AppErrorState(message: state.errorMessage, onRetry: reload),
            );
          }

          if (request == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: reload,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              children: [
                if (request.priceConfirmationPending) ...[
                  HomeServicePriceConfirmationBanner(
                    basePrice: request.price,
                    finalPrice: request.finalPrice ?? request.price,
                    isConfirming: state.isConfirmingPrice,
                    onConfirm: _confirmPrice,
                  ),
                  SizedBox(height: 14.h),
                ],
                HomeServiceRequestDetailCard(request: request),
                if (request.status.isCancellable) ...[
                  SizedBox(height: 20.h),
                  PrimaryCtaButton(
                    label: S().homeServiceCancelRequest,
                    isLoading: state.isCancelling,
                    onPressed: _cancel,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
