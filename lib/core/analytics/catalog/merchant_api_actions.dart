import '../api_action_rule.dart';

class MerchantApiActions {
  const MerchantApiActions._();

  static final rules = <ApiActionRule>[
    ApiActionRule.post(r'^merchant/product$', 'merchant_product_added'),
    ApiActionRule.put(r'^merchant/product/\d+$', 'merchant_product_updated'),
    ApiActionRule.delete(r'^merchant/product/\d+$', 'merchant_product_deleted'),
    ApiActionRule.put(
      r'^merchant/product/\d+/stock$',
      'merchant_product_stock_updated',
    ),
    ApiActionRule.delete(
      r'^merchant/product/\d+/image/\d+$',
      'merchant_product_image_removed',
    ),
    ApiActionRule.post(r'^merchant/category$', 'merchant_category_added'),
    ApiActionRule.put(r'^merchant/category/\d+$', 'merchant_category_updated'),
    ApiActionRule.delete(
      r'^merchant/category/\d+$',
      'merchant_category_deleted',
    ),
    ApiActionRule.put(
      r'^merchant/order/\d+/(accept|reject|status|ship)$',
      'merchant_order_updated',
    ),
    ApiActionRule.put(r'^merchant/delivery$', 'merchant_delivery_saved'),
    ApiActionRule.put(r'^merchant/location$', 'merchant_location_saved'),
    ApiActionRule.put(r'^merchant/profile$', 'merchant_profile_updated'),
    ApiActionRule.post(r'^merchant/phone$', 'merchant_phone_added'),
    ApiActionRule.delete(r'^merchant/phone/\d+$', 'merchant_phone_removed'),
  ];
}
