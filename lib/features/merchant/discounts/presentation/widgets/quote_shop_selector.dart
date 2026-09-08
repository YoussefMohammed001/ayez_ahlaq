import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';
import '../manager/merchant_discounts_cubit.dart';
import '../manager/merchant_discounts_state.dart';

class QuoteShopSelector extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;

  const QuoteShopSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantDiscountsCubit, MerchantDiscountsState>(
      builder: (context, state) {
        if (state.shops.isEmpty) return const SizedBox.shrink();

        return Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            ChoiceChip(
              label: Text(S().quoteAllShops),
              selected: value == null,
              onSelected: (_) => onChanged(null),
            ),
            for (final shop in state.shops)
              ChoiceChip(
                label: Text(shop.name),
                selected: value == shop.id,
                onSelected: (_) => onChanged(shop.id),
              ),
          ],
        );
      },
    );
  }
}
