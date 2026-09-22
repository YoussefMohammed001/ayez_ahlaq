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
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../manager/barber_discounts_cubit.dart';
import '../manager/barber_discounts_state.dart';
import '../widgets/barber_discount_card.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/extensions/ext_theme.dart';

class BarberDiscountsScreen extends StatefulWidget {
  const BarberDiscountsScreen({super.key});

  @override
  State<BarberDiscountsScreen> createState() => _BarberDiscountsScreenState();
}

class _BarberDiscountsScreenState extends State<BarberDiscountsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BarberDiscountsCubit>().loadDiscounts();
  }

  Future<void> _confirmClose(BuildContext context, int id) async {
    final cubit = context.read<BarberDiscountsCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().closeDiscount,
      message: S().closeDiscountConfirm,
      confirmLabel: S().closeAction,
      icon: Icons.local_offer_outlined,
    );

    if (!confirmed) return;

    await cubit.closeDiscount(id);
    if (context.mounted) {
      context.read<BarberStorefrontProductsCubit>().loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<BarberDiscountsCubit, BarberDiscountsState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(
          title: S().discountsTitle,
          trailing: IconButton(
            icon: Icon(
              Icons.add,
              color: context.semantic.accentStrong,
              size: 22.r,
            ),
            onPressed: () => context.push(Routes.barberDiscountFormScreen),
          ),
        ),
        body: BlocBuilder<BarberDiscountsCubit, BarberDiscountsState>(
          builder: (context, state) {
            if (state.status == BarberDiscountsStatus.loading &&
                state.discounts.isEmpty) {
              return const ListSkeleton(showLeading: false);
            }

            if (state.status == BarberDiscountsStatus.failure &&
                state.discounts.isEmpty) {
              return RefreshableStateView(
                onRefresh: context.read<BarberDiscountsCubit>().loadDiscounts,
                child: AppErrorState(
                  message: state.errorMessage,
                  onRetry: context.read<BarberDiscountsCubit>().loadDiscounts,
                ),
              );
            }

            if (state.discounts.isEmpty) {
              return RefreshableStateView(
                onRefresh: context.read<BarberDiscountsCubit>().loadDiscounts,
                child: AppEmptyState(
                  icon: Icons.local_offer_outlined,
                  title: S().noDiscountsYet,
                  actionLabel: S().newDiscount,
                  onAction: () => context.push(Routes.barberDiscountFormScreen),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: context.read<BarberDiscountsCubit>().loadDiscounts,
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
                children: [
                  if (state.liveDiscounts.isNotEmpty) ...[
                    SectionTitle(title: S().liveDiscounts),
                    for (final discount in state.liveDiscounts)
                      BarberDiscountCard(
                        discount: discount,
                        onClose: () => _confirmClose(context, discount.id),
                        onTap: () => context.push(
                          Routes.barberDiscountFormScreen,
                          extra: discount,
                        ),
                      ),
                  ],
                  if (state.closedDiscounts.isNotEmpty) ...[
                    SectionTitle(title: S().closedDiscounts),
                    for (final discount in state.closedDiscounts)
                      BarberDiscountCard(discount: discount),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
