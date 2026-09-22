import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/home_service_request.dart';
import '../manager/home_service_requests_cubit.dart';
import '../manager/home_service_requests_state.dart';
import '../widgets/edit_home_service_price_sheet.dart';
import '../widgets/home_service_request_actions.dart';
import '../widgets/home_service_request_info_card.dart';
import '../widgets/home_service_status_label.dart';
import '../widgets/home_service_status_tone.dart';

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
    context.read<HomeServiceRequestsCubit>().refreshRequest(widget.requestId);
  }

  Future<void> _refresh() =>
      context.read<HomeServiceRequestsCubit>().refreshRequest(widget.requestId);

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<HomeServiceRequestsCubit, HomeServiceRequestsState>(
      isBusy: (state) => state.updatingRequestId != null,
      errorMessage: (state) => state.errorMessage,
      child: BlocBuilder<HomeServiceRequestsCubit, HomeServiceRequestsState>(
        builder: (context, state) {
          final request = state.requests
              .where((r) => r.id == widget.requestId)
              .firstOrNull;

          if (request == null && state.status == HomeServiceRequestsStatus.loading) {
            return Scaffold(
              appBar: AppTopBar(title: S().homeServiceRequestDetailTitle),
              body: const ListSkeleton(),
            );
          }

          if (request == null) {
            return Scaffold(
              appBar: AppTopBar(title: S().homeServiceRequestDetailTitle),
              body: AppErrorState(message: state.errorMessage, onRetry: _refresh),
            );
          }

          return Scaffold(
            appBar: AppTopBar(title: request.code),
            body: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
                children: [
                  _buildHeader(context, request),
                  SectionTitle(title: S().homeServiceRequestDetailTitle),
                  HomeServiceRequestInfoCard(request: request),
                  if (request.status.needsDecision && !request.priceConfirmationPending) ...[
                    SizedBox(height: 12.h),
                    OutlinedButton.icon(
                      onPressed: () =>
                          EditHomeServicePriceSheet.show(context, request),
                      icon: Icon(Icons.receipt_long_outlined, size: 18.r),
                      label: Text(S().editHomeServicePriceAction),
                    ),
                  ],
                  SizedBox(height: 20.h),
                  HomeServiceRequestActions(request: request),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HomeServiceRequest request) {
    return Row(
      children: [
        AvatarCircle(
          initials: request.customerName.isEmpty
              ? S().avatarFallback
              : request.customerName.substring(0, 1),
          size: 52.r,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.customerName,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                request.customerPhone,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        StatusBadge(label: request.status.label, tone: request.status.tone),
      ],
    );
  }
}
