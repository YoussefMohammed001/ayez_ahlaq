import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../manager/earnings_cubit.dart';
import '../manager/earnings_state.dart';
import '../widgets/daily_earning_row.dart';
import '../widgets/earnings_breakdown_card.dart';
import '../widgets/earnings_summary_grid.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().earningsTitle),
      body: BlocBuilder<EarningsCubit, EarningsState>(
        builder: (context, state) {
          final cubit = context.read<EarningsCubit>();

          if (state.status == EarningsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == EarningsStatus.failure) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: cubit.loadEarnings,
            );
          }

          final earnings = state.earnings;

          return RefreshableStateView(
            onRefresh: cubit.loadEarnings,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                EarningsSummaryGrid(earnings: earnings),
                SizedBox(height: 14.h),
                EarningsBreakdownCard(earnings: earnings),
                SectionTitle(title: S().dailyBreakdownTitle),
                for (final day in earnings.dailyLast7)
                  DailyEarningRow(day: day),
              ],
            ),
          );
        },
      ),
    );
  }
}
