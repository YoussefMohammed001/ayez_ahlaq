import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_input_decoration.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../products/presentation/manager/merchant_products_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class ProductSelector extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;

  const ProductSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, state) {
        final products = state.activeProducts;
        final selected = products.any((p) => p.id == value) ? value : null;

        return DropdownButtonFormField<int>(
          initialValue: selected,
          isExpanded: true,
          dropdownColor: context.colorScheme.surfaceContainer,
          decoration: AppInputDecoration.build(context, S().chooseProduct),
          style: TextStyle(
            color: context.colorScheme.onSurface,
            fontSize: 13.5.sp,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.colorScheme.onSurfaceVariant,
            size: 20.r,
          ),
          items: [
            for (final product in products)
              DropdownMenuItem(
                value: product.id,
                child: Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
          validator: (v) => v == null ? S().productRequired : null,
          onChanged: onChanged,
        );
      },
    );
  }
}
