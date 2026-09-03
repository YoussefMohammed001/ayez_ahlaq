import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_store_merchants_cubit.dart';
import '../manager/barber_store_merchants_state.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/store_merchant_row.dart';

class BarberStoreMerchantsScreen extends StatelessWidget {
  const BarberStoreMerchantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().storeTitle, trailing: const CartIconButton()),
      body: BlocBuilder<BarberStoreMerchantsCubit, BarberStoreMerchantsState>(
        builder: (context, state) {
          final cubit = context.read<BarberStoreMerchantsCubit>();

          if (state.status == BarberStoreMerchantsStatus.loading && state.merchants.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == BarberStoreMerchantsStatus.failure && state.merchants.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadMerchants,
              child: AppErrorState(message: state.errorMessage, onRetry: cubit.loadMerchants),
            );
          }

          if (state.merchants.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadMerchants,
              child: AppEmptyState(icon: Icons.storefront_outlined, title: S().noMerchantsYet),
            );
          }

          return RefreshIndicator(
            onRefresh: cubit.loadMerchants,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              itemCount: state.merchants.length,
              itemBuilder: (_, index) {
                final merchant = state.merchants[index];
                return StoreMerchantRow(
                  merchant: merchant,
                  onTap: () => context.push(Routes.barberStoreProductsScreen, extra: merchant),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
