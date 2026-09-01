import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../discounts/presentation/manager/merchant_discounts_cubit.dart';
import '../../../discounts/presentation/manager/merchant_discounts_state.dart';
import '../../../discounts/presentation/widgets/discount_card.dart';
import '../../../../../generated/l10n.dart';

class DashboardLiveOffers extends StatelessWidget {
  const DashboardLiveOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantDiscountsCubit, MerchantDiscountsState>(
      builder: (context, state) {
        final live = state.liveDiscounts;

        if (live.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: S().liveDiscounts,
              actionLabel: S().discountsTitle,
              onAction: () => context.push(Routes.merchantDiscountsScreen),
            ),
            for (final discount in live.take(2))
              DiscountCard(
                discount: discount,
                onTap: () => context.push(Routes.merchantDiscountsScreen),
              ),
          ],
        );
      },
    );
  }
}
