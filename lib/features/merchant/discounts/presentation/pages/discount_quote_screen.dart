import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../manager/discount_quote_cubit.dart';
import '../manager/discount_quote_state.dart';
import '../widgets/quote_cart_field.dart';
import '../widgets/quote_result_card.dart';
import '../widgets/quote_shop_selector.dart';

class DiscountQuoteScreen extends StatelessWidget {
  const DiscountQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DiscountQuoteCubit>();

    return Scaffold(
      appBar: AppTopBar(title: S().quoteTitle),
      body: BlocBuilder<DiscountQuoteCubit, DiscountQuoteState>(
        builder: (context, state) => ListView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
          children: [
            Text(
              S().quoteSubtitle,
              style: font12w400.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SectionTitle(title: S().quoteScopeShop),
            QuoteShopSelector(value: state.shopId, onChanged: cubit.setShop),
            SectionTitle(title: S().quotePickProducts),
            QuoteCartField(
              items: state.items,
              onQuantityChanged: cubit.setQuantity,
            ),
            SizedBox(height: 12.h),
            PrimaryCtaButton(
              label: S().quoteCalculate,
              isLoading: state.status == DiscountQuoteStatus.loading,
              onPressed: state.hasItems ? cubit.refreshQuote : null,
            ),
            SizedBox(height: 16.h),
            if (!state.hasItems)
              Text(
                S().quoteEmpty,
                textAlign: TextAlign.center,
                style: font12w400.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              )
            else if (state.status == DiscountQuoteStatus.failure)
              Text(
                state.errorMessage ?? S().somethingWentWrong,
                textAlign: TextAlign.center,
                style: font12w400.copyWith(color: context.semantic.warning),
              )
            else if (state.quote != null)
              QuoteResultCard(quote: state.quote!),
          ],
        ),
      ),
    );
  }
}
