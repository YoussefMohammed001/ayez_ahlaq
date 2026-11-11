import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../helpers/sale_totals.dart';
import '../manager/new_sale_cubit.dart';
import '../manager/new_sale_state.dart';
import '../widgets/new_sale_form.dart';

class NewSaleScreen extends StatelessWidget {
  const NewSaleScreen({super.key});

  Future<void> _submit(
    BuildContext context, {
    String? customerName,
    String? customerPhone,
    required double discount,
    String? note,
  }) async {
    final cubit = context.read<NewSaleCubit>();
    final products = context.read<MerchantProductsCubit>();
    final totals = SaleTotals.of(
      products: products.state.products,
      quantities: cubit.state.quantities,
      discount: discount,
    );

    if (totals.discountTooHigh) {
      showError(S().saleDiscountTooHigh);
      return;
    }

    final sale = await cubit.submit(
      customerName: customerName,
      customerPhone: customerPhone,
      discount: discount,
      note: note,
    );

    if (sale == null || !context.mounted) return;

    showSuccess(S().saleRecorded);
    products.loadProducts();
    hideLoading();
    context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<NewSaleCubit, NewSaleState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().newSaleTitle),
        body: NewSaleForm(
          onSubmit: ({customerName, customerPhone, required discount, note}) =>
              _submit(
                context,
                customerName: customerName,
                customerPhone: customerPhone,
                discount: discount,
                note: note,
              ),
        ),
      ),
    );
  }
}
