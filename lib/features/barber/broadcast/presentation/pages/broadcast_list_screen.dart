import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../manager/broadcast_list_cubit.dart';
import '../manager/broadcast_list_state.dart';
import '../widgets/broadcast_row.dart';

class BroadcastListScreen extends StatefulWidget {
  const BroadcastListScreen({super.key});

  @override
  State<BroadcastListScreen> createState() => _BroadcastListScreenState();
}

class _BroadcastListScreenState extends State<BroadcastListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<BroadcastListCubit>().loadBroadcasts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent - 200) {
      return;
    }
    context.read<BroadcastListCubit>().loadMore();
  }

  Future<void> _openCreate() async {
    await context.push(Routes.barberBroadcastScreen);
    if (mounted) context.read<BroadcastListCubit>().loadBroadcasts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: S().broadcastListTitle,
        trailing: IconButton(
          icon: const Icon(Icons.add_rounded),
          onPressed: _openCreate,
        ),
      ),
      body: BlocBuilder<BroadcastListCubit, BroadcastListState>(
        builder: (context, state) {
          if (state.status == BroadcastListStatus.loading) {
            return const ListSkeleton();
          }

          if (state.status == BroadcastListStatus.failure) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: () => context.read<BroadcastListCubit>().loadBroadcasts(),
            );
          }

          if (state.broadcasts.isEmpty) {
            return AppEmptyState(
              icon: Icons.campaign_outlined,
              title: S().broadcastListEmpty,
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<BroadcastListCubit>().loadBroadcasts(),
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              itemCount: state.broadcasts.length +
                  (state.status == BroadcastListStatus.loadingMore ? 1 : 0),
              itemBuilder: (_, index) {
                if (index >= state.broadcasts.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                return BroadcastRow(broadcast: state.broadcasts[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
