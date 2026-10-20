import 'package:flutter/material.dart';
import '../../../../../core/helpers/money_format.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/discount_quote.dart';

class QuoteResultCard extends StatelessWidget {
  final DiscountQuote quote;

  const QuoteResultCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in quote.lines) ...[
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${line.productName} × ${line.quantity}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: font13w700.copyWith(color: scheme.onSurface),
                      ),
                    ),
                    if (line.gift)
                      StatusBadge(
                        label: S().quoteGift,
                        tone: BadgeTone.gold,
                        showDot: false,
                      ),
                    SizedBox(width: 8.w),
                    Text(
                      S().currencyEgp(line.lineTotal),
                      style: font13w700.copyWith(color: scheme.onSurface),
                    ),
                  ],
                ),
                if (line.hasDiscount)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Text(
                          S().currencyEgp(line.unitPrice),
                          style: font12w400.copyWith(
                            color: scheme.onSurfaceVariant,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          S().currencyEgp(line.effectiveUnitPrice),
                          style: font12w400.copyWith(
                            color: context.semantic.success,
                          ),
                        ),
                        if (line.unitDiscountPercent != null) ...[
                          SizedBox(width: 6.w),
                          Text(
                            S().unitDiscountPercentLabel(
                              line.unitDiscountPercent!,
                            ),
                            style: font12w400.copyWith(
                              color: context.semantic.success,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                else
                  SizedBox(height: 6.h),
              ],
            ],
          ),
        ),
        SizedBox(height: 12.h),
        AppCard(
          child: Column(
            children: [
              if (quote.hasProductDiscount)
                InfoRow(
                  icon: Icons.sell_outlined,
                  label: S().quoteGrossTotal,
                  value: S().currencyEgp(quote.grossTotal),
                ),
              InfoRow(
                icon: Icons.receipt_long_outlined,
                label: S().quoteSubtotal,
                value: S().currencyEgp(quote.subtotal),
              ),
              if (quote.orderDiscount > 0)
                InfoRow(
                  icon: Icons.discount_outlined,
                  label: S().quoteOrderDiscount,
                  value: MoneyFormat.signed(quote.orderDiscount, positive: false),
                ),
              if (quote.savings > 0)
                InfoRow(
                  icon: Icons.savings_outlined,
                  label: S().quoteSavings,
                  value: S().currencyEgp(quote.savings),
                ),
              InfoRow(
                icon: Icons.payments_outlined,
                label: S().quoteTotal,
                value: S().currencyEgp(quote.total),
                showDivider: false,
              ),
            ],
          ),
        ),
        if (quote.applied.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Text(
              S().quoteNoDiscount,
              style: font12w400.copyWith(color: scheme.onSurfaceVariant),
            ),
          )
        else ...[
          SectionTitle(title: S().quoteAppliedTitle),
          for (final applied in quote.applied)
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 15.r,
                    color: context.semantic.success,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      '${applied.name} — ${applied.benefit}',
                      style: font12w400.copyWith(color: scheme.onSurface),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }
}
