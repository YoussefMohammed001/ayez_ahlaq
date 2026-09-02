import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../products/domain/entities/product_insights.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../products/presentation/manager/merchant_products_state.dart';
import 'dashboard_product_list.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardStockLists extends StatelessWidget {
  const DashboardStockLists({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardProductList(
              title: S().topProducts,
              products: state.products.mostStocked,
            ),
            DashboardProductList(
              title: S().runningLowProducts,
              products: state.products.runningLow,
              countColor: context.semantic.warning,
            ),
          ],
        );
      },
    );
  }
}
