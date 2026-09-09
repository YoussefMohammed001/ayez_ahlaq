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
import '../manager/customer_wallet_requests_cubit.dart';
import '../manager/customer_wallet_requests_state.dart';
import '../widgets/wallet_request_row.dart';

class CustomerWalletRequestsScreen extends StatefulWidget {
  const CustomerWalletRequestsScreen({super.key});

  @override
  State<CustomerWalletRequestsScreen> createState() =>
      _CustomerWalletRequestsScreenState();
}

class _CustomerWalletRequestsScreenState
    extends State<CustomerWalletRequestsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
    context.read<CustomerWalletRequestsCubit>().loadMore();
  }

  Future<void> _openCreate() async {
    await context.push(Routes.createCustomerWalletRequestScreen);
    if (mounted) context.read<CustomerWalletRequestsCubit>().loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: S().walletRequestsTitle,
        trailing: IconButton(
          icon: const Icon(Icons.add_rounded),
          onPressed: _openCreate,
        ),
      ),
      body: BlocBuilder<CustomerWalletRequestsCubit, CustomerWalletRequestsState>(
        builder: (context, state) {
          if (state.status == WalletRequestsListStatus.loading) {
            return const ListSkeleton();
          }

          if (state.status == WalletRequestsListStatus.failure) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: () =>
                  context.read<CustomerWalletRequestsCubit>().loadRequests(),
            );
          }

          if (state.requests.isEmpty) {
            return AppEmptyState(
              icon: Icons.receipt_long_outlined,
              title: S().walletRequestsEmpty,
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                context.read<CustomerWalletRequestsCubit>().loadRequests(),
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              itemCount: state.requests.length +
                  (state.status == WalletRequestsListStatus.loadingMore ? 1 : 0),
              itemBuilder: (_, index) {
                if (index >= state.requests.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final request = state.requests[index];
                return WalletRequestRow(
                  request: request,
                  onTap: () => context.push(
                    Routes.customerWalletRequestDetailScreen,
                    extra: request,
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
