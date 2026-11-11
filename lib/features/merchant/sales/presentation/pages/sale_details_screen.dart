import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/helpers/user_helpers.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/menu_section.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/sale.dart';
import '../manager/sales_cubit.dart';
import '../manager/sales_state.dart';
import '../widgets/sale_items_card.dart';
import '../widgets/sale_status_badge.dart';
import '../widgets/sale_totals_card.dart';

class SaleDetailsScreen extends StatelessWidget {
  final int saleId;

  const SaleDetailsScreen({super.key, required this.saleId});

  bool get _canCancel => !UserHelpers.merchantAccountKind.isSubMerchant;

  Future<void> _cancel(BuildContext context) async {
    final cubit = context.read<SalesCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().cancelSaleTitle,
      message: S().cancelSaleConfirm,
      confirmLabel: S().cancelSaleTitle,
      icon: Icons.cancel_outlined,
    );

    if (!confirmed) return;

    final cancelled = await cubit.cancel(saleId);
    if (cancelled != null) showSuccess(S().saleCancelled);
  }

  Sale? _find(List<Sale> sales) {
    for (final sale in sales) {
      if (sale.id == saleId) return sale;
    }
    return null;
  }

  Widget _buildContent(BuildContext context, Sale sale) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: SaleStatusBadge(sale: sale),
        ),
        SectionTitle(title: S().saleItemsTitle),
        SaleItemsCard(items: sale.items),
        SizedBox(height: 12.h),
        SaleTotalsCard(
          subtotal: sale.subtotal,
          discount: sale.discount,
          total: sale.total,
        ),
        SizedBox(height: 12.h),
        if (sale.customerPhone != null)
          InfoRow(
            icon: Icons.call_outlined,
            label: S().customerPhoneLabel,
            value: sale.customerPhone!,
            valueTextDirection: TextDirection.ltr,
          ),
        if (sale.note != null)
          InfoRow(
            icon: Icons.notes_outlined,
            label: S().saleNoteOptional,
            value: sale.note!,
          ),
        if (_canCancel && !sale.isCancelled)
          MenuSection(
            title: S().saleDetailsTitle,
            children: [
              MenuRow(
                icon: Icons.cancel_outlined,
                label: S().cancelSaleTitle,
                danger: true,
                onTap: () => _cancel(context),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<SalesCubit, SalesState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().saleDetailsTitle),
        body: BlocBuilder<SalesCubit, SalesState>(
          builder: (context, state) {
            final sale = _find(state.sales);

            return sale == null
                ? AppEmptyState(
                    icon: Icons.point_of_sale_rounded,
                    title: S().noSalesTitle,
                  )
                : _buildContent(context, sale);
          },
        ),
      ),
    );
  }
}
