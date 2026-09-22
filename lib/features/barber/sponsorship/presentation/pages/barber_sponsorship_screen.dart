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
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/barber_sponsorship_cubit.dart';

class BarberSponsorshipScreen extends StatelessWidget {
  const BarberSponsorshipScreen({super.key});

  Future<void> _buy(BuildContext context, int price) async {
    final cubit = context.read<BarberSponsorshipCubit>();

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

    if (bought) showSuccess(S().sponsorshipBought);
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<BarberSponsorshipCubit, SponsorshipState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().sponsorshipTitle),
        body: BlocBuilder<BarberSponsorshipCubit, SponsorshipState>(
          builder: (context, state) => SponsorshipView(
            state: state,
            subtitle: S().sponsorshipBarberSubtitle,
            onRetry: context.read<BarberSponsorshipCubit>().loadSponsorship,
            onBuy: () => _buy(context, state.sponsorship?.monthlyPrice ?? 0),
            onTopUp: () => context.push(Routes.barberWalletScreen),
          ),
        ),
      ),
    );
  }
}
