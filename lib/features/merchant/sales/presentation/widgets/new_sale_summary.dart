import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../helpers/sale_totals.dart';
import '../manager/new_sale_cubit.dart';
import '../manager/new_sale_state.dart';
import 'sale_totals_card.dart';

class NewSaleSummary extends StatelessWidget {
  final double discount;
  final VoidCallback onSubmit;

  const NewSaleSummary({
    super.key,
    required this.discount,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewSaleCubit, NewSaleState>(
      builder: (context, saleState) {
        final products = context.watch<MerchantProductsCubit>().state;
        final totals = SaleTotals.of(
          products: products.products,
          quantities: saleState.quantities,
          discount: discount,
        );

        return Column(
          children: [
            SaleTotalsCard(
              subtotal: totals.subtotal,
              discount: totals.discount,
              total: totals.total,
            ),
            SizedBox(height: 14.h),
            PrimaryCtaButton(
              label: S().saleSubmit,
              isLoading: saleState.isSubmitting,
              onPressed: saleState.hasItems ? onSubmit : null,
            ),
          ],
        );
      },
    );
  }
}
