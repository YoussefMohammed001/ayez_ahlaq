import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/home_service_broadcast.dart';
import '../manager/home_service_broadcast_cubit.dart';
import '../manager/home_service_broadcast_state.dart';
import '../widgets/home_service_broadcast_actions.dart';
import '../widgets/home_service_broadcast_info_card.dart';

class HomeServiceBroadcastDetailScreen extends StatefulWidget {
  final int? candidateId;
  final int? requestId;

  const HomeServiceBroadcastDetailScreen({
    super.key,
    this.candidateId,
    this.requestId,
  });

  @override
  State<HomeServiceBroadcastDetailScreen> createState() =>
      _HomeServiceBroadcastDetailScreenState();
}

class _HomeServiceBroadcastDetailScreenState
    extends State<HomeServiceBroadcastDetailScreen> {
  @override
  void initState() {
    super.initState();
    _resolveIfNeeded();
  }

  void _resolveIfNeeded() {
    final requestId = widget.requestId;
    if (requestId != null) {
      context.read<HomeServiceBroadcastCubit>().resolveForRequest(requestId);
    }
  }

  HomeServiceBroadcast? _findBroadcast(HomeServiceBroadcastState state) {
    if (widget.candidateId != null) {
      return state.broadcasts
          .where((b) => b.candidateId == widget.candidateId)
          .firstOrNull;
    }
    return state.broadcasts
        .where((b) => b.requestId == widget.requestId)
        .firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<HomeServiceBroadcastCubit, HomeServiceBroadcastState>(
      isBusy: (state) => state.updatingBroadcastId != null,
      errorMessage: (state) => state.errorMessage,
      child: BlocBuilder<HomeServiceBroadcastCubit, HomeServiceBroadcastState>(
        builder: (context, state) {
          final broadcast = _findBroadcast(state);

          if (broadcast == null &&
              state.status == HomeServiceBroadcastStatus.loading) {
            return Scaffold(
              appBar: AppTopBar(title: S().homeServiceBroadcastDetailTitle),
              body: const ListSkeleton(),
            );
          }

          if (broadcast == null) {
            return Scaffold(
              appBar: AppTopBar(title: S().homeServiceBroadcastDetailTitle),
              body: AppErrorState(
                message: state.errorMessage,
                onRetry: widget.requestId == null ? null : _resolveIfNeeded,
              ),
            );
          }

          return Scaffold(
            appBar: AppTopBar(title: broadcast.requestCode),
            body: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              children: [
                SectionTitle(title: S().homeServiceBroadcastDetailTitle),
                HomeServiceBroadcastInfoCard(broadcast: broadcast),
                if (broadcast.isPending) ...[
                  SizedBox(height: 20.h),
                  HomeServiceBroadcastActions(candidateId: broadcast.candidateId),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
