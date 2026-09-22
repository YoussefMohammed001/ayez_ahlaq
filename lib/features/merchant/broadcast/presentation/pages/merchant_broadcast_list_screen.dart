import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../../../profile/domain/entities/merchant_profile.dart';
import '../manager/merchant_broadcast_list_cubit.dart';
import '../manager/merchant_broadcast_list_state.dart';
import '../widgets/merchant_broadcast_row.dart';

class MerchantBroadcastListScreen extends StatefulWidget {
  final MerchantProfile? profile;

  const MerchantBroadcastListScreen({super.key, this.profile});

  @override
  State<MerchantBroadcastListScreen> createState() =>
      _MerchantBroadcastListScreenState();
}

class _MerchantBroadcastListScreenState
    extends State<MerchantBroadcastListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MerchantBroadcastListCubit>().loadBroadcasts();
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
    context.read<MerchantBroadcastListCubit>().loadMore();
  }

  Future<void> _openCreate() async {
    await context.push(Routes.merchantBroadcastScreen, extra: widget.profile);
    if (mounted) context.read<MerchantBroadcastListCubit>().loadBroadcasts();
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
      body: BlocConsumer<MerchantBroadcastListCubit, MerchantBroadcastListState>(
        listenWhen: (previous, current) =>
            current.status == MerchantBroadcastListStatus.success &&
            current.errorMessage != null &&
            current.errorMessage != previous.errorMessage,
        listener: (context, state) => showError(state.errorMessage!),
        builder: (context, state) {
          if (state.status == MerchantBroadcastListStatus.loading) {
            return const ListSkeleton();
          }

          if (state.status == MerchantBroadcastListStatus.failure) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: () =>
                  context.read<MerchantBroadcastListCubit>().loadBroadcasts(),
            );
          }

          if (state.broadcasts.isEmpty) {
            return AppEmptyState(
              icon: Icons.campaign_outlined,
              title: S().broadcastListEmpty,
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                context.read<MerchantBroadcastListCubit>().loadBroadcasts(),
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              itemCount: state.broadcasts.length +
                  (state.status == MerchantBroadcastListStatus.loadingMore
                      ? 1
                      : 0),
              itemBuilder: (_, index) {
                if (index >= state.broadcasts.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                return MerchantBroadcastRow(broadcast: state.broadcasts[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
