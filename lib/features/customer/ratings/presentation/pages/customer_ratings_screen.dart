import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/customer_ratings_cubit.dart';
import '../manager/customer_ratings_state.dart';
import '../widgets/customer_rating_row.dart';

class CustomerRatingsScreen extends StatelessWidget {
  const CustomerRatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().reviewsTitle),
      body: BlocBuilder<CustomerRatingsCubit, CustomerRatingsState>(
        builder: (context, state) {
          final cubit = context.read<CustomerRatingsCubit>();

          if (state.status == CustomerRatingsStatus.loading && state.ratings.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == CustomerRatingsStatus.failure && state.ratings.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadRatings,
              child: AppErrorState(message: state.errorMessage, onRetry: cubit.loadRatings),
            );
          }

          if (state.ratings.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadRatings,
              child: AppEmptyState(
                icon: Icons.star_border_rounded,
                title: S().noReviewsYet,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: cubit.loadRatings,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              children: [
                for (final rating in state.ratings) CustomerRatingRow(rating: rating),
              ],
            ),
          );
        },
      ),
    );
  }
}
