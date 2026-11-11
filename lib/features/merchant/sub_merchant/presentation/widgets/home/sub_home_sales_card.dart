import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../sales/presentation/helpers/sale_money.dart';
import '../../../../sales/presentation/manager/sales_cubit.dart';
import '../../../../sales/presentation/manager/sales_state.dart';
import '../../helpers/sub_home_summary.dart';
import 'sub_home_card.dart';
import 'sub_home_value_text.dart';

class SubHomeSalesCard extends StatelessWidget {
  final VoidCallback onOpenSales;
  final VoidCallback onNewSale;

  const SubHomeSalesCard({
    super.key,
    required this.onOpenSales,
    required this.onNewSale,
  });

  Widget _summary(SalesState state) {
    if (state.status == SalesStatus.initial ||
        (state.status == SalesStatus.loading && state.sales.isEmpty)) {
      return const SubHomeValueText('...', muted: true);
    }

    final today = SubHomeSummary.salesTodayOf(state.sales, DateTime.now());
    if (today.count == 0) {
      return SubHomeValueText(S().subHomeSalesNone, muted: true);
    }

    return SubHomeValueText(
      S().subHomeSalesSummary('${today.count}', SaleMoney.format(today.total)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesCubit, SalesState>(
      builder: (context, state) => SubHomeCard(
        icon: Icons.point_of_sale_rounded,
        title: S().subHomeSalesTitle,
        onTap: onOpenSales,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _summary(state),
            SizedBox(height: 12.h),
            PrimaryCtaButton(label: S().newSaleTitle, onPressed: onNewSale),
          ],
        ),
      ),
    );
  }
}
