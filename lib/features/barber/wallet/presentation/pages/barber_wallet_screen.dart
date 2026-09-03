import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_wallet_cubit.dart';
import '../manager/barber_wallet_state.dart';
import '../widgets/wallet_balance_card.dart';
import '../widgets/wallet_transaction_row.dart';

class BarberWalletScreen extends StatelessWidget {
  const BarberWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().walletTitle),
      body: BlocBuilder<BarberWalletCubit, BarberWalletState>(
        builder: (context, state) {
          final cubit = context.read<BarberWalletCubit>();
          final wallet = state.wallet;

          if (state.status == BarberWalletStatus.loading && wallet == null) {
            return const ListSkeleton();
          }

          if (state.status == BarberWalletStatus.failure && wallet == null) {
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
                WalletBalanceCard(balance: wallet.balance),
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
