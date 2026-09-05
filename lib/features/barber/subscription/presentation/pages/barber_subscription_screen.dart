import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/subscription_plan.dart';
import '../manager/barber_subscription_cubit.dart';
import '../manager/barber_subscription_state.dart';
import '../widgets/current_subscription_card.dart';
import '../widgets/subscription_plan_card.dart';

class BarberSubscriptionScreen extends StatelessWidget {
  const BarberSubscriptionScreen({super.key});

  Future<void> _subscribe(BuildContext context, SubscriptionPlan plan) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().confirmSubscribeTitle,
      message: S().confirmSubscribeMessage(plan.name, plan.price),
      confirmLabel: S().subscribeAction,
      icon: Icons.workspace_premium_outlined,
      isDestructive: false,
    );

    if (!confirmed || !context.mounted) return;

    final cubit = context.read<BarberSubscriptionCubit>();
    final succeeded = await cubit.subscribe(plan.id);

    if (!context.mounted) return;

    if (!succeeded) {
      showError(cubit.state.errorMessage ?? S().somethingWentWrong);
      return;
    }

    final activated = cubit.state.subscription?.status != 'PENDING';
    showSuccess(activated ? S().subscriptionActivated : S().subscriptionRequestSentPending);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().subscriptionTitle),
      body: BlocBuilder<BarberSubscriptionCubit, BarberSubscriptionState>(
        builder: (context, state) {
          final cubit = context.read<BarberSubscriptionCubit>();
          final subscription = state.subscription;

          if (state.status == BarberSubscriptionStatus.loading && subscription == null) {
            return const ListSkeleton();
          }

          if (state.status == BarberSubscriptionStatus.failure && subscription == null) {
            return RefreshableStateView(
              onRefresh: cubit.load,
              child: AppErrorState(message: state.errorMessage, onRetry: cubit.load),
            );
          }

          if (subscription == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: cubit.load,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              children: [
                CurrentSubscriptionCard(subscription: subscription),
                SectionTitle(
                  title: S().availablePlansTitle,
                  actionLabel: S().subscriptionRequestsTitle,
                  onAction: () => context.push(Routes.barberSubscriptionRequestsScreen),
                ),
                for (final plan in state.plans)
                  SubscriptionPlanCard(
                    plan: plan,
                    isCurrentPlan: subscription.hasSubscription && subscription.planId == plan.id,
                    isSubscribing: state.subscribingPlanId == plan.id,
                    onSubscribe: () => _subscribe(context, plan),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
