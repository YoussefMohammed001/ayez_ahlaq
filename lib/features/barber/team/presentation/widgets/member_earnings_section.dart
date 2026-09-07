import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../manager/member_earnings_cubit.dart';
import '../manager/member_earnings_state.dart';
import 'daily_earning_row.dart';
import 'earnings_breakdown_card.dart';
import 'earnings_summary_grid.dart';

class MemberEarningsSection extends StatelessWidget {
  const MemberEarningsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberEarningsCubit, MemberEarningsState>(
      builder: (context, state) {
        final cubit = context.read<MemberEarningsCubit>();

        if (state.status == MemberEarningsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == MemberEarningsStatus.failure) {
          return AppErrorState(
            compact: true,
            message: state.errorMessage,
            onRetry: () => cubit.loadEarnings(state.memberId!),
          );
        }

        final earnings = state.earnings;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: S().memberEarningsTitle),
            EarningsSummaryGrid(earnings: earnings),
            SizedBox(height: 14.h),
            EarningsBreakdownCard(earnings: earnings),
            if (earnings.dailyLast7.isNotEmpty) ...[
              SizedBox(height: 8.h),
              SectionTitle(title: S().dailyBreakdownTitle),
              for (final day in earnings.dailyLast7) DailyEarningRow(day: day),
            ],
          ],
        );
      },
    );
  }
}
