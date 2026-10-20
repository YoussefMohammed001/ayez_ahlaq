import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../booking/presentation/manager/booking_flow_cubit.dart';
import '../../../../../shared/guest/guest_guard.dart';
import '../../domain/entities/shop_detail.dart';
import '../../../favorites/presentation/manager/favorites_cubit.dart';
import '../manager/customer_shop_detail_cubit.dart';
import '../manager/customer_shop_detail_state.dart';
import '../widgets/shop_detail_body.dart';
import '../../../../../core/session/session_scope.dart';

class CustomerShopDetailScreen extends StatefulWidget {
  final int shopId;

  const CustomerShopDetailScreen({super.key, required this.shopId});

  @override
  State<CustomerShopDetailScreen> createState() =>
      _CustomerShopDetailScreenState();
}

class _CustomerShopDetailScreenState extends State<CustomerShopDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerShopDetailCubit>().loadShopDetail(widget.shopId);
  }

  Future<void> _toggleFavorite(int barberId) async {
    final saved = await context.read<CustomerShopDetailCubit>().toggleFavorite(
      barberId,
    );
    if (saved && mounted) context.read<FavoritesCubit>().reloadIfLoaded();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerShopDetailCubit, CustomerShopDetailState>(
      builder: (context, state) {
        final cubit = context.read<CustomerShopDetailCubit>();
        Future<void> reload() =>
            cubit.loadShopDetail(widget.shopId, isRefresh: true);
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
          body: _buildBody(state, detail, reload, _toggleFavorite),
          bottomNavigationBar: detail == null
              ? null
              : Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: SafeArea(
                    top: false,
                    child: PrimaryCtaButton(
                      label: S().bookNow,
                      onPressed: () => GuestGuard.run(context, () {
                        SessionScope.cubit<BookingFlowCubit>().startFlow(detail);
                        context.push(Routes.customerChooseServiceScreen);
                      }),
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
    ValueChanged<int> onToggleFavorite,
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
        child: AppEmptyState(
          icon: Icons.storefront_outlined,
          title: S().noShopsYet,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: reload,
      child: ShopDetailBody(
        detail: detail,
        onToggleFavorite: (id) =>
            GuestGuard.run(context, () => onToggleFavorite(id)),
        onViewOnMap: context.read<CustomerShopDetailCubit>().openShopOnMap,
      ),
    );
  }
}
