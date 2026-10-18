import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/home_service_broadcast_cubit.dart';
import '../manager/home_service_broadcast_state.dart';
import '../widgets/home_service_broadcast_row.dart';

class HomeServiceBroadcastScreen extends StatefulWidget {
  const HomeServiceBroadcastScreen({super.key});

  @override
  State<HomeServiceBroadcastScreen> createState() =>
      _HomeServiceBroadcastScreenState();
}

class _HomeServiceBroadcastScreenState
    extends State<HomeServiceBroadcastScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeServiceBroadcastCubit>().loadBroadcasts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().homeServiceBroadcastInboxTitle),
      body: BlocBuilder<HomeServiceBroadcastCubit, HomeServiceBroadcastState>(
        builder: (context, state) {
          final cubit = context.read<HomeServiceBroadcastCubit>();

          if (state.status == HomeServiceBroadcastStatus.loading &&
              state.broadcasts.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == HomeServiceBroadcastStatus.failure &&
              state.broadcasts.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadBroadcasts,
              child: AppErrorState(
                message: state.errorMessage,
                onRetry: cubit.loadBroadcasts,
              ),
            );
          }

          if (state.broadcasts.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadBroadcasts,
              child: AppEmptyState(
                icon: Icons.inbox_outlined,
                title: S().noHomeServiceBroadcastsYet,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: cubit.loadBroadcasts,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              itemCount: state.broadcasts.length,
              itemBuilder: (_, index) {
                final broadcast = state.broadcasts[index];
                return HomeServiceBroadcastRow(
                  broadcast: broadcast,
                  onTap: () => context.push(
                    Routes.barberHomeServiceBroadcastDetailScreen,
                    extra: broadcast.candidateId,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
