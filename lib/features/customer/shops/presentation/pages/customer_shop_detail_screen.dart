import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/di/services_locator.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../booking/presentation/manager/booking_flow_cubit.dart';
import '../../domain/entities/shop_detail.dart';
import '../manager/customer_shop_detail_cubit.dart';
import '../manager/customer_shop_detail_state.dart';
import '../widgets/shop_barber_row.dart';

class CustomerShopDetailScreen extends StatefulWidget {
  final int shopId;

  const CustomerShopDetailScreen({super.key, required this.shopId});

  @override
  State<CustomerShopDetailScreen> createState() => _CustomerShopDetailScreenState();
}

class _CustomerShopDetailScreenState extends State<CustomerShopDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerShopDetailCubit>().loadShopDetail(widget.shopId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerShopDetailCubit, CustomerShopDetailState>(
      builder: (context, state) {
        final cubit = context.read<CustomerShopDetailCubit>();
        Future<void> reload() => cubit.loadShopDetail(widget.shopId);
        final detail = state.detail;

        return Scaffold(
          appBar: AppTopBar(
            title: S().shopDetailTitle,
            trailing: detail == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.storefront_outlined),
                    onPressed: () => context.push(
                      Routes.customerStoreProductsScreen,
                      extra: widget.shopId,
                    ),
                  ),
          ),
          body: _buildBody(state, detail, reload),
          bottomNavigationBar: detail == null
              ? null
              : Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: SafeArea(
                    top: false,
                    child: PrimaryCtaButton(
                      label: S().bookNow,
                      onPressed: () {
                        sl<BookingFlowCubit>().startFlow(detail);
                        context.push(Routes.customerChooseServiceScreen);
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildBody(
    CustomerShopDetailState state,
    ShopDetail? detail,
    Future<void> Function() reload,
  ) {
    if (state.status == CustomerShopDetailStatus.loading && detail == null) {
      return const ListSkeleton();
    }

    if (state.status == CustomerShopDetailStatus.failure && detail == null) {
      return RefreshableStateView(
        onRefresh: reload,
        child: AppErrorState(message: state.errorMessage, onRetry: reload),
      );
    }

    if (detail == null) {
      return RefreshableStateView(
        onRefresh: reload,
        child: AppEmptyState(icon: Icons.storefront_outlined, title: S().noShopsYet),
      );
    }

    return RefreshIndicator(
      onRefresh: reload,
      child: _ShopDetailBody(
        detail: detail,
        onToggleFavorite: (barberId, currentlyFavorite) =>
            context.read<CustomerShopDetailCubit>().toggleFavorite(barberId, currentlyFavorite),
      ),
    );
  }
}

class _ShopDetailBody extends StatelessWidget {
  final ShopDetail detail;
  final void Function(int barberId, bool currentlyFavorite) onToggleFavorite;

  const _ShopDetailBody({required this.detail, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
      children: [
        Text(
          detail.shop.name,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: scheme.onSurface),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Icon(Icons.star_rounded, size: 16.r, color: context.semantic.accentSoft),
            SizedBox(width: 4.w),
            Text(
              '${detail.shop.rating.toStringAsFixed(1)} (${detail.shop.ratingCount})',
              style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant),
            ),
          ],
        ),
        if (detail.shop.address != null && detail.shop.address!.isNotEmpty) ...[
          SizedBox(height: 6.h),
          Text(
            detail.shop.address!,
            style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant),
          ),
        ],
        SectionTitle(title: S().barbersSectionTitle),
        if (detail.barbers.isEmpty)
          AppEmptyState(icon: Icons.content_cut_rounded, title: S().noBarbersYet, compact: true)
        else
          ...detail.barbers.map(
            (barber) => ShopBarberRow(
              barber: barber,
              onToggleFavorite: () => onToggleFavorite(barber.id, barber.favorite),
            ),
          ),
        if (detail.paymentMethods.isNotEmpty) ...[
          SectionTitle(title: S().paymentMethodsSectionTitle),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: detail.paymentMethods
                .map(
                  (method) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      method.name,
                      style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }
}
