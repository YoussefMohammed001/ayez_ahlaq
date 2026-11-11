import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/sales_cubit.dart';
import '../manager/sales_state.dart';
import '../widgets/sale_row.dart';

class SalesScreen extends StatelessWidget {
  final bool asTab;

  const SalesScreen({super.key, this.asTab = false});

  Future<void> _newSale(BuildContext context) async {
    final cubit = context.read<SalesCubit>();
    final created = await context.push<bool>(Routes.merchantNewSaleScreen);
    if (created ?? false) cubit.refresh();
  }

  Widget _buildBody(BuildContext context, SalesState state) {
    final cubit = context.read<SalesCubit>();

    if (state.status == SalesStatus.initial ||
        (state.status == SalesStatus.loading && state.sales.isEmpty)) {
      return const ListSkeleton();
    }

    if (state.status == SalesStatus.failure && state.sales.isEmpty) {
      return AppErrorState(message: state.errorMessage, onRetry: cubit.load);
    }

    if (state.sales.isEmpty) {
      return RefreshIndicator(
        onRefresh: cubit.refresh,
        child: AppEmptyState(
          icon: Icons.point_of_sale_rounded,
          title: S().noSalesTitle,
          message: S().noSalesHint,
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 200) cubit.loadMore();
        return false;
      },
      child: RefreshIndicator(
        onRefresh: cubit.refresh,
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 90.h),
          itemCount: state.sales.length + (state.isLoadingMore ? 1 : 0),
          itemBuilder: (_, index) => index == state.sales.length
              ? const Center(child: CircularProgressIndicator())
              : SaleRow(
                  sale: state.sales[index],
                  onTap: () => context.push(
                    Routes.merchantSaleDetailsScreen,
                    extra: state.sales[index].id,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<SalesCubit, SalesState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: asTab ? null : AppTopBar(title: S().salesTitle),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _newSale(context),
          icon: const Icon(Icons.add_rounded),
          label: Text(S().newSaleTitle),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (asTab)
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                  child: Text(S().salesTitle, style: HeadingStyles.h2),
                ),
              Expanded(
                child: BlocBuilder<SalesCubit, SalesState>(builder: _buildBody),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
