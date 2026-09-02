import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../discounts/presentation/manager/merchant_discounts_cubit.dart';
import '../../../documents/presentation/manager/merchant_documents_cubit.dart';
import '../../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../manager/merchant_dashboard_cubit.dart';
import '../manager/merchant_dashboard_state.dart';
import '../widgets/dashboard_attention_section.dart';
import '../widgets/dashboard_greeting.dart';
import '../widgets/dashboard_inventory_section.dart';
import '../widgets/dashboard_live_offers.dart';
import '../widgets/dashboard_note.dart';
import '../widgets/dashboard_orders_breakdown.dart';
import '../widgets/dashboard_overview_grid.dart';
import '../widgets/dashboard_recent_orders.dart';
import '../widgets/dashboard_skeleton.dart';
import '../widgets/dashboard_stock_lists.dart';
import '../../../../../generated/l10n.dart';

class MerchantDashboardScreen extends StatelessWidget {
  final VoidCallback onGoToOrders;
  final VoidCallback onGoToProducts;
  final String businessName;

  const MerchantDashboardScreen({
    super.key,
    required this.onGoToOrders,
    required this.onGoToProducts,
    required this.businessName,
  });

  Future<void> _refresh(BuildContext context) async {
    await Future.wait([
      context.read<MerchantDashboardCubit>().loadDashboard(),
      context.read<MerchantDiscountsCubit>().loadDiscounts(),
      context.read<MerchantProductsCubit>().loadProducts(),
      context.read<MerchantOrdersCubit>().loadOrders(),
      context.read<MerchantDocumentsCubit>().loadDocuments(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refresh(context),
          child: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
            children: [
              DashboardGreeting(businessName: businessName),
              SizedBox(height: 18.h),
              DashboardAttentionSection(
                onGoToOrders: onGoToOrders,
                onGoToProducts: onGoToProducts,
              ),
              SectionTitle(title: S().overviewTitle),
              _buildOverview(),
              SectionTitle(
                title: S().latestOrders,
                actionLabel: S().allOrders,
                onAction: onGoToOrders,
              ),
              const DashboardOrdersBreakdown(),
              const DashboardRecentOrders(),
              const DashboardInventorySection(),
              const DashboardStockLists(),
              const DashboardLiveOffers(),
              SizedBox(height: 18.h),
              const DashboardNote(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverview() {
    return BlocBuilder<MerchantDashboardCubit, MerchantDashboardState>(
      builder: (context, state) {
        if (state.status == DashboardStatus.loading &&
            state.dashboard == null) {
          return const DashboardSkeleton();
        }

        return DashboardOverviewGrid(onGoToOrders: onGoToOrders);
      },
    );
  }
}
