import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/services_locator.dart';
import '../manager/pending_merchant_rating_cubit.dart';
import '../manager/pending_merchant_rating_state.dart';
import 'merchant_rating_sheet.dart';

class MerchantRatingPrompt {
  const MerchantRatingPrompt._();

  static Future<void> checkAndShow(BuildContext context) async {
    final cubit = sl<PendingMerchantRatingCubit>();
    await cubit.check();

    if (!context.mounted ||
        cubit.state.status != PendingMerchantRatingStatus.ready) {
      await cubit.close();
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const MerchantRatingSheet(),
      ),
    );

    await cubit.close();
  }
}
