import '../api_action_rule.dart';

class BarberShopApiActions {
  const BarberShopApiActions._();

  static final rules = <ApiActionRule>[
    ApiActionRule.post(r'^barber/service$', 'barber_service_added'),
    ApiActionRule.put(r'^barber/service/\d+$', 'barber_service_updated'),
    ApiActionRule.delete(r'^barber/service/\d+$', 'barber_service_deleted'),
    ApiActionRule.post(r'^barber/service/own$', 'barber_own_service_added'),
    ApiActionRule.delete(
      r'^barber/service/own/\d+$',
      'barber_own_service_deleted',
    ),
    ApiActionRule.put(
      r'^barber/haircutStyle/\d+$',
      'barber_haircut_style_updated',
    ),
    ApiActionRule.post(r'^barber/team$', 'barber_team_member_added'),
    ApiActionRule.put(r'^barber/team/\d+$', 'barber_team_member_updated'),
    ApiActionRule.delete(r'^barber/team/\d+$', 'barber_team_member_removed'),
    ApiActionRule.put(
      r'^barber/team/\d+/activate$',
      'barber_team_member_activated',
    ),
    ApiActionRule.put(
      r'^barber/team/\d+/availability$',
      'barber_team_member_availability',
    ),
    ApiActionRule.put(r'^barber/team/\d+/hours$', 'barber_team_hours_saved'),
    ApiActionRule.put(
      r'^barber/team/\d+/password$',
      'barber_team_password_reset',
    ),
    ApiActionRule.delete(
      r'^barber/team/\d+/permanent$',
      'barber_team_member_deleted',
    ),
    ApiActionRule.put(
      r'^barber/team/\d+/permissions$',
      'barber_team_permissions_saved',
    ),
    ApiActionRule.post(
      r'^barber/team/\d+/service$',
      'barber_team_service_added',
    ),
    ApiActionRule.put(
      r'^barber/team/\d+/service/\d+$',
      'barber_team_service_updated',
    ),
    ApiActionRule.delete(
      r'^barber/team/\d+/service/\d+$',
      'barber_team_service_removed',
    ),
    ApiActionRule.post(
      r'^barber/storefront/category$',
      'barber_storefront_category_added',
    ),
    ApiActionRule.put(
      r'^barber/storefront/category/\d+$',
      'barber_storefront_category_updated',
    ),
    ApiActionRule.delete(
      r'^barber/storefront/category/\d+$',
      'barber_storefront_category_deleted',
    ),
    ApiActionRule.put(
      r'^barber/storefront/delivery$',
      'barber_storefront_delivery_saved',
    ),
    ApiActionRule.post(
      r'^barber/storefront/product$',
      'barber_storefront_product_added',
    ),
    ApiActionRule.put(
      r'^barber/storefront/product/\d+$',
      'barber_storefront_product_updated',
    ),
    ApiActionRule.delete(
      r'^barber/storefront/product/\d+$',
      'barber_storefront_product_deleted',
    ),
    ApiActionRule.put(
      r'^barber/storefront/product/\d+/stock$',
      'barber_storefront_stock_updated',
    ),
    ApiActionRule.put(
      r'^barber/storefront/order/\d+/accept$',
      'barber_storefront_order_accepted',
    ),
    ApiActionRule.put(
      r'^barber/storefront/order/\d+/reject$',
      'barber_storefront_order_rejected',
    ),
    ApiActionRule.put(
      r'^barber/storefront/order/\d+/status$',
      'barber_storefront_order_status',
    ),
  ];
}
