import 'package:flutter/material.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../manager/booking_flow_state.dart';
import 'booking_extra_line.dart';
import 'booking_extra_lines_list.dart';
import 'summary_row.dart';

class BookingSummaryCard extends StatelessWidget {
  final BookingFlowState state;

  const BookingSummaryCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          SummaryRow(label: S().serviceLabel, value: state.serviceName ?? ''),
          if (state.styleName != null)
            SummaryRow(label: S().styleLabel, value: state.styleName!),
          SummaryRow(
            label: S().barberLabel,
            value: state.barberName ?? S().autoSelectBarber,
          ),
          SummaryRow(
            label: S().bookingDateLabel,
            value:
                '${state.date ?? ''} · ${AppDateTime.formatHour(state.slotTime ?? '')}',
          ),
          BookingExtraLinesList(
            lines: [
              for (final addon in state.addons)
                BookingExtraLine(
                  name: addon.name,
                  quantity: addon.quantity,
                  price: addon.price,
                  isDrink: false,
                ),
              for (final drink in state.drinks)
                BookingExtraLine(
                  name: drink.name,
                  quantity: drink.quantity,
                  price: drink.price,
                  isDrink: true,
                ),
            ],
          ),
          SummaryRow(
            label: S().orderTotal,
            value: S().currencyEgp(state.totalPrice),
            emphasize: true,
          ),
        ],
      ),
    );
  }
}
