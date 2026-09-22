import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/money_entries_cubit.dart';
import '../manager/money_entries_state.dart';
import '../widgets/money_entry_form_sheet.dart';
import '../widgets/money_entry_row.dart';

class MoneyEntriesScreen extends StatefulWidget {
  const MoneyEntriesScreen({super.key});

  @override
  State<MoneyEntriesScreen> createState() => _MoneyEntriesScreenState();
}

class _MoneyEntriesScreenState extends State<MoneyEntriesScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<MoneyEntriesCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().moneyLedgerTitle),
      body: BlocBuilder<MoneyEntriesCubit, MoneyEntriesState>(
        builder: (context, state) {
          final cubit = context.read<MoneyEntriesCubit>();

          if (state.status == MoneyEntriesStatus.loading && state.entries.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == MoneyEntriesStatus.failure && state.entries.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.load,
              child: AppErrorState(message: state.errorMessage, onRetry: cubit.load),
            );
          }

          if (state.entries.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.load,
              child: AppEmptyState(icon: Icons.receipt_long_outlined, title: S().moneyNoEntries),
            );
          }

          return RefreshIndicator(
            onRefresh: cubit.load,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              itemCount: state.entries.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.entries.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return MoneyEntryRow(entry: state.entries[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => MoneyEntryFormSheet.show(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
