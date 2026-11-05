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
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/money_home_cubit.dart';
import '../manager/money_home_state.dart';
import '../widgets/money_occurrence_row.dart';
import '../widgets/money_summary_card.dart';

class MoneyHomeScreen extends StatelessWidget {
  const MoneyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MoneyHomeCubit, MoneyHomeState>(
      isBusy: (state) => state.processingOccurrenceIds.isNotEmpty,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(
          title: S().moneyManagerTitle,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.lock_reset_outlined),
                onPressed: () =>
                    context.push(Routes.barberChangeMoneyPinScreen),
              ),
              IconButton(
                icon: const Icon(Icons.list_alt_outlined),
                onPressed: () => context.push(Routes.barberMoneyItemsScreen),
              ),
            ],
          ),
        ),
        body: BlocBuilder<MoneyHomeCubit, MoneyHomeState>(
          builder: (context, state) {
            final cubit = context.read<MoneyHomeCubit>();
            final summary = state.summary;

            if (state.status == MoneyHomeStatus.loading && summary == null) {
              return const ListSkeleton();
            }

            if (state.status == MoneyHomeStatus.failure && summary == null) {
              return RefreshableStateView(
                onRefresh: cubit.load,
                child: AppErrorState(
                  message: state.errorMessage,
                  onRetry: cubit.load,
                ),
              );
            }

            if (summary == null) return const SizedBox.shrink();

            return RefreshIndicator(
              onRefresh: cubit.load,
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                children: [
                  MoneySummaryCard(summary: summary),
                  SizedBox(height: 20.h),
                  if (state.pendingOccurrences.isNotEmpty) ...[
                    SectionTitle(title: S().moneyPendingOccurrences),
                    SizedBox(height: 8.h),
                    for (final occurrence in state.pendingOccurrences)
                      MoneyOccurrenceRow(
                        occurrence: occurrence,
                        isProcessing: state.isProcessing(occurrence.id),
                        onConfirm: () => cubit.confirmOccurrence(occurrence.id),
                        onDismiss: () => cubit.dismissOccurrence(occurrence.id),
                      ),
                    SizedBox(height: 12.h),
                  ],
                  if (state.pendingOccurrences.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: AppEmptyState(
                        icon: Icons.task_alt_outlined,
                        title: S().moneyNoPendingOccurrences,
                        message: S().moneyNoPendingOccurrencesHint,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        context.push(Routes.barberMoneyEntriesScreen),
                    child: Text(S().moneyLedgerTitle),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
