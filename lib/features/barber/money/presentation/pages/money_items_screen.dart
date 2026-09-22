import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_confirm_dialog.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/money_items_cubit.dart';
import '../manager/money_items_state.dart';
import '../widgets/money_item_form_sheet.dart';
import '../widgets/money_item_row.dart';

class MoneyItemsScreen extends StatelessWidget {
  const MoneyItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MoneyItemsCubit, MoneyItemsState>(
      isBusy: (state) => state.mutatingIds.isNotEmpty,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().moneyRecurringItemsTitle),
        body: BlocBuilder<MoneyItemsCubit, MoneyItemsState>(
          builder: (context, state) {
            final cubit = context.read<MoneyItemsCubit>();

            if (state.status == MoneyItemsStatus.loading &&
                state.items.isEmpty) {
              return const ListSkeleton();
            }

            if (state.status == MoneyItemsStatus.failure &&
                state.items.isEmpty) {
              return RefreshableStateView(
                onRefresh: cubit.load,
                child: AppErrorState(
                  message: state.errorMessage,
                  onRetry: cubit.load,
                ),
              );
            }

            if (state.items.isEmpty) {
              return RefreshableStateView(
                onRefresh: cubit.load,
                child: AppEmptyState(
                  icon: Icons.repeat_rounded,
                  title: S().moneyNoItems,
                  actionLabel: S().moneyNewItem,
                  onAction: () => MoneyItemFormSheet.show(context),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: cubit.load,
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                children: [
                  for (final item in state.items)
                    MoneyItemRow(
                      item: item,
                      isMutating: state.isMutating(item.id),
                      onTap: () => MoneyItemFormSheet.show(context, item: item),
                      onToggleActive: () => cubit.update(
                        id: item.id,
                        description: item.description,
                        amount: item.amount,
                        direction: item.direction,
                        frequency: item.frequency,
                        dayOfWeek: item.dayOfWeek,
                        dayOfMonth: item.dayOfMonth,
                        active: !item.active,
                      ),
                      onDelete: () => _confirmDelete(context, cubit, item.id),
                    ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => MoneyItemFormSheet.show(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    MoneyItemsCubit cubit,
    int id,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AppConfirmDialog(
        title: S().moneyDeleteItemTitle,
        message: S().moneyDeleteItemMessage,
      ),
    );
    if (confirmed == true) cubit.delete(id);
  }
}
