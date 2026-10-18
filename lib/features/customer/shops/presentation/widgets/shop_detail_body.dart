import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/shop_detail.dart';
import 'shop_barbers_list.dart';
import 'shop_detail_header_card.dart';
import 'shop_payment_methods_row.dart';
import 'shop_services_overview.dart';
import 'shop_view_on_map_button.dart';

class ShopDetailBody extends StatelessWidget {
  final ShopDetail detail;
  final ValueChanged<int> onToggleFavorite;
  final VoidCallback onViewOnMap;

  const ShopDetailBody({
    super.key,
    required this.detail,
    required this.onToggleFavorite,
    required this.onViewOnMap,
  });

  @override
  Widget build(BuildContext context) {
    final owners = detail.barbers.where((b) => b.owner);
    final owner = owners.isNotEmpty
        ? owners.first
        : (detail.barbers.isNotEmpty ? detail.barbers.first : null);

    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
      children: [
        ShopDetailHeaderCard(
          shop: detail.shop,
          favorite: owner?.favorite ?? false,
          onToggleFavorite: owner == null
              ? () {}
              : () => onToggleFavorite(owner.id),
        ),
        if (detail.shop.location != null)
          ShopViewOnMapButton(onPressed: onViewOnMap),
        if (detail.paymentMethods.isNotEmpty) ...[
          SectionTitle(title: S().paymentMethodsSectionTitle),
          ShopPaymentMethodsRow(paymentMethods: detail.paymentMethods),
        ],
        if (detail.barbers.any((b) => b.services.isNotEmpty)) ...[
          SectionTitle(title: S().availableServicesSectionTitle),
          ShopServicesOverview(barbers: detail.barbers),
        ],
        SectionTitle(title: S().barbersSectionTitle),
        if (detail.barbers.isEmpty)
          AppEmptyState(
            icon: Icons.content_cut_rounded,
            title: S().noBarbersYet,
            compact: true,
          )
        else
          ShopBarbersList(barbers: detail.barbers),
      ],
    );
  }
}
