import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../../core/widgets/list_skeleton.dart';
import '../../../../core/widgets/refreshable_state_view.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../generated/l10n.dart';
import '../manager/wallet_cubit.dart';
import '../manager/wallet_state.dart';
import '../widgets/wallet_balance_card.dart';
import '../widgets/wallet_transaction_row.dart';
import '../wallet_routes.dart';

class WalletScreen extends StatelessWidget {
  final WalletRoutes routes;

  const WalletScreen({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: S().walletTitle,
        trailing: IconButton(
          icon: Icon(Icons.receipt_long_outlined, color: context.colorScheme.onSurface),
          onPressed: () => context.push(routes.requests),
        ),
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          final cubit = context.read<WalletCubit>();
          final wallet = state.wallet;

          if (state.status == WalletStatus.loading && wallet == null) {
            return const ListSkeleton();
          }

          if (state.status == WalletStatus.failure && wallet == null) {
            return RefreshableStateView(
              onRefresh: cubit.loadWallet,
              child: AppErrorState(message: state.errorMessage, onRetry: cubit.loadWallet),
            );
          }

          if (wallet == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: cubit.loadWallet,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              children: [
                WalletBalanceCard(balance: wallet.balance, available: wallet.available),
                SizedBox(height: 18.h),
                if (wallet.transactions.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: AppEmptyState(
                      icon: Icons.receipt_long_outlined,
                      title: S().noWalletTransactions,
                    ),
                  )
                else
                  for (final transaction in wallet.transactions)
                    WalletTransactionRow(transaction: transaction),
              ],
            ),
          );
        },
      ),
    );
  }
}
