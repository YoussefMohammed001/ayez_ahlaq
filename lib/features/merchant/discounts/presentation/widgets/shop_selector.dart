import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../manager/merchant_discounts_cubit.dart';
import '../manager/merchant_discounts_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class ShopSelector extends StatelessWidget {
  final List<int> selected;
  final ValueChanged<List<int>> onChanged;

  const ShopSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  void _toggle(int id) {
    final next = [...selected];
    next.contains(id) ? next.remove(id) : next.add(id);
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantDiscountsCubit, MerchantDiscountsState>(
      builder: (context, state) {
        if (state.shops.isEmpty) {
          return Text(
            S().shopsAllNote,
            style: TextStyle(
              fontSize: 11.5.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selected.isEmpty
                  ? S().shopsAllHint
                  : S().shopsSelectedHint(selected.length),
              style: TextStyle(
                fontSize: 11.5.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                for (final shop in state.shops)
                  GestureDetector(
                    onTap: () => _toggle(shop.id),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: selected.contains(shop.id)
                            ? context.colorScheme.primaryContainer
                            : context.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(100.r),
                        border: Border.all(
                          color: selected.contains(shop.id)
                              ? context.colorScheme.primary
                              : context.colorScheme.outline,
                        ),
                      ),
                      child: Text(
                        shop.name,
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          color: selected.contains(shop.id)
                              ? context.semantic.accentSoft
                              : context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
