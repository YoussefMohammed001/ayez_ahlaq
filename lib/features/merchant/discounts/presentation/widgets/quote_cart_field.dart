import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../products/presentation/manager/merchant_products_state.dart';

class QuoteCartField extends StatelessWidget {
  final Map<int, int> items;
  final void Function(int productId, int quantity) onQuantityChanged;

  const QuoteCartField({
    super.key,
    required this.items,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, state) {
        final products = state.products.where((p) => p.active).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final product in products)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: font13w700.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            S().currencyEgp(product.price),
                            style: font12w400.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QuantityStepper(
                      quantity: items[product.id] ?? 0,
                      onChanged: (value) =>
                          onQuantityChanged(product.id, value),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
