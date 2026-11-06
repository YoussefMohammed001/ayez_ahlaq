import '../api_action_rule.dart';

class CustomerApiActions {
  const CustomerApiActions._();

  static final rules = <ApiActionRule>[
    ApiActionRule.post(r'^customer/booking$', 'booking_created'),
    ApiActionRule.put(r'^customer/booking/\d+/cancel$', 'booking_cancelled'),
    ApiActionRule.post(r'^customer/rating$', 'booking_rated'),
    ApiActionRule.post(r'^customer/rating/order$', 'store_order_rated'),
    ApiActionRule.post(r'^customer/rating/visit$', 'visit_rated'),
    ApiActionRule.post(r'^customer/homeService$', 'home_service_requested'),
    ApiActionRule.put(
      r'^customer/homeService/\d+/cancel$',
      'home_service_cancelled',
    ),
    ApiActionRule.put(
      r'^customer/homeService/\d+/confirmPrice$',
      'home_service_price_confirmed',
    ),
    ApiActionRule.put(
      r'^customer/homeService/\d+/retry$',
      'home_service_retried',
    ),
    ApiActionRule.post(r'^customer/favorite/\d+$', 'favorite_added'),
    ApiActionRule.delete(r'^customer/favorite/\d+$', 'favorite_removed'),
    ApiActionRule.post(
      r'^customer/favorite/invite/[^/]+$',
      'favorite_added_via_invite',
    ),
  ];
}
