import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/sponsorship/sponsorship_state.dart';
import '../../../../../shared/sponsorship/sponsorship_view.dart';
import '../manager/merchant_sponsorship_cubit.dart';

class MerchantSponsorshipScreen extends StatelessWidget {
  const MerchantSponsorshipScreen({super.key});

  Future<void> _buy(BuildContext context, int price) async {
    final cubit = context.read<MerchantSponsorshipCubit>();

    final confirmed = await showConfirmDialog(
      context,
      title: S().sponsorshipConfirmTitle,
      message: S().sponsorshipConfirmMessage(S().currencyEgp(price)),
      confirmLabel: S().sponsorshipBuy,
      icon: Icons.campaign_outlined,
      isDestructive: false,
    );
    if (!confirmed) return;

    final bought = await cubit.buySponsorship();

    if (bought) {
      showSuccess(S().sponsorshipBought);
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().sponsorshipTitle),
      body: BlocBuilder<MerchantSponsorshipCubit, SponsorshipState>(
        builder: (context, state) => SponsorshipView(
          state: state,
          subtitle: S().sponsorshipMerchantSubtitle,
          onRetry: context.read<MerchantSponsorshipCubit>().loadSponsorship,
          onBuy: () => _buy(context, state.sponsorship?.monthlyPrice ?? 0),
          onTopUp: () => context.push(Routes.merchantWalletScreen),
        ),
      ),
    );
  }
}
