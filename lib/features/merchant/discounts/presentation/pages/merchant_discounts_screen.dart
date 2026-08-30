import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../manager/merchant_discounts_cubit.dart';
import '../manager/merchant_discounts_state.dart';
import '../widgets/discount_card.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/extensions/ext_theme.dart';

class MerchantDiscountsScreen extends StatelessWidget {
  const MerchantDiscountsScreen({super.key});

  Future<void> _confirmClose(BuildContext context, int id) async {
    final cubit = context.read<MerchantDiscountsCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().closeDiscount,
      message: S().closeDiscountConfirm,
      confirmLabel: S().closeAction,
      icon: Icons.local_offer_outlined,
    );

    if (confirmed) await cubit.closeDiscount(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: S().discountsTitle,
        trailing: IconButton(
          icon: Icon(Icons.add, color: context.semantic.accentStrong, size: 22.r),
          onPressed: () => context.push(Routes.merchantDiscountFormScreen),
        ),
      ),
      body: BlocBuilder<MerchantDiscountsCubit, MerchantDiscountsState>(
        builder: (context, state) {
          if (state.status == DiscountsStatus.loading &&
              state.discounts.isEmpty) {
            return const ListSkeleton(showLeading: false);
          }

          if (state.status == DiscountsStatus.failure &&
              state.discounts.isEmpty) {
            return RefreshableStateView(
              onRefresh: context.read<MerchantDiscountsCubit>().loadDiscounts,
              child: AppErrorState(
                message: state.errorMessage,
                onRetry: context.read<MerchantDiscountsCubit>().loadDiscounts,
              ),
            );
          }

          if (state.discounts.isEmpty) {
            return RefreshableStateView(
              onRefresh: context.read<MerchantDiscountsCubit>().loadDiscounts,
              child: AppEmptyState(
                icon: Icons.local_offer_outlined,
                title: S().noDiscountsYet,
                actionLabel: S().newDiscount,
                onAction: () => context.push(Routes.merchantDiscountFormScreen),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: context.read<MerchantDiscountsCubit>().loadDiscounts,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
              children: [
                if (state.liveDiscounts.isNotEmpty) ...[
                  SectionTitle(title: S().liveDiscounts),
                  for (final discount in state.liveDiscounts)
                    DiscountCard(
                      discount: discount,
                      onClose: () => _confirmClose(context, discount.id),
                      onTap: () => context.push(
                        Routes.merchantDiscountFormScreen,
                        extra: discount,
                      ),
                    ),
                ],
                if (state.closedDiscounts.isNotEmpty) ...[
                  SectionTitle(title: S().closedDiscounts),
                  for (final discount in state.closedDiscounts)
                    DiscountCard(discount: discount),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
