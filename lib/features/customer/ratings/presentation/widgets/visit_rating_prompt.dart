import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/services_locator.dart';
import '../manager/pending_visit_rating_cubit.dart';
import '../manager/pending_visit_rating_state.dart';
import 'visit_rating_sheet.dart';

class VisitRatingPrompt {
  const VisitRatingPrompt._();

  static Future<bool> checkAndShow(BuildContext context) async {
    final cubit = sl<PendingVisitRatingCubit>();
    await cubit.check();

    if (!context.mounted ||
        cubit.state.status != PendingVisitRatingStatus.ready) {
      await cubit.close();
      return false;
    }

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const VisitRatingSheet(),
      ),
    );

    final submitted = cubit.state.status == PendingVisitRatingStatus.submitted;
    await cubit.close();
    return submitted;
  }
}
