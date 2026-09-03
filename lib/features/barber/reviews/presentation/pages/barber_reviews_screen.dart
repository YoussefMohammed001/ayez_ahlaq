import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_reviews_cubit.dart';
import '../manager/barber_reviews_state.dart';
import '../widgets/review_row.dart';
import '../widgets/reviews_summary_card.dart';

class BarberReviewsScreen extends StatelessWidget {
  const BarberReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().reviewsTitle),
      body: BlocBuilder<BarberReviewsCubit, BarberReviewsState>(
        builder: (context, state) {
          final cubit = context.read<BarberReviewsCubit>();
          final summary = state.summary;

          if (state.status == BarberReviewsStatus.loading && summary == null) {
            return const ListSkeleton();
          }

          if (state.status == BarberReviewsStatus.failure && summary == null) {
            return RefreshableStateView(
              onRefresh: cubit.loadReviews,
              child: AppErrorState(message: state.errorMessage, onRetry: cubit.loadReviews),
            );
          }

          if (summary == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: cubit.loadReviews,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              children: [
                ReviewsSummaryCard(average: summary.average, count: summary.count),
                SizedBox(height: 18.h),
                if (summary.reviews.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: AppEmptyState(
                      icon: Icons.star_border_rounded,
                      title: S().noReviewsYet,
                    ),
                  )
                else
                  for (final review in summary.reviews) ReviewRow(review: review),
              ],
            ),
          );
        },
      ),
    );
  }
}
