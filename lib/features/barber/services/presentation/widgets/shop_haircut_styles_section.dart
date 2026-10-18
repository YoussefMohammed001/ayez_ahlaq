import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/shop_haircut_style.dart';
import '../manager/shop_haircut_styles_cubit.dart';
import '../manager/shop_haircut_styles_state.dart';
import 'haircut_style_price_sheet.dart';
import 'shop_haircut_style_row.dart';

class ShopHaircutStylesSection extends StatelessWidget {
  const ShopHaircutStylesSection({super.key});

  void _openPriceSheet(BuildContext context, ShopHaircutStyle style) {
    final cubit = context.read<ShopHaircutStylesCubit>();

    HaircutStylePriceSheet.show(
      context,
      style: style,
      onSubmit: (priceDelta, active) => cubit.updatePriceDelta(
        style.id,
        priceDelta: priceDelta,
        active: active,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopHaircutStylesCubit, ShopHaircutStylesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final style in state.styles)
              ShopHaircutStyleRow(
                style: style,
                onToggleActive: (active) => context
                    .read<ShopHaircutStylesCubit>()
                    .updatePriceDelta(
                      style.id,
                      priceDelta: style.priceDelta,
                      active: active,
                    ),
                onEditPrice: () => _openPriceSheet(context, style),
              ),
          ],
        );
      },
    );
  }
}
