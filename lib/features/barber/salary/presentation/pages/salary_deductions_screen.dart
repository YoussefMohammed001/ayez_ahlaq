import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/salary_deduction.dart';
import '../manager/salary_deductions_cubit.dart';
import '../manager/salary_deductions_state.dart';
import '../widgets/decide_deduction_sheet.dart';
import '../widgets/deduction_row.dart';
import '../widgets/deductions_filter_header.dart';
import '../widgets/grace_setting_sheet.dart';

class SalaryDeductionsScreen extends StatefulWidget {
  const SalaryDeductionsScreen({super.key});

  @override
  State<SalaryDeductionsScreen> createState() => _SalaryDeductionsScreenState();
}

class _SalaryDeductionsScreenState extends State<SalaryDeductionsScreen> {
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
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<SalaryDeductionsCubit>().loadMore();
    }
  }

  void _decide(SalaryDeduction deduction, {required bool waive}) {
    final cubit = context.read<SalaryDeductionsCubit>();

    DecideDeductionSheet.show(
      context,
      waive: waive,
      onSubmit: (note) async {
        final done = await cubit.decide(deduction.id, waive: waive, note: note);
        if (done) {
          showSuccess(waive ? S().deductionWaived : S().deductionConfirmed);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<SalaryDeductionsCubit, SalaryDeductionsState>(
      isBusy: (state) => state.isDeciding,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(
          title: S().deductionsTitle,
          trailing: IconButton(
            tooltip: S().graceTitle,
            icon: const Icon(Icons.tune_rounded),
            onPressed: () => GraceSettingSheet.show(context),
          ),
        ),
        body: BlocBuilder<SalaryDeductionsCubit, SalaryDeductionsState>(
          builder: (context, state) => Column(
            children: [
              DeductionsFilterHeader(
                selected: state.filter,
                onSelected: context.read<SalaryDeductionsCubit>().setFilter,
              ),
              Expanded(child: _buildList(context, state)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, SalaryDeductionsState state) {
    final cubit = context.read<SalaryDeductionsCubit>();

    if (state.status == SalaryDeductionsStatus.loading ||
        state.status == SalaryDeductionsStatus.initial) {
      return const ListSkeleton();
    }

    if (state.status == SalaryDeductionsStatus.failure && state.items.isEmpty) {
      return RefreshableStateView(
        onRefresh: cubit.load,
        child: AppErrorState(message: state.errorMessage, onRetry: cubit.load),
      );
    }

    if (state.items.isEmpty) {
      return RefreshableStateView(
        onRefresh: cubit.load,
        child: AppEmptyState(
          icon: Icons.fact_check_outlined,
          title: S().deductionsEmpty,
          message: S().deductionsEmptyHint,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: cubit.load,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (_, index) {
          if (index == state.items.length) {
            return const Center(child: CircularProgressIndicator());
          }

          final deduction = state.items[index];
          return DeductionRow(
            deduction: deduction,
            onWaive: () => _decide(deduction, waive: true),
            onConfirm: () => _decide(deduction, waive: false),
          );
        },
      ),
    );
  }
}
