import '../api_action_rule.dart';

class CommonApiActions {
  const CommonApiActions._();

  static const _anyRole = r'(customer|barber|merchant)';
  static const _cartRole = r'(customer|barber)';

  static final rules = <ApiActionRule>[
    ApiActionRule.post('^$_anyRole/login\$', 'login'),
    ApiActionRule.post('^$_anyRole/register\$', 'sign_up'),
    ApiActionRule.post('^$_anyRole/register/verifyOtp\$', 'otp_verified'),
    ApiActionRule.post('^$_anyRole/register/resendOtp\$', 'otp_resent'),
    ApiActionRule.post(
      '^$_anyRole/password/forgot\$',
      'password_reset_requested',
    ),
    ApiActionRule.post(
      '^$_anyRole/password/verifyOtp\$',
      'password_reset_otp_verified',
    ),
    ApiActionRule.post('^$_anyRole/password/reset\$', 'password_reset'),
    ApiActionRule.put('^$_anyRole/password\$', 'password_changed'),
    ApiActionRule.delete('^$_anyRole\$', 'account_deleted'),
    ApiActionRule.post('^$_anyRole/walletRequests\$', 'wallet_request_created'),
    ApiActionRule.put(
      '^$_anyRole/walletRequests/\\d+/cancel\$',
      'wallet_request_cancelled',
    ),
    ApiActionRule.post(
      '^$_anyRole/walletRequests/\\d+/attachment\$',
      'wallet_request_proof_added',
    ),
    ApiActionRule.post('^$_cartRole/cart/checkout\$', 'store_order_placed'),
    ApiActionRule.put('^$_cartRole/cart\$', 'store_cart_updated'),
    ApiActionRule.put(
      '^$_cartRole/order/\\d+/cancel\$',
      'store_order_cancelled',
    ),
    ApiActionRule.put(
      '^$_anyRole/notification/\\d+/clicked\$',
      'notification_opened',
    ),
    ApiActionRule.put(
      '^$_anyRole/notification/seen\$',
      'notifications_all_seen',
    ),
    ApiActionRule.post('^$_anyRole/broadcast\$', 'broadcast_sent'),
    ApiActionRule.post('^$_anyRole/sponsorship\$', 'sponsorship_requested'),
    ApiActionRule.post(
      '^$_anyRole/subscription/subscribe\$',
      'subscription_requested',
    ),
    ApiActionRule.post('^$_anyRole/discount\$', 'discount_created'),
    ApiActionRule.put('^$_anyRole/discount/\\d+\$', 'discount_updated'),
    ApiActionRule.put('^$_anyRole/discount/\\d+/close\$', 'discount_closed'),
    ApiActionRule.post(
      '^$_anyRole/attachment/\\d+/file\$',
      'document_uploaded',
    ),
    ApiActionRule.delete(
      '^$_anyRole/attachment/\\d+/file\$',
      'document_removed',
    ),
    ApiActionRule.post('^$_anyRole/profileImage\$', 'profile_image_changed'),
    ApiActionRule.delete('^$_anyRole/profileImage\$', 'profile_image_removed'),
  ];
}
