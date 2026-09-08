import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';
import '../../core/helpers/app_date_time.dart';
import '../../core/theme/styles.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_empty_state.dart';
import '../../core/widgets/app_error_state.dart';
import '../../core/widgets/badge_tone.dart';
import '../../core/widgets/info_row.dart';
import '../../core/widgets/list_skeleton.dart';
import '../../core/widgets/primary_cta_button.dart';
import '../../core/widgets/status_badge.dart';
import '../../generated/l10n.dart';
import 'sponsorship_state.dart';

class SponsorshipView extends StatelessWidget {
  final SponsorshipState state;
  final String subtitle;
  final VoidCallback onRetry;
  final VoidCallback onBuy;
  final VoidCallback onTopUp;

  const SponsorshipView({
    super.key,
    required this.state,
    required this.subtitle,
    required this.onRetry,
    required this.onBuy,
    required this.onTopUp,
  });

  @override
  Widget build(BuildContext context) {
    final sponsorship = state.sponsorship;

    if (state.status == SponsorshipStatus.loading && sponsorship == null) {
      return const ListSkeleton();
    }

    if (state.status == SponsorshipStatus.failure && sponsorship == null) {
      return AppErrorState(message: state.errorMessage, onRetry: onRetry);
    }

    if (sponsorship == null) {
      return AppEmptyState(
        icon: Icons.campaign_outlined,
        title: S().sponsorshipTitle,
        message: subtitle,
      );
    }

    final canBuy = sponsorship.canAfford && !state.isSubmitting;

    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      subtitle,
                      style: font12w400.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  StatusBadge(
                    label: sponsorship.active
                        ? S().sponsorshipActive
                        : S().sponsorshipInactive,
                    tone: sponsorship.active ? BadgeTone.open : BadgeTone.muted,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              if (sponsorship.active && sponsorship.endsAt != null)
                InfoRow(
                  icon: Icons.event_available_outlined,
                  label: S().sponsorshipEndsAt,
                  value: AppDateTime.formatDate(sponsorship.endsAt!),
                ),
              InfoRow(
                icon: Icons.sell_outlined,
                label: S().sponsorshipMonthlyPrice,
                value: S().currencyEgp(sponsorship.monthlyPrice),
              ),
              InfoRow(
                icon: Icons.account_balance_wallet_outlined,
                label: S().sponsorshipWalletAvailable,
                value: S().currencyEgp(sponsorship.walletAvailable),
                showDivider: false,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        if (sponsorship.active)
          Text(
            S().sponsorshipDaysLeft(sponsorship.daysLeft ?? 0),
            textAlign: TextAlign.center,
            style: font12w400.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          )
        else if (sponsorship.canAfford)
          PrimaryCtaButton(
            label: S().sponsorshipBuy,
            isLoading: state.isSubmitting,
            onPressed: canBuy ? onBuy : null,
          )
        else ...[
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              S().sponsorshipInsufficient(
                S().currencyEgp(sponsorship.missingAmount),
              ),
              style: font12w400.copyWith(color: context.semantic.warning),
            ),
          ),
          PrimaryCtaButton(label: S().sponsorshipTopUp, onPressed: onTopUp),
        ],
      ],
    );
  }
}
