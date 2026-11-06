import '../api_action_rule.dart';

class BarberOperationsApiActions {
  const BarberOperationsApiActions._();

  static final rules = <ApiActionRule>[
    ApiActionRule.post(r'^barber/attendance/checkIn$', 'barber_check_in'),
    ApiActionRule.post(r'^barber/attendance/checkOut$', 'barber_check_out'),
    ApiActionRule.put(
      r'^barber/attendance/setting$',
      'barber_attendance_settings_saved',
    ),
    ApiActionRule.put(
      r'^barber/attendance/\d+$',
      'barber_attendance_corrected',
    ),
    ApiActionRule.post(
      r'^barber/attendanceFeature/request$',
      'attendance_feature_requested',
    ),
    ApiActionRule.put(
      r'^barber/attendanceFeature/request/\d+/cancel$',
      'attendance_feature_request_cancelled',
    ),
    ApiActionRule.put(
      r'^barber/booking/\d+/confirm$',
      'barber_booking_accepted',
    ),
    ApiActionRule.put(
      r'^barber/booking/\d+/reject$',
      'barber_booking_rejected',
    ),
    ApiActionRule.put(
      r'^barber/booking/\d+/status$',
      'barber_booking_completed',
    ),
    ApiActionRule.put(r'^barber/booking/\d+/billing$', 'barber_booking_billed'),
    ApiActionRule.post(r'^barber/booking/settle$', 'barber_bookings_settled'),
    ApiActionRule.post(r'^barber/booking/walkin$', 'barber_walkin_added'),
    ApiActionRule.put(r'^barber/homeService$', 'barber_home_service_toggled'),
    ApiActionRule.put(
      r'^barber/homeService/hours$',
      'barber_home_service_hours_saved',
    ),
    ApiActionRule.put(
      r'^barber/homeService/broadcast/\d+/accept$',
      'barber_hs_broadcast_accepted',
    ),
    ApiActionRule.put(
      r'^barber/homeService/broadcast/\d+/reject$',
      'barber_hs_broadcast_rejected',
    ),
    ApiActionRule.put(
      r'^barber/homeService/request/\d+/accept$',
      'barber_hs_request_accepted',
    ),
    ApiActionRule.put(
      r'^barber/homeService/request/\d+/reject$',
      'barber_hs_request_rejected',
    ),
    ApiActionRule.put(
      r'^barber/homeService/request/\d+/price$',
      'barber_hs_request_priced',
    ),
    ApiActionRule.put(
      r'^barber/homeService/request/\d+/status$',
      'barber_hs_request_status_updated',
    ),
    ApiActionRule.put(r'^barber/hours$', 'barber_hours_saved'),
    ApiActionRule.put(r'^barber/location$', 'barber_location_saved'),
    ApiActionRule.put(
      r'^barber/invite/regenerate$',
      'barber_invite_regenerated',
    ),
    ApiActionRule.put(
      r'^barber/servesClients$',
      'barber_serves_clients_changed',
    ),
    ApiActionRule.post(r'^barber/rating/merchant$', 'merchant_rated'),
    ApiActionRule.post(r'^barber/money/entry$', 'barber_money_entry_added'),
    ApiActionRule.post(r'^barber/money/item$', 'barber_money_item_added'),
    ApiActionRule.put(r'^barber/money/item/\d+$', 'barber_money_item_updated'),
    ApiActionRule.delete(
      r'^barber/money/item/\d+$',
      'barber_money_item_deleted',
    ),
    ApiActionRule.put(
      r'^barber/money/occurrence/\d+/confirm$',
      'barber_money_occurrence_confirmed',
    ),
    ApiActionRule.put(
      r'^barber/money/occurrence/\d+/dismiss$',
      'barber_money_occurrence_dismissed',
    ),
    ApiActionRule.post(r'^barber/moneyPin$', 'barber_money_pin_set'),
    ApiActionRule.put(r'^barber/moneyPin$', 'barber_money_pin_changed'),
    ApiActionRule.post(
      r'^barber/moneyPin/resetRequest$',
      'barber_money_pin_reset_requested',
    ),
    ApiActionRule.post(r'^barber/drink$', 'barber_drink_added'),
    ApiActionRule.put(r'^barber/drink/\d+$', 'barber_drink_updated'),
    ApiActionRule.delete(r'^barber/drink/\d+$', 'barber_drink_deleted'),
  ];
}
