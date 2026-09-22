import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/location/current_position_resolver.dart';
import '../../shared/support/data/apis/support_api.dart';
import '../../shared/support/data/repos/support_repo.dart';
import '../../shared/support/domain/repos/i_support_repo.dart';
import '../../shared/support/domain/use_cases/get_support_info_use_case.dart';
import '../../shared/support/presentation/manager/support_cubit.dart';
import '../../features/customer/profile/domain/use_cases/change_customer_password_use_case.dart';
import '../../features/customer/profile/domain/use_cases/delete_customer_account_use_case.dart';
import '../../features/barber/profile/domain/use_cases/delete_barber_account_use_case.dart';
import '../../features/merchant/profile/domain/use_cases/delete_merchant_account_use_case.dart';
import '../../features/customer/auth/data/apis/customer_auth_api.dart';
import '../../features/customer/auth/data/repos/customer_auth_repo.dart';
import '../../features/customer/auth/domain/repos/i_customer_auth_repo.dart';
import '../../features/customer/auth/domain/use_cases/customer_login_use_case.dart';
import '../../features/customer/auth/domain/use_cases/customer_logout_use_case.dart';
import '../../features/customer/auth/domain/use_cases/customer_register_use_case.dart';
import '../../features/customer/auth/domain/use_cases/resend_customer_register_otp_use_case.dart';
import '../../features/customer/auth/domain/use_cases/verify_customer_register_otp_use_case.dart';
import '../../features/customer/auth/domain/use_cases/forgot_customer_password_use_case.dart';
import '../../features/customer/auth/domain/use_cases/verify_customer_password_otp_use_case.dart';
import '../../features/customer/auth/domain/use_cases/reset_customer_password_use_case.dart';
import '../../features/customer/auth/presentation/manager/customer_auth_cubit.dart';
import '../../features/customer/device_token/data/apis/customer_device_token_api.dart';
import '../../features/customer/device_token/data/repos/customer_device_token_repo.dart';
import '../../features/customer/device_token/domain/repos/i_customer_device_token_repo.dart';
import '../../features/customer/device_token/domain/use_cases/register_customer_device_token_use_case.dart';
import '../../features/customer/device_token/domain/use_cases/unregister_all_customer_device_tokens_use_case.dart';
import '../../features/customer/device_token/presentation/services/customer_device_token_sync_service.dart';
import '../../features/customer/notifications/data/apis/customer_notifications_api.dart';
import '../../features/customer/notifications/data/repos/customer_notifications_repo.dart';
import '../../features/customer/notifications/domain/repos/i_customer_notifications_repo.dart';
import '../../features/customer/notifications/domain/use_cases/get_customer_notifications_use_case.dart';
import '../../features/customer/notifications/domain/use_cases/get_customer_unseen_notifications_count_use_case.dart';
import '../../features/customer/notifications/domain/use_cases/mark_all_customer_notifications_seen_use_case.dart';
import '../../features/customer/notifications/domain/use_cases/mark_customer_notification_clicked_use_case.dart';
import '../../features/customer/notifications/presentation/manager/customer_notifications_cubit.dart';
import '../../features/customer/notifications/presentation/services/customer_notification_router.dart';
import '../../features/customer/shops/data/apis/customer_shops_api.dart';
import '../../features/customer/shops/data/repos/customer_shops_repo.dart';
import '../../features/customer/shops/domain/repos/i_customer_shops_repo.dart';
import '../../features/customer/shops/domain/use_cases/get_shop_detail_use_case.dart';
import '../../features/customer/shops/domain/use_cases/get_shops_use_case.dart';
import '../../features/customer/shops/presentation/manager/customer_shop_detail_cubit.dart';
import '../../features/customer/shops/presentation/manager/customer_shops_cubit.dart';
import '../../features/customer/home_service/data/apis/customer_home_service_api.dart';
import '../../features/customer/home_service/data/repos/customer_home_service_repo.dart';
import '../../features/customer/home_service/domain/repos/i_customer_home_service_repo.dart';
import '../../features/customer/home_service/domain/use_cases/get_home_service_shops_use_case.dart';
import '../../features/customer/home_service/domain/use_cases/get_home_service_shop_hours_use_case.dart';
import '../../features/customer/home_service/domain/use_cases/create_home_service_request_use_case.dart';
import '../../features/customer/home_service/domain/use_cases/get_my_home_service_requests_use_case.dart';
import '../../features/customer/home_service/domain/use_cases/get_home_service_request_use_case.dart';
import '../../features/customer/home_service/domain/use_cases/confirm_home_service_price_use_case.dart';
import '../../features/customer/home_service/domain/use_cases/cancel_home_service_request_use_case.dart';
import '../../features/customer/home_service/presentation/manager/home_service_shops_cubit.dart';
import '../../features/customer/home_service/presentation/manager/home_service_request_form_cubit.dart';
import '../../features/customer/home_service/presentation/manager/home_service_requests_cubit.dart';
import '../../features/customer/home_service/presentation/manager/home_service_request_detail_cubit.dart';
import '../../features/customer/booking/data/apis/customer_booking_api.dart';
import '../../features/customer/booking/data/repos/customer_booking_repo.dart';
import '../../features/customer/booking/domain/repos/i_customer_booking_repo.dart';
import '../../features/customer/booking/domain/use_cases/cancel_booking_use_case.dart';
import '../../features/customer/booking/domain/use_cases/create_booking_use_case.dart';
import '../../features/customer/booking/domain/use_cases/get_booking_slots_use_case.dart';
import '../../features/customer/booking/domain/use_cases/get_booking_use_case.dart'
    as customer_booking;
import '../../features/customer/booking/domain/use_cases/get_bookings_use_case.dart'
    as customer_booking;
import '../../features/customer/booking/domain/use_cases/rate_booking_use_case.dart';
import '../../features/customer/booking/presentation/manager/booking_detail_cubit.dart';
import '../../features/customer/booking/presentation/manager/booking_flow_cubit.dart';
import '../../features/customer/booking/presentation/manager/my_bookings_cubit.dart';
import '../../features/customer/store/data/apis/customer_store_api.dart';
import '../../features/customer/store/data/repos/customer_store_repo.dart';
import '../../features/customer/store/domain/repos/i_customer_store_repo.dart';
import '../../features/customer/store/domain/use_cases/cancel_store_order_use_case.dart'
    as customer_store;
import '../../features/customer/store/domain/use_cases/get_storefront_use_case.dart';
import '../../features/customer/store/domain/use_cases/get_store_orders_use_case.dart'
    as customer_store;
import '../../features/customer/store/domain/use_cases/get_cart_use_case.dart'
    as customer_store;
import '../../features/customer/store/domain/use_cases/put_cart_use_case.dart'
    as customer_store;
import '../../features/customer/store/domain/use_cases/checkout_cart_use_case.dart'
    as customer_store;
import '../../features/customer/store/presentation/manager/store_cart_cubit.dart';
import '../../features/customer/store/presentation/manager/store_orders_cubit.dart';
import '../../features/customer/payment_methods/data/apis/customer_payment_methods_api.dart';
import '../../features/customer/payment_methods/data/repos/customer_payment_methods_repo.dart';
import '../../features/customer/payment_methods/domain/repos/i_customer_payment_methods_repo.dart';
import '../../features/customer/payment_methods/domain/use_cases/get_enabled_payment_methods_use_case.dart';
import '../../features/customer/payment_methods/presentation/manager/payment_methods_cubit.dart';
import '../../features/customer/favorites/data/apis/customer_favorites_api.dart';
import '../../features/customer/favorites/data/repos/customer_favorites_repo.dart';
import '../../features/customer/favorites/domain/repos/i_customer_favorites_repo.dart';
import '../../features/customer/favorites/domain/use_cases/add_favorite_use_case.dart';
import '../../features/customer/favorites/domain/use_cases/add_favorite_via_invite_use_case.dart';
import '../../features/customer/favorites/domain/use_cases/get_favorites_use_case.dart';
import '../../features/customer/favorites/domain/use_cases/get_invite_preview_use_case.dart';
import '../../features/customer/favorites/domain/use_cases/remove_favorite_use_case.dart';
import '../../features/customer/favorites/presentation/manager/favorites_cubit.dart';
import '../../features/customer/favorites/presentation/manager/invite_preview_cubit.dart';
import '../../features/customer/profile/data/apis/customer_profile_api.dart';
import '../../features/customer/profile/data/repos/customer_profile_repo.dart';
import '../../features/customer/profile/domain/repos/i_customer_profile_repo.dart';
import '../../features/customer/profile/domain/use_cases/get_customer_profile_use_case.dart';
import '../../features/customer/profile/presentation/manager/customer_profile_cubit.dart';
import '../../features/barber/auth/data/apis/barber_auth_api.dart';
import '../../features/barber/auth/data/repos/barber_auth_repo.dart';
import '../../features/barber/auth/domain/repos/i_barber_auth_repo.dart';
import '../../features/barber/auth/domain/use_cases/barber_login_use_case.dart';
import '../../features/barber/auth/domain/use_cases/barber_register_use_case.dart';
import '../../features/barber/auth/domain/use_cases/resend_barber_register_otp_use_case.dart';
import '../../features/barber/auth/domain/use_cases/verify_barber_register_otp_use_case.dart';
import '../../features/barber/auth/domain/use_cases/forgot_barber_password_use_case.dart';
import '../../features/barber/auth/domain/use_cases/verify_barber_password_otp_use_case.dart';
import '../../features/barber/auth/domain/use_cases/reset_barber_password_use_case.dart';
import '../../features/barber/auth/domain/use_cases/barber_logout_use_case.dart';
import '../../features/barber/auth/presentation/manager/barber_auth_cubit.dart';
import '../../features/barber/profile/data/apis/barber_profile_api.dart';
import '../../features/barber/profile/data/repos/barber_profile_repo.dart';
import '../../features/barber/profile/domain/repos/i_barber_profile_repo.dart';
import '../../features/barber/profile/domain/use_cases/get_barber_profile_use_case.dart';
import '../../features/barber/profile/domain/use_cases/update_barber_location_use_case.dart';
import '../../features/barber/profile/domain/use_cases/update_serves_clients_use_case.dart';
import '../../features/barber/discounts/data/apis/barber_discounts_api.dart';
import '../../features/barber/discounts/data/repos/barber_discounts_repo.dart';
import '../../features/barber/discounts/domain/repos/i_barber_discounts_repo.dart';
import '../../features/barber/discounts/domain/use_cases/close_barber_discount_use_case.dart';
import '../../features/barber/discounts/domain/use_cases/create_barber_discount_use_case.dart';
import '../../features/barber/discounts/domain/use_cases/get_barber_discount_by_id_use_case.dart';
import '../../features/barber/discounts/domain/use_cases/get_barber_discounts_use_case.dart';
import '../../features/barber/discounts/domain/use_cases/update_barber_discount_use_case.dart';
import '../../features/barber/discounts/presentation/manager/barber_discounts_cubit.dart';
import '../../features/barber/drinks/data/apis/barber_drinks_api.dart';
import '../../features/barber/drinks/data/repos/barber_drinks_repo.dart';
import '../../features/barber/drinks/domain/repos/i_barber_drinks_repo.dart';
import '../../features/barber/drinks/domain/use_cases/create_drink_use_case.dart';
import '../../features/barber/drinks/domain/use_cases/delete_drink_use_case.dart';
import '../../features/barber/drinks/domain/use_cases/get_drinks_use_case.dart';
import '../../features/barber/drinks/domain/use_cases/update_drink_use_case.dart';
import '../../features/barber/drinks/presentation/manager/barber_drinks_cubit.dart';
import '../../features/barber/payment_methods/data/apis/barber_payment_methods_api.dart';
import '../../features/barber/payment_methods/data/repos/barber_payment_methods_repo.dart';
import '../../features/barber/payment_methods/domain/repos/i_barber_payment_methods_repo.dart';
import '../../features/barber/payment_methods/domain/use_cases/get_barber_payment_methods_use_case.dart';
import '../../features/barber/payment_methods/presentation/manager/barber_payment_methods_cubit.dart';
import '../../features/merchant/sponsorship/data/apis/merchant_sponsorship_api.dart';
import '../../features/merchant/sponsorship/data/repos/merchant_sponsorship_repo.dart';
import '../../features/merchant/sponsorship/domain/repos/i_merchant_sponsorship_repo.dart';
import '../../features/merchant/sponsorship/domain/use_cases/buy_merchant_sponsorship_use_case.dart';
import '../../features/merchant/sponsorship/domain/use_cases/get_merchant_sponsorship_use_case.dart';
import '../../features/merchant/sponsorship/presentation/manager/merchant_sponsorship_cubit.dart';
import '../../features/barber/sponsorship/data/apis/barber_sponsorship_api.dart';
import '../../features/barber/sponsorship/data/repos/barber_sponsorship_repo.dart';
import '../../features/barber/sponsorship/domain/repos/i_barber_sponsorship_repo.dart';
import '../../features/barber/sponsorship/domain/use_cases/buy_barber_sponsorship_use_case.dart';
import '../../features/barber/sponsorship/domain/use_cases/get_barber_sponsorship_use_case.dart';
import '../../features/barber/sponsorship/presentation/manager/barber_sponsorship_cubit.dart';
import '../../features/barber/profile/domain/use_cases/change_barber_password_use_case.dart';
import '../../features/barber/profile/presentation/manager/barber_profile_cubit.dart';
import '../../features/barber/hours/data/apis/barber_hours_api.dart';
import '../../features/barber/hours/data/repos/barber_hours_repo.dart';
import '../../features/barber/hours/domain/repos/i_barber_hours_repo.dart';
import '../../features/barber/hours/domain/use_cases/get_barber_hours_use_case.dart';
import '../../features/barber/hours/domain/use_cases/update_barber_hours_use_case.dart';
import '../../features/barber/hours/presentation/manager/barber_hours_cubit.dart';
import '../../features/barber/home_service/data/apis/barber_home_service_api.dart';
import '../../features/barber/home_service/data/apis/barber_home_service_hours_api.dart';
import '../../features/barber/home_service/data/repos/barber_home_service_repo.dart';
import '../../features/barber/home_service/data/repos/barber_home_service_hours_repo.dart';
import '../../features/barber/home_service/domain/repos/i_barber_home_service_repo.dart';
import '../../features/barber/home_service/domain/repos/i_barber_home_service_hours_repo.dart';
import '../../features/barber/home_service/domain/use_cases/get_home_service_settings_use_case.dart';
import '../../features/barber/home_service/domain/use_cases/update_home_service_settings_use_case.dart';
import '../../features/barber/home_service/domain/use_cases/get_home_service_hours_use_case.dart';
import '../../features/barber/home_service/domain/use_cases/update_home_service_hours_use_case.dart';
import '../../features/barber/home_service/presentation/manager/home_service_settings_cubit.dart';
import '../../features/barber/home_service/presentation/manager/home_service_hours_cubit.dart';
import '../../features/barber/home_service_requests/data/apis/barber_home_service_request_api.dart';
import '../../features/barber/home_service_requests/data/repos/barber_home_service_request_repo.dart';
import '../../features/barber/home_service_requests/domain/repos/i_barber_home_service_request_repo.dart';
import '../../features/barber/home_service_requests/domain/use_cases/accept_home_service_request_use_case.dart';
import '../../features/barber/home_service_requests/domain/use_cases/get_home_service_request_use_case.dart' as barber_hsr;
import '../../features/barber/home_service_requests/domain/use_cases/get_home_service_requests_use_case.dart' as barber_hsr;
import '../../features/barber/home_service_requests/domain/use_cases/reject_home_service_request_use_case.dart';
import '../../features/barber/home_service_requests/domain/use_cases/update_home_service_request_price_use_case.dart';
import '../../features/barber/home_service_requests/domain/use_cases/update_home_service_request_status_use_case.dart';
import '../../features/barber/home_service_requests/presentation/manager/home_service_requests_cubit.dart' as barber_hsr;
import '../../features/barber/services/data/apis/barber_services_api.dart';
import '../../features/barber/services/data/repos/barber_services_repo.dart';
import '../../features/barber/services/domain/repos/i_barber_services_repo.dart';
import '../../features/barber/services/domain/use_cases/create_barber_service_use_case.dart';
import '../../features/barber/services/domain/use_cases/create_own_service_use_case.dart';
import '../../features/barber/services/domain/use_cases/delete_barber_service_use_case.dart';
import '../../features/barber/services/domain/use_cases/delete_own_service_use_case.dart';
import '../../features/barber/services/domain/use_cases/get_barber_services_use_case.dart';
import '../../features/barber/services/domain/use_cases/get_own_services_use_case.dart';
import '../../features/barber/services/domain/use_cases/get_service_catalog_use_case.dart';
import '../../features/barber/services/domain/use_cases/update_barber_service_use_case.dart';
import '../../features/barber/services/presentation/manager/barber_services_cubit.dart';
import '../../features/barber/services/presentation/manager/own_services_cubit.dart';
import '../../features/barber/documents/data/apis/barber_documents_api.dart';
import '../../features/barber/documents/data/repos/barber_documents_repo.dart';
import '../../features/barber/documents/domain/repos/i_barber_documents_repo.dart';
import '../../features/barber/documents/domain/use_cases/delete_document_file_use_case.dart'
    as barber;
import '../../features/barber/documents/domain/use_cases/download_document_file_use_case.dart'
    as barber;
import '../../features/barber/documents/domain/use_cases/get_documents_use_case.dart'
    as barber;
import '../../features/barber/documents/domain/use_cases/upload_document_file_use_case.dart'
    as barber;
import '../../features/barber/documents/presentation/manager/barber_documents_cubit.dart';
import '../../features/barber/store/data/apis/barber_store_api.dart';
import '../../features/barber/store/data/repos/barber_store_repo.dart';
import '../../features/barber/store/domain/repos/i_barber_store_repo.dart';
import '../../features/barber/store/domain/use_cases/cancel_store_order_use_case.dart';
import '../../features/barber/store/domain/use_cases/get_merchant_products_use_case.dart';
import '../../features/barber/store/domain/use_cases/get_store_merchants_use_case.dart';
import '../../features/barber/store/domain/use_cases/get_store_order_use_case.dart';
import '../../features/barber/store/domain/use_cases/get_store_orders_use_case.dart';
import '../../features/barber/store/domain/use_cases/checkout_cart_use_case.dart';
import '../../features/barber/store/domain/use_cases/get_cart_use_case.dart';
import '../../features/barber/store/domain/use_cases/get_quote_use_case.dart';
import '../../features/barber/store/domain/use_cases/put_cart_use_case.dart';
import '../../features/barber/store/presentation/manager/barber_store_cart_cubit.dart';
import '../../features/barber/store/presentation/manager/barber_store_merchants_cubit.dart';
import '../../features/barber/store/presentation/manager/barber_store_orders_cubit.dart';
import '../../features/barber/storefront/products/data/apis/barber_storefront_products_api.dart';
import '../../features/barber/storefront/products/data/repos/barber_storefront_products_repo.dart';
import '../../features/barber/storefront/products/domain/repos/i_barber_storefront_products_repo.dart';
import '../../features/barber/storefront/products/domain/use_cases/create_storefront_product_use_case.dart';
import '../../features/barber/storefront/products/domain/use_cases/delete_storefront_product_use_case.dart';
import '../../features/barber/storefront/products/domain/use_cases/get_storefront_products_use_case.dart';
import '../../features/barber/storefront/products/domain/use_cases/set_storefront_product_stock_use_case.dart';
import '../../features/barber/storefront/products/domain/use_cases/update_storefront_product_use_case.dart';
import '../../features/barber/storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../../features/barber/storefront/categories/data/apis/barber_storefront_categories_api.dart';
import '../../features/barber/storefront/categories/data/repos/barber_storefront_categories_repo.dart';
import '../../features/barber/storefront/categories/domain/repos/i_barber_storefront_categories_repo.dart';
import '../../features/barber/storefront/categories/domain/use_cases/create_storefront_category_use_case.dart';
import '../../features/barber/storefront/categories/domain/use_cases/delete_storefront_category_use_case.dart';
import '../../features/barber/storefront/categories/domain/use_cases/get_assignable_storefront_categories_use_case.dart';
import '../../features/barber/storefront/categories/domain/use_cases/get_own_storefront_categories_use_case.dart';
import '../../features/barber/storefront/categories/domain/use_cases/update_storefront_category_use_case.dart';
import '../../features/barber/storefront/categories/presentation/manager/barber_storefront_categories_cubit.dart';
import '../../features/barber/storefront/delivery/data/apis/barber_storefront_delivery_api.dart';
import '../../features/barber/storefront/delivery/data/repos/barber_storefront_delivery_repo.dart';
import '../../features/barber/storefront/delivery/domain/repos/i_barber_storefront_delivery_repo.dart';
import '../../features/barber/storefront/delivery/domain/use_cases/get_storefront_delivery_use_case.dart';
import '../../features/barber/storefront/delivery/domain/use_cases/update_storefront_delivery_use_case.dart';
import '../../features/barber/storefront/delivery/presentation/manager/barber_storefront_delivery_cubit.dart';
import '../../features/barber/storefront/orders/data/apis/barber_storefront_orders_api.dart';
import '../../features/barber/storefront/orders/data/repos/barber_storefront_orders_repo.dart';
import '../../features/barber/storefront/orders/domain/repos/i_barber_storefront_orders_repo.dart';
import '../../features/barber/storefront/orders/domain/use_cases/accept_storefront_order_use_case.dart';
import '../../features/barber/storefront/orders/domain/use_cases/advance_storefront_order_status_use_case.dart';
import '../../features/barber/storefront/orders/domain/use_cases/get_storefront_order_use_case.dart';
import '../../features/barber/storefront/orders/domain/use_cases/get_storefront_orders_use_case.dart';
import '../../features/barber/storefront/orders/domain/use_cases/reject_storefront_order_use_case.dart';
import '../../features/barber/storefront/orders/presentation/manager/barber_storefront_orders_cubit.dart';
import '../../features/barber/wallet/data/apis/barber_wallet_api.dart';
import '../../features/barber/wallet/data/repos/barber_wallet_repo.dart';
import '../../features/barber/wallet/domain/repos/i_barber_wallet_repo.dart';
import '../../features/barber/wallet/domain/use_cases/get_barber_wallet_use_case.dart';
import '../../features/barber/wallet/presentation/manager/barber_wallet_cubit.dart';
import '../../features/barber/wallet/data/apis/barber_wallet_requests_api.dart';
import '../../features/barber/wallet/data/repos/barber_wallet_requests_repo.dart';
import '../../features/barber/wallet/domain/repos/i_barber_wallet_requests_repo.dart';
import '../../features/barber/wallet/domain/use_cases/get_wallet_requests_use_case.dart';
import '../../features/barber/wallet/domain/use_cases/get_wallet_request_detail_use_case.dart';
import '../../features/barber/wallet/domain/use_cases/create_wallet_request_use_case.dart';
import '../../features/barber/wallet/domain/use_cases/get_transfer_accounts_use_case.dart';
import '../../features/barber/wallet/domain/use_cases/get_withdraw_methods_use_case.dart';
import '../../features/barber/wallet/domain/use_cases/cancel_wallet_request_use_case.dart';
import '../../features/barber/wallet/domain/use_cases/get_wallet_request_attachment_use_case.dart';
import '../../features/barber/wallet/presentation/manager/barber_wallet_requests_cubit.dart';
import '../../features/barber/money/data/apis/barber_money_api.dart';
import '../../features/barber/money/data/apis/barber_money_pin_api.dart';
import '../../features/barber/money/data/repos/barber_money_repo.dart';
import '../../features/barber/money/data/repos/barber_money_pin_repo.dart';
import '../../features/barber/money/domain/repos/i_barber_money_repo.dart';
import '../../features/barber/money/domain/repos/i_barber_money_pin_repo.dart';
import '../../features/barber/money/domain/use_cases/get_money_items_use_case.dart';
import '../../features/barber/money/domain/use_cases/create_money_item_use_case.dart';
import '../../features/barber/money/domain/use_cases/update_money_item_use_case.dart';
import '../../features/barber/money/domain/use_cases/delete_money_item_use_case.dart';
import '../../features/barber/money/domain/use_cases/get_money_entries_use_case.dart';
import '../../features/barber/money/domain/use_cases/create_money_entry_use_case.dart';
import '../../features/barber/money/domain/use_cases/get_money_summary_use_case.dart';
import '../../features/barber/money/domain/use_cases/get_pending_occurrences_use_case.dart';
import '../../features/barber/money/domain/use_cases/confirm_occurrence_use_case.dart';
import '../../features/barber/money/domain/use_cases/dismiss_occurrence_use_case.dart';
import '../../features/barber/money/domain/use_cases/check_money_pin_use_case.dart';
import '../../features/barber/money/domain/use_cases/setup_money_pin_use_case.dart';
import '../../features/barber/money/domain/use_cases/verify_money_pin_use_case.dart';
import '../../features/barber/money/domain/use_cases/change_money_pin_use_case.dart';
import '../../features/barber/money/domain/use_cases/get_money_pin_reset_status_use_case.dart';
import '../../features/barber/money/domain/use_cases/request_money_pin_reset_use_case.dart';
import '../../features/barber/money/presentation/manager/money_pin_cubit.dart';
import '../../features/barber/money/presentation/manager/money_home_cubit.dart';
import '../../features/barber/money/presentation/manager/money_items_cubit.dart';
import '../../features/barber/money/presentation/manager/money_entries_cubit.dart';
import '../../features/barber/wallet/presentation/manager/create_wallet_request_cubit.dart';
import '../../features/barber/reviews/data/apis/barber_reviews_api.dart';
import '../../features/barber/reviews/data/repos/barber_reviews_repo.dart';
import '../../features/barber/reviews/domain/repos/i_barber_reviews_repo.dart';
import '../../features/barber/reviews/domain/use_cases/get_barber_reviews_use_case.dart';
import '../../features/barber/reviews/presentation/manager/barber_reviews_cubit.dart';
import '../../features/barber/invite/data/apis/barber_invite_api.dart';
import '../../features/barber/invite/data/repos/barber_invite_repo.dart';
import '../../features/barber/invite/domain/repos/i_barber_invite_repo.dart';
import '../../features/barber/invite/domain/use_cases/get_barber_invite_use_case.dart';
import '../../features/barber/invite/domain/use_cases/regenerate_barber_invite_use_case.dart';
import '../../features/barber/invite/presentation/manager/barber_invite_cubit.dart';
import '../../features/barber/subscription/data/apis/barber_subscription_api.dart';
import '../../features/barber/subscription/data/repos/barber_subscription_repo.dart';
import '../../features/barber/subscription/domain/repos/i_barber_subscription_repo.dart';
import '../../features/barber/subscription/domain/use_cases/get_barber_subscription_use_case.dart';
import '../../features/barber/subscription/domain/use_cases/get_barber_subscription_plans_use_case.dart';
import '../../features/barber/subscription/domain/use_cases/subscribe_barber_use_case.dart';
import '../../features/barber/subscription/domain/use_cases/get_barber_subscription_requests_use_case.dart';
import '../../features/barber/subscription/presentation/manager/barber_subscription_cubit.dart';
import '../../features/barber/subscription/presentation/manager/barber_subscription_requests_cubit.dart';
import '../../features/barber/broadcast/data/apis/barber_broadcast_api.dart';
import '../../features/barber/broadcast/data/repos/barber_broadcast_repo.dart';
import '../../features/barber/broadcast/domain/repos/i_barber_broadcast_repo.dart';
import '../../features/barber/broadcast/domain/use_cases/get_broadcasts_use_case.dart';
import '../../features/barber/broadcast/domain/use_cases/send_barber_broadcast_use_case.dart';
import '../../features/barber/broadcast/presentation/manager/barber_broadcast_cubit.dart';
import '../../features/barber/broadcast/presentation/manager/broadcast_list_cubit.dart';
import '../../features/merchant/subscription/data/apis/merchant_subscription_api.dart';
import '../../features/merchant/subscription/data/repos/merchant_subscription_repo.dart';
import '../../features/merchant/subscription/domain/repos/i_merchant_subscription_repo.dart';
import '../../features/merchant/subscription/domain/use_cases/get_merchant_subscription_use_case.dart';
import '../../features/merchant/subscription/domain/use_cases/get_merchant_subscription_plans_use_case.dart';
import '../../features/merchant/subscription/domain/use_cases/subscribe_merchant_use_case.dart';
import '../../features/merchant/subscription/domain/use_cases/get_merchant_subscription_requests_use_case.dart';
import '../../features/merchant/subscription/presentation/manager/merchant_subscription_cubit.dart';
import '../../features/merchant/subscription/presentation/manager/merchant_subscription_requests_cubit.dart';
import '../../features/merchant/broadcast/data/apis/merchant_broadcast_api.dart';
import '../../features/merchant/broadcast/data/repos/merchant_broadcast_repo.dart';
import '../../features/merchant/broadcast/domain/repos/i_merchant_broadcast_repo.dart';
import '../../features/merchant/broadcast/domain/use_cases/get_merchant_broadcasts_use_case.dart';
import '../../features/merchant/broadcast/domain/use_cases/send_merchant_broadcast_use_case.dart';
import '../../features/merchant/broadcast/presentation/manager/merchant_broadcast_cubit.dart';
import '../../features/merchant/broadcast/presentation/manager/merchant_broadcast_list_cubit.dart';
import '../../features/merchant/wallet/data/apis/merchant_wallet_api.dart';
import '../../features/merchant/wallet/data/apis/merchant_wallet_requests_api.dart';
import '../../features/merchant/wallet/data/repos/merchant_wallet_repo.dart';
import '../../features/merchant/wallet/data/repos/merchant_wallet_requests_repo.dart';
import '../../features/merchant/wallet/domain/repos/i_merchant_wallet_repo.dart';
import '../../features/merchant/wallet/domain/repos/i_merchant_wallet_requests_repo.dart';
import '../../features/merchant/wallet/domain/use_cases/get_merchant_wallet_use_case.dart';
import '../../features/merchant/wallet/presentation/manager/merchant_wallet_cubit.dart';
import '../../features/merchant/wallet/presentation/manager/merchant_wallet_requests_cubit.dart';
import '../../features/merchant/wallet/domain/use_cases/get_wallet_requests_use_case.dart'
    as merchant_wallet;
import '../../features/merchant/wallet/domain/use_cases/get_wallet_request_detail_use_case.dart'
    as merchant_wallet;
import '../../features/merchant/wallet/domain/use_cases/create_wallet_request_use_case.dart'
    as merchant_wallet;
import '../../features/merchant/wallet/domain/use_cases/cancel_wallet_request_use_case.dart'
    as merchant_wallet;
import '../../features/merchant/wallet/domain/use_cases/get_wallet_request_attachment_use_case.dart'
    as merchant_wallet;
import '../../features/merchant/wallet/domain/use_cases/get_transfer_accounts_use_case.dart'
    as merchant_wallet;
import '../../features/merchant/wallet/domain/use_cases/get_withdraw_methods_use_case.dart'
    as merchant_wallet;
import '../../features/merchant/wallet/presentation/manager/create_wallet_request_cubit.dart'
    as merchant_wallet;
import '../../features/customer/wallet/data/apis/customer_wallet_api.dart';
import '../../features/customer/wallet/data/apis/customer_wallet_requests_api.dart';
import '../../features/customer/wallet/data/repos/customer_wallet_repo.dart';
import '../../features/customer/wallet/data/repos/customer_wallet_requests_repo.dart';
import '../../features/customer/wallet/domain/repos/i_customer_wallet_repo.dart';
import '../../features/customer/wallet/domain/repos/i_customer_wallet_requests_repo.dart';
import '../../features/customer/wallet/domain/use_cases/get_customer_wallet_use_case.dart';
import '../../features/customer/wallet/presentation/manager/customer_wallet_cubit.dart';
import '../../features/customer/wallet/presentation/manager/customer_wallet_requests_cubit.dart';
import '../../features/customer/wallet/domain/use_cases/get_wallet_requests_use_case.dart'
    as customer_wallet;
import '../../features/customer/wallet/domain/use_cases/get_wallet_request_detail_use_case.dart'
    as customer_wallet;
import '../../features/customer/wallet/domain/use_cases/create_wallet_request_use_case.dart'
    as customer_wallet;
import '../../features/customer/wallet/domain/use_cases/cancel_wallet_request_use_case.dart'
    as customer_wallet;
import '../../features/customer/wallet/domain/use_cases/get_wallet_request_attachment_use_case.dart'
    as customer_wallet;
import '../../features/customer/wallet/domain/use_cases/get_transfer_accounts_use_case.dart'
    as customer_wallet;
import '../../features/customer/wallet/domain/use_cases/get_withdraw_methods_use_case.dart'
    as customer_wallet;
import '../../features/customer/wallet/presentation/manager/create_wallet_request_cubit.dart'
    as customer_wallet;
import '../../features/customer/ratings/data/apis/customer_ratings_api.dart';
import '../../features/customer/ratings/data/repos/customer_ratings_repo.dart';
import '../../features/customer/ratings/domain/repos/i_customer_ratings_repo.dart';
import '../../features/customer/ratings/domain/use_cases/get_customer_ratings_use_case.dart';
import '../../features/customer/ratings/presentation/manager/customer_ratings_cubit.dart';
import '../../features/barber/bookings/data/apis/barber_booking_api.dart';
import '../../features/barber/bookings/data/repos/barber_booking_repo.dart';
import '../../features/barber/bookings/domain/repos/i_barber_booking_repo.dart';
import '../../features/barber/bookings/domain/use_cases/advance_booking_status_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/confirm_booking_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/create_walk_in_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/update_booking_billing_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/get_booking_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/get_bookings_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/get_pending_bookings_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/get_queue_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/get_unresolved_bookings_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/get_walk_in_options_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/reject_booking_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/settle_bookings_use_case.dart';
import '../../features/barber/bookings/presentation/manager/bookings_cubit.dart';
import '../../features/barber/bookings/presentation/manager/unresolved_bookings_cubit.dart';
import '../../features/barber/bookings/presentation/manager/walk_in_options_cubit.dart';
import '../../features/barber/team/data/apis/barber_earnings_api.dart';
import '../../features/barber/team/data/apis/barber_team_api.dart';
import '../../features/barber/team/data/apis/barber_team_hours_api.dart';
import '../../features/barber/team/data/apis/barber_team_services_api.dart';
import '../../features/barber/team/data/repos/barber_earnings_repo.dart';
import '../../features/barber/team/data/repos/barber_team_repo.dart';
import '../../features/barber/team/data/repos/barber_team_hours_repo.dart';
import '../../features/barber/team/data/repos/barber_team_services_repo.dart';
import '../../features/barber/team/domain/repos/i_barber_earnings_repo.dart';
import '../../features/barber/team/domain/repos/i_barber_team_repo.dart';
import '../../features/barber/team/domain/repos/i_barber_team_hours_repo.dart';
import '../../features/barber/team/domain/repos/i_barber_team_services_repo.dart';
import '../../features/barber/team/domain/use_cases/activate_team_member_use_case.dart';
import '../../features/barber/team/domain/use_cases/add_team_member_use_case.dart';
import '../../features/barber/team/domain/use_cases/block_team_member_use_case.dart';
import '../../features/barber/team/domain/use_cases/delete_team_member_permanently_use_case.dart';
import '../../features/barber/team/domain/use_cases/create_member_service_use_case.dart';
import '../../features/barber/team/domain/use_cases/delete_member_service_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_earnings_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_member_clients_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_member_earnings_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_member_hours_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_member_service_catalog_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_member_services_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_team_member_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_team_use_case.dart';
import '../../features/barber/team/domain/use_cases/set_member_availability_use_case.dart';
import '../../features/barber/team/domain/use_cases/update_member_hours_use_case.dart';
import '../../features/barber/team/domain/use_cases/update_member_service_use_case.dart';
import '../../features/barber/team/domain/use_cases/update_team_member_use_case.dart';
import '../../features/barber/team/presentation/manager/barber_team_cubit.dart';
import '../../features/barber/team/presentation/manager/earnings_cubit.dart';
import '../../features/barber/team/presentation/manager/member_clients_cubit.dart';
import '../../features/barber/team/presentation/manager/member_earnings_cubit.dart';
import '../../features/barber/team/presentation/manager/member_hours_cubit.dart';
import '../../features/barber/team/presentation/manager/member_services_cubit.dart';
import '../../features/barber/team/presentation/manager/team_member_detail_cubit.dart';
import '../../features/barber/notifications/data/apis/barber_notifications_api.dart';
import '../../features/barber/notifications/data/repos/barber_notifications_repo.dart';
import '../../features/barber/notifications/domain/repos/i_barber_notifications_repo.dart';
import '../../features/barber/notifications/domain/use_cases/get_notifications_use_case.dart'
    as barber;
import '../../features/barber/notifications/domain/use_cases/get_unseen_notifications_count_use_case.dart'
    as barber;
import '../../features/barber/notifications/domain/use_cases/mark_all_notifications_seen_use_case.dart'
    as barber;
import '../../features/barber/notifications/domain/use_cases/mark_notification_clicked_use_case.dart'
    as barber;
import '../../features/barber/notifications/presentation/manager/barber_notifications_cubit.dart';
import '../../features/barber/notifications/presentation/services/barber_notification_router.dart';
import '../../features/barber/device_token/data/apis/barber_device_token_api.dart';
import '../../features/barber/device_token/data/repos/barber_device_token_repo.dart';
import '../../features/barber/device_token/domain/repos/i_barber_device_token_repo.dart';
import '../../features/barber/device_token/domain/use_cases/register_device_token_use_case.dart'
    as barber;
import '../../features/barber/device_token/domain/use_cases/unregister_all_device_tokens_use_case.dart'
    as barber;
import '../../features/barber/device_token/presentation/services/barber_device_token_sync_service.dart';
import '../../features/merchant/auth/data/apis/merchant_auth_api.dart';
import '../../shared/auth/data/local/auth_local_data_source.dart';
import '../../features/merchant/auth/data/repos/merchant_auth_repo.dart';
import '../../features/merchant/auth/domain/repos/i_merchant_auth_repo.dart';
import '../../features/merchant/auth/domain/use_cases/merchant_login_use_case.dart';
import '../../features/merchant/auth/domain/use_cases/merchant_logout_use_case.dart';
import '../../features/merchant/auth/domain/use_cases/merchant_register_use_case.dart';
import '../../features/merchant/auth/domain/use_cases/resend_merchant_register_otp_use_case.dart';
import '../../features/merchant/auth/domain/use_cases/verify_merchant_register_otp_use_case.dart';
import '../../features/merchant/auth/domain/use_cases/forgot_merchant_password_use_case.dart';
import '../../features/merchant/auth/domain/use_cases/verify_merchant_password_otp_use_case.dart';
import '../../features/merchant/auth/domain/use_cases/reset_merchant_password_use_case.dart';
import '../../features/merchant/auth/presentation/manager/merchant_auth_cubit.dart';
import '../../features/merchant/categories/data/apis/merchant_categories_api.dart';
import '../../features/merchant/categories/data/repos/merchant_categories_repo.dart';
import '../../features/merchant/categories/domain/repos/i_merchant_categories_repo.dart';
import '../../features/merchant/categories/domain/use_cases/create_category_use_case.dart';
import '../../features/merchant/categories/domain/use_cases/delete_category_use_case.dart';
import '../../features/merchant/categories/domain/use_cases/get_assignable_categories_use_case.dart';
import '../../features/merchant/categories/domain/use_cases/update_category_use_case.dart';
import '../../features/merchant/categories/presentation/manager/merchant_categories_cubit.dart';
import '../../features/merchant/documents/data/apis/merchant_documents_api.dart';
import '../../features/merchant/documents/data/repos/merchant_documents_repo.dart';
import '../../features/merchant/documents/domain/repos/i_merchant_documents_repo.dart';
import '../../features/merchant/documents/domain/use_cases/delete_document_file_use_case.dart';
import '../../features/merchant/documents/domain/use_cases/download_document_file_use_case.dart';
import '../../features/merchant/documents/domain/use_cases/get_documents_use_case.dart';
import '../../features/merchant/documents/domain/use_cases/upload_document_file_use_case.dart';
import '../../features/merchant/documents/presentation/manager/merchant_documents_cubit.dart';
import '../../features/merchant/dashboard/data/apis/merchant_dashboard_api.dart';
import '../../features/merchant/dashboard/data/repos/merchant_dashboard_repo.dart';
import '../../features/merchant/dashboard/domain/repos/i_merchant_dashboard_repo.dart';
import '../../features/merchant/dashboard/domain/use_cases/get_dashboard_use_case.dart';
import '../../features/merchant/dashboard/presentation/manager/merchant_dashboard_cubit.dart';
import '../../features/merchant/delivery/data/apis/merchant_delivery_api.dart';
import '../../features/merchant/delivery/data/repos/merchant_delivery_repo.dart';
import '../../features/merchant/delivery/domain/repos/i_merchant_delivery_repo.dart';
import '../../features/merchant/delivery/domain/use_cases/get_delivery_use_case.dart';
import '../../features/merchant/delivery/domain/use_cases/update_delivery_use_case.dart';
import '../../features/merchant/delivery/presentation/manager/merchant_delivery_cubit.dart';
import '../../features/merchant/customers/data/apis/merchant_customers_api.dart';
import '../../features/merchant/customers/data/repos/merchant_customers_repo.dart';
import '../../features/merchant/customers/domain/repos/i_merchant_customers_repo.dart';
import '../../features/merchant/customers/domain/use_cases/get_merchant_customers_use_case.dart';
import '../../features/merchant/customers/presentation/manager/merchant_customers_cubit.dart';
import '../../features/merchant/discounts/data/apis/merchant_discounts_api.dart';
import '../../features/merchant/discounts/data/repos/merchant_discounts_repo.dart';
import '../../features/merchant/discounts/domain/repos/i_merchant_discounts_repo.dart';
import '../../features/merchant/discounts/domain/use_cases/close_discount_use_case.dart';
import '../../features/merchant/discounts/domain/use_cases/quote_discount_use_case.dart';
import '../../features/merchant/discounts/presentation/manager/discount_quote_cubit.dart';
import '../../features/merchant/discounts/domain/use_cases/create_discount_use_case.dart';
import '../../features/merchant/discounts/domain/use_cases/get_discount_by_id_use_case.dart';
import '../../features/merchant/discounts/domain/use_cases/get_discount_shops_use_case.dart';
import '../../features/merchant/discounts/domain/use_cases/get_discounts_use_case.dart';
import '../../features/merchant/discounts/domain/use_cases/update_discount_use_case.dart';
import '../../features/merchant/discounts/presentation/manager/merchant_discounts_cubit.dart';
import '../../features/merchant/orders/data/apis/merchant_orders_api.dart';
import '../../features/merchant/orders/data/repos/merchant_orders_repo.dart';
import '../../features/merchant/orders/domain/repos/i_merchant_orders_repo.dart';
import '../../features/merchant/orders/domain/use_cases/accept_order_use_case.dart';
import '../../features/merchant/orders/domain/use_cases/advance_order_status_use_case.dart';
import '../../features/merchant/orders/domain/use_cases/get_order_use_case.dart';
import '../../features/merchant/orders/domain/use_cases/get_orders_use_case.dart';
import '../../features/merchant/orders/domain/use_cases/reject_order_use_case.dart';
import '../../features/merchant/orders/presentation/manager/merchant_orders_cubit.dart';
import '../../features/merchant/products/data/apis/merchant_products_api.dart';
import '../../features/merchant/products/data/repos/merchant_products_repo.dart';
import '../../features/merchant/products/domain/repos/i_merchant_products_repo.dart';
import '../../features/merchant/products/domain/use_cases/create_product_use_case.dart';
import '../../features/merchant/products/domain/use_cases/delete_product_use_case.dart';
import '../../features/merchant/products/domain/use_cases/delete_product_image_use_case.dart';
import '../../features/merchant/products/domain/use_cases/get_products_use_case.dart';
import '../../features/merchant/products/domain/use_cases/set_product_stock_use_case.dart';
import '../../features/merchant/products/domain/use_cases/update_product_use_case.dart';
import '../../features/merchant/products/presentation/manager/merchant_products_cubit.dart';
import '../../features/merchant/profile/data/apis/merchant_profile_api.dart';
import '../../features/merchant/profile/data/repos/merchant_profile_repo.dart';
import '../../features/merchant/profile/domain/repos/i_merchant_profile_repo.dart';
import '../../features/merchant/profile/domain/use_cases/change_password_use_case.dart';
import '../../features/merchant/profile/domain/use_cases/get_merchant_profile_use_case.dart';
import '../../features/merchant/profile/domain/use_cases/update_merchant_location_use_case.dart';
import '../../features/merchant/profile/domain/use_cases/update_merchant_profile_use_case.dart';
import '../../features/merchant/profile/domain/use_cases/add_phone_use_case.dart';
import '../../features/merchant/profile/domain/use_cases/delete_phone_use_case.dart';
import '../../features/merchant/profile/domain/use_cases/get_phones_use_case.dart';
import '../../features/merchant/profile/presentation/manager/merchant_phones_cubit.dart';
import '../../features/merchant/profile/presentation/manager/merchant_profile_cubit.dart';
import '../../features/merchant/notifications/data/apis/merchant_notifications_api.dart';
import '../../features/merchant/notifications/data/repos/merchant_notifications_repo.dart';
import '../../features/merchant/notifications/domain/repos/i_merchant_notifications_repo.dart';
import '../../features/merchant/notifications/domain/use_cases/get_notifications_use_case.dart';
import '../../features/merchant/notifications/domain/use_cases/get_unseen_notifications_count_use_case.dart';
import '../../features/merchant/notifications/domain/use_cases/mark_all_notifications_seen_use_case.dart';
import '../../features/merchant/notifications/domain/use_cases/mark_notification_clicked_use_case.dart';
import '../../features/merchant/notifications/presentation/manager/merchant_notifications_cubit.dart';
import '../../features/merchant/notifications/presentation/services/merchant_notification_router.dart';
import '../../features/merchant/device_token/data/apis/merchant_device_token_api.dart';
import '../../features/merchant/device_token/data/repos/merchant_device_token_repo.dart';
import '../../features/merchant/device_token/domain/repos/i_merchant_device_token_repo.dart';
import '../../features/merchant/device_token/domain/use_cases/register_device_token_use_case.dart';
import '../../features/merchant/device_token/domain/use_cases/unregister_all_device_tokens_use_case.dart';
import '../../features/merchant/device_token/presentation/services/merchant_device_token_sync_service.dart';
import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/secure_storage/secure_storage.dart';
import '../crash_reporting/crashlytics_tool.dart';
import '../crash_reporting/sentry_tool.dart';
import '../crash_reporting/vso_crash_reporting_manager.dart';
import '../notifications/notification_router.dart';
import '../notifications/notification_service.dart';
import '../notifications/user_type_notification_router.dart';
import '../network/dio/dio_factory.dart';
import '../network/dio/network_service.dart';
import '../network/interceptors/authorization_interceptor.dart';
import '../session/session_manager.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    _initFlutterSecureStorage();
    await _initSharedPreferencesStorage();
    _initDioService();
    _initSessionManager();
    _initCrashReporting();
    _support();

    _customerDeviceToken();
    _customerNotifications();
    _customerAuth();
    _customerFavorites();
    _customerProfile();
    _customerShops();
    _customerHomeService();
    _customerBooking();
    _customerStore();
    _customerPaymentMethods();
    _customerWallet();
    _customerWalletRequests();
    _customerRatings();

    _merchantAuth();
    _merchantDashboard();
    _merchantCategories();
    _merchantDocuments();
    _merchantProducts();
    _merchantDiscounts();
    _merchantCustomers();
    _merchantOrders();
    _merchantProfile();
    _merchantDelivery();
    _merchantNotifications();
    _merchantDeviceToken();
    _merchantSubscription();
    _merchantBroadcast();
    _merchantWallet();
    _merchantWalletRequests();

    _barberAuth();
    _barberProfile();
    _barberDrinks();
    _barberDiscounts();
    _barberPaymentMethods();
    _merchantSponsorship();
    _barberSponsorship();
    _barberHours();
    _barberHomeService();
    _barberHomeServiceHours();
    _barberHomeServiceRequests();
    _barberServices();
    _barberDocuments();
    _barberStore();
    _barberStorefrontProducts();
    _barberStorefrontCategories();
    _barberStorefrontDelivery();
    _barberStorefrontOrders();
    _barberWallet();
    _barberWalletRequests();
    _barberMoney();
    _barberReviews();
    _barberInvite();
    _barberSubscription();
    _barberTeam();
    _barberEarnings();
    _barberBookings();
    _barberNotifications();
    _barberDeviceToken();
    _barberBroadcast();

    _initNotificationRouter();
    _initNotificationService();
  }

  void _support() {
    sl.registerLazySingleton(() => SupportApi(sl()));
    sl.registerLazySingleton<ISupportRepo>(() => SupportRepo(sl()));
    sl.registerLazySingleton(() => GetSupportInfoUseCase(sl()));
    sl.registerLazySingleton(() => SupportCubit(sl()));
  }

  void _initCrashReporting() {
    final manager = VSOCrashReportingManager(sl());
    sl.registerLazySingleton<VSOCrashReportingManager>(() => manager);

    manager.registerCrashReportingTool(CrashlyticsTool());
    manager.registerCrashReportingTool(SentryTool());
    manager.initCrashReportingKeys();
  }

  Future<void> _initSharedPreferencesStorage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => PreferencesStorage(sharedPreferences));
  }

  void _initFlutterSecureStorage() {
    const secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
    sl.registerLazySingleton(() => SecureStorage(secureStorage));
  }

  void _initSessionManager() {
    sl.registerLazySingleton(() => SessionManager(sl(), sl()));
  }

  void _initDioService() {
    sl.registerLazySingleton(
      () => AuthorizationInterceptor(
        sl<SecureStorage>(),
        sl<PreferencesStorage>(),
        sl<SessionManager>(),
      ),
    );

    sl.registerLazySingleton(
      () => NetworkService(
        DioFactory.create(sl<AuthorizationInterceptor>(), sl()),
      ),
    );
  }

  void _initNotificationService() {
    final service = NotificationService();
    final navigator = NotificationNavigator();

    service.setNavigator(navigator);
    service.setupNotifications();

    sl.registerSingleton<NotificationNavigator>(navigator);
    sl.registerSingleton<NotificationService>(service);
  }

  void _customerAuth() {
    sl.registerLazySingleton(() => CustomerAuthApi(sl()));
    sl.registerLazySingleton(() => AuthLocalDataSource(sl(), sl()));
    sl.registerLazySingleton<ICustomerAuthRepo>(
      () => CustomerAuthRepo(sl(), sl()),
    );
    sl.registerLazySingleton(() => CustomerLoginUseCase(sl()));
    sl.registerLazySingleton(() => CustomerRegisterUseCase(sl()));
    sl.registerLazySingleton(() => VerifyCustomerRegisterOtpUseCase(sl()));
    sl.registerLazySingleton(() => ResendCustomerRegisterOtpUseCase(sl()));
    sl.registerLazySingleton(() => ForgotCustomerPasswordUseCase(sl()));
    sl.registerLazySingleton(() => VerifyCustomerPasswordOtpUseCase(sl()));
    sl.registerLazySingleton(() => ResetCustomerPasswordUseCase(sl()));
    sl.registerLazySingleton(() => CustomerLogoutUseCase(sl(), sl()));
    sl.registerFactory(
      () => CustomerAuthCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _customerDeviceToken() {
    sl.registerLazySingleton(() => CustomerDeviceTokenApi(sl()));
    sl.registerLazySingleton<ICustomerDeviceTokenRepo>(
      () => CustomerDeviceTokenRepo(sl()),
    );
    sl.registerLazySingleton(() => RegisterCustomerDeviceTokenUseCase(sl()));
    sl.registerLazySingleton(() => UnregisterAllCustomerDeviceTokensUseCase(sl()));
    sl.registerLazySingleton(
      () => CustomerDeviceTokenSyncService(sl(), sl(), sl()),
    );
  }

  void _customerNotifications() {
    sl.registerLazySingleton(() => CustomerNotificationsApi(sl()));
    sl.registerLazySingleton<ICustomerNotificationsRepo>(
      () => CustomerNotificationsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetCustomerNotificationsUseCase(sl()));
    sl.registerLazySingleton(() => GetCustomerUnseenNotificationsCountUseCase(sl()));
    sl.registerLazySingleton(() => MarkAllCustomerNotificationsSeenUseCase(sl()));
    sl.registerLazySingleton(() => MarkCustomerNotificationClickedUseCase(sl()));
    sl.registerLazySingleton(
      () => CustomerNotificationsCubit(sl(), sl(), sl(), sl()),
    );
    sl.registerLazySingleton(() => CustomerNotificationRouter());
  }

  void _customerFavorites() {
    sl.registerLazySingleton(() => CustomerFavoritesApi(sl()));
    sl.registerLazySingleton<ICustomerFavoritesRepo>(
      () => CustomerFavoritesRepo(sl()),
    );
    sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
    sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
    sl.registerLazySingleton(() => RemoveFavoriteUseCase(sl()));
    sl.registerLazySingleton(() => AddFavoriteViaInviteUseCase(sl()));
    sl.registerLazySingleton(() => GetInvitePreviewUseCase(sl()));
    sl.registerFactory(() => FavoritesCubit(sl(), sl()));
    sl.registerFactory(() => InvitePreviewCubit(sl(), sl(), sl()));
  }

  void _customerProfile() {
    sl.registerLazySingleton(() => CustomerProfileApi(sl()));
    sl.registerLazySingleton<ICustomerProfileRepo>(
      () => CustomerProfileRepo(sl(), sl()),
    );
    sl.registerLazySingleton(() => GetCustomerProfileUseCase(sl()));
    sl.registerLazySingleton(() => ChangeCustomerPasswordUseCase(sl()));
    sl.registerLazySingleton(() => DeleteCustomerAccountUseCase(sl()));
    sl.registerFactory(() => CustomerProfileCubit(sl(), sl(), sl()));
  }

  void _customerShops() {
    sl.registerLazySingleton(() => CurrentPositionResolver());
    sl.registerLazySingleton(() => CustomerShopsApi(sl()));
    sl.registerLazySingleton<ICustomerShopsRepo>(
      () => CustomerShopsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetShopsUseCase(sl()));
    sl.registerLazySingleton(() => GetShopDetailUseCase(sl()));
    sl.registerFactory(() => CustomerShopsCubit(sl(), sl()));
    sl.registerFactory(() => CustomerShopDetailCubit(sl(), sl(), sl()));
  }

  void _customerHomeService() {
    sl.registerLazySingleton(() => CustomerHomeServiceApi(sl()));
    sl.registerLazySingleton<ICustomerHomeServiceRepo>(
      () => CustomerHomeServiceRepo(sl()),
    );
    sl.registerLazySingleton(() => GetHomeServiceShopsUseCase(sl()));
    sl.registerLazySingleton(() => GetHomeServiceShopHoursUseCase(sl()));
    sl.registerLazySingleton(() => CreateHomeServiceRequestUseCase(sl()));
    sl.registerLazySingleton(() => GetMyHomeServiceRequestsUseCase(sl()));
    sl.registerLazySingleton(() => GetHomeServiceRequestUseCase(sl()));
    sl.registerLazySingleton(() => ConfirmHomeServicePriceUseCase(sl()));
    sl.registerLazySingleton(() => CancelHomeServiceRequestUseCase(sl()));
    sl.registerFactory(() => HomeServiceShopsCubit(sl(), sl()));
    sl.registerFactory(() => HomeServiceRequestFormCubit(sl()));
    sl.registerFactory(() => HomeServiceRequestsCubit(sl()));
    sl.registerFactory(() => HomeServiceRequestDetailCubit(sl(), sl(), sl()));
  }

  void _customerBooking() {
    sl.registerLazySingleton(() => CustomerBookingApi(sl()));
    sl.registerLazySingleton<ICustomerBookingRepo>(
      () => CustomerBookingRepo(sl()),
    );
    sl.registerLazySingleton(() => GetBookingSlotsUseCase(sl()));
    sl.registerLazySingleton(() => CreateBookingUseCase(sl()));
    sl.registerLazySingleton(() => customer_booking.GetBookingsUseCase(sl()));
    sl.registerLazySingleton(() => customer_booking.GetBookingUseCase(sl()));
    sl.registerLazySingleton(() => CancelBookingUseCase(sl()));
    sl.registerLazySingleton(() => RateBookingUseCase(sl()));
    sl.registerLazySingleton(() => BookingFlowCubit(sl(), sl(), sl()));
    sl.registerFactory(() => MyBookingsCubit(sl()));
    sl.registerFactory(() => BookingDetailCubit(sl(), sl(), sl()));
  }

  void _customerPaymentMethods() {
    sl.registerLazySingleton(() => CustomerPaymentMethodsApi(sl()));
    sl.registerLazySingleton<ICustomerPaymentMethodsRepo>(
      () => CustomerPaymentMethodsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetEnabledPaymentMethodsUseCase(sl()));
    sl.registerLazySingleton(() => PaymentMethodsCubit(sl()));
  }

  void _customerStore() {
    sl.registerLazySingleton(() => CustomerStoreApi(sl()));
    sl.registerLazySingleton<ICustomerStoreRepo>(
      () => CustomerStoreRepo(sl()),
    );
    sl.registerLazySingleton(() => GetStorefrontUseCase(sl()));
    sl.registerLazySingleton(() => customer_store.GetCartUseCase(sl()));
    sl.registerLazySingleton(() => customer_store.PutCartUseCase(sl()));
    sl.registerLazySingleton(() => customer_store.CheckoutCartUseCase(sl()));
    sl.registerLazySingleton(() => customer_store.GetStoreOrdersUseCase(sl()));
    sl.registerLazySingleton(() => customer_store.CancelStoreOrderUseCase(sl()));
    sl.registerFactory(() => StoreCartCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => StoreOrdersCubit(sl(), sl()));
  }

  void _customerWallet() {
    sl.registerLazySingleton(() => CustomerWalletApi(sl()));
    sl.registerLazySingleton<ICustomerWalletRepo>(() => CustomerWalletRepo(sl()));
    sl.registerLazySingleton(() => GetCustomerWalletUseCase(sl()));
    sl.registerFactory(() => CustomerWalletCubit(sl()));
  }

  void _customerWalletRequests() {
    sl.registerLazySingleton(() => CustomerWalletRequestsApi(sl()));
    sl.registerLazySingleton<ICustomerWalletRequestsRepo>(
      () => CustomerWalletRequestsRepo(sl()),
    );
    sl.registerLazySingleton(() => customer_wallet.GetWalletRequestsUseCase(sl()));
    sl.registerLazySingleton(
      () => customer_wallet.GetWalletRequestDetailUseCase(sl()),
    );
    sl.registerLazySingleton(() => customer_wallet.CreateWalletRequestUseCase(sl()));
    sl.registerLazySingleton(() => customer_wallet.CancelWalletRequestUseCase(sl()));
    sl.registerLazySingleton(
      () => customer_wallet.GetWalletRequestAttachmentUseCase(sl()),
    );
    sl.registerLazySingleton(() => customer_wallet.GetTransferAccountsUseCase(sl()));
    sl.registerLazySingleton(() => customer_wallet.GetWithdrawMethodsUseCase(sl()));
    sl.registerFactory(() => CustomerWalletRequestsCubit(sl(), sl()));
    sl.registerFactory(
      () => customer_wallet.CreateWalletRequestCubit(sl(), sl(), sl()),
    );
  }

  void _customerRatings() {
    sl.registerLazySingleton(() => CustomerRatingsApi(sl()));
    sl.registerLazySingleton<ICustomerRatingsRepo>(() => CustomerRatingsRepo(sl()));
    sl.registerLazySingleton(() => GetCustomerRatingsUseCase(sl()));
    sl.registerFactory(() => CustomerRatingsCubit(sl()));
  }

  void _merchantAuth() {
    sl.registerLazySingleton(() => MerchantAuthApi(sl()));
    sl.registerLazySingleton<IMerchantAuthRepo>(
      () => MerchantAuthRepo(sl(), sl()),
    );
    sl.registerLazySingleton(() => MerchantLoginUseCase(sl()));
    sl.registerLazySingleton(() => MerchantRegisterUseCase(sl()));
    sl.registerLazySingleton(() => VerifyMerchantRegisterOtpUseCase(sl()));
    sl.registerLazySingleton(() => ResendMerchantRegisterOtpUseCase(sl()));
    sl.registerLazySingleton(() => ForgotMerchantPasswordUseCase(sl()));
    sl.registerLazySingleton(() => VerifyMerchantPasswordOtpUseCase(sl()));
    sl.registerLazySingleton(() => ResetMerchantPasswordUseCase(sl()));
    sl.registerLazySingleton(() => MerchantLogoutUseCase(sl(), sl()));
    sl.registerFactory(
      () => MerchantAuthCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _merchantDashboard() {
    sl.registerLazySingleton(() => MerchantDashboardApi(sl()));
    sl.registerLazySingleton<IMerchantDashboardRepo>(
      () => MerchantDashboardRepo(sl()),
    );
    sl.registerLazySingleton(() => GetDashboardUseCase(sl()));
    sl.registerFactory(() => MerchantDashboardCubit(sl()));
  }

  void _merchantCategories() {
    sl.registerLazySingleton(() => MerchantCategoriesApi(sl()));
    sl.registerLazySingleton<IMerchantCategoriesRepo>(
      () => MerchantCategoriesRepo(sl()),
    );
    sl.registerLazySingleton(() => GetAssignableCategoriesUseCase(sl()));
    sl.registerLazySingleton(() => CreateCategoryUseCase(sl()));
    sl.registerLazySingleton(() => UpdateCategoryUseCase(sl()));
    sl.registerLazySingleton(() => DeleteCategoryUseCase(sl()));
    sl.registerFactory(
      () => MerchantCategoriesCubit(sl(), sl(), sl(), sl()),
    );
  }

  void _merchantDocuments() {
    sl.registerLazySingleton(() => MerchantDocumentsApi(sl()));
    sl.registerLazySingleton<IMerchantDocumentsRepo>(
      () => MerchantDocumentsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetDocumentsUseCase(sl()));
    sl.registerLazySingleton(() => UploadDocumentFileUseCase(sl()));
    sl.registerLazySingleton(() => DeleteDocumentFileUseCase(sl()));
    sl.registerLazySingleton(() => DownloadDocumentFileUseCase(sl()));
    sl.registerLazySingleton(
      () => MerchantDocumentsCubit(sl(), sl(), sl(), sl()),
    );
  }

  void _merchantProducts() {
    sl.registerLazySingleton(() => MerchantProductsApi(sl()));
    sl.registerLazySingleton<IMerchantProductsRepo>(
      () => MerchantProductsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetProductsUseCase(sl()));
    sl.registerLazySingleton(() => CreateProductUseCase(sl()));
    sl.registerLazySingleton(() => UpdateProductUseCase(sl()));
    sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
    sl.registerLazySingleton(() => SetProductStockUseCase(sl()));
    sl.registerLazySingleton(() => DeleteProductImageUseCase(sl()));
    sl.registerFactory(
      () => MerchantProductsCubit(sl(), sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _merchantDiscounts() {
    sl.registerLazySingleton(() => MerchantDiscountsApi(sl()));
    sl.registerLazySingleton<IMerchantDiscountsRepo>(
      () => MerchantDiscountsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetDiscountsUseCase(sl()));
    sl.registerLazySingleton(() => GetDiscountByIdUseCase(sl()));
    sl.registerLazySingleton(() => GetDiscountShopsUseCase(sl()));
    sl.registerLazySingleton(() => CreateDiscountUseCase(sl()));
    sl.registerLazySingleton(() => UpdateDiscountUseCase(sl()));
    sl.registerLazySingleton(() => CloseDiscountUseCase(sl()));
    sl.registerLazySingleton(() => QuoteDiscountUseCase(sl()));
    sl.registerFactory(() => DiscountQuoteCubit(sl()));
    sl.registerFactory(
      () => MerchantDiscountsCubit(sl(), sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _merchantCustomers() {
    sl.registerLazySingleton(() => MerchantCustomersApi(sl()));
    sl.registerLazySingleton<IMerchantCustomersRepo>(
      () => MerchantCustomersRepo(sl()),
    );
    sl.registerLazySingleton(() => GetMerchantCustomersUseCase(sl()));
    sl.registerFactory(() => MerchantCustomersCubit(sl()));
  }

  void _merchantOrders() {
    sl.registerLazySingleton(() => MerchantOrdersApi(sl()));
    sl.registerLazySingleton<IMerchantOrdersRepo>(
      () => MerchantOrdersRepo(sl()),
    );
    sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
    sl.registerLazySingleton(() => GetOrderUseCase(sl()));
    sl.registerLazySingleton(() => AcceptOrderUseCase(sl()));
    sl.registerLazySingleton(() => RejectOrderUseCase(sl()));
    sl.registerLazySingleton(() => AdvanceOrderStatusUseCase(sl()));
    sl.registerFactory(
      () => MerchantOrdersCubit(sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _merchantProfile() {
    sl.registerLazySingleton(() => MerchantProfileApi(sl()));
    sl.registerLazySingleton<IMerchantProfileRepo>(
      () => MerchantProfileRepo(sl(), sl()),
    );
    sl.registerLazySingleton(() => GetMerchantProfileUseCase(sl()));
    sl.registerLazySingleton(() => UpdateMerchantProfileUseCase(sl()));
    sl.registerLazySingleton(() => UpdateMerchantLocationUseCase(sl()));
    sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
    sl.registerLazySingleton(() => DeleteMerchantAccountUseCase(sl()));
    sl.registerLazySingleton(
      () => MerchantProfileCubit(sl(), sl(), sl(), sl(), sl()),
    );
    sl.registerLazySingleton(() => GetPhonesUseCase(sl()));
    sl.registerLazySingleton(() => AddPhoneUseCase(sl()));
    sl.registerLazySingleton(() => DeletePhoneUseCase(sl()));
    sl.registerFactory(() => MerchantPhonesCubit(sl(), sl(), sl()));
  }

  void _merchantDelivery() {
    sl.registerLazySingleton(() => MerchantDeliveryApi(sl()));
    sl.registerLazySingleton<IMerchantDeliveryRepo>(
      () => MerchantDeliveryRepo(sl()),
    );
    sl.registerLazySingleton(() => GetDeliveryUseCase(sl()));
    sl.registerLazySingleton(() => UpdateDeliveryUseCase(sl()));
    sl.registerFactory(() => MerchantDeliveryCubit(sl(), sl()));
  }

  void _merchantNotifications() {
    sl.registerLazySingleton(() => MerchantNotificationsApi(sl()));
    sl.registerLazySingleton<IMerchantNotificationsRepo>(
      () => MerchantNotificationsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
    sl.registerLazySingleton(() => GetUnseenNotificationsCountUseCase(sl()));
    sl.registerLazySingleton(() => MarkAllNotificationsSeenUseCase(sl()));
    sl.registerLazySingleton(() => MarkNotificationClickedUseCase(sl()));
    sl.registerLazySingleton(
      () => MerchantNotificationsCubit(sl(), sl(), sl(), sl()),
    );
  }

  void _merchantDeviceToken() {
    sl.registerLazySingleton(() => MerchantDeviceTokenApi(sl()));
    sl.registerLazySingleton<IMerchantDeviceTokenRepo>(
      () => MerchantDeviceTokenRepo(sl()),
    );
    sl.registerLazySingleton(() => RegisterDeviceTokenUseCase(sl()));
    sl.registerLazySingleton(() => UnregisterAllDeviceTokensUseCase(sl()));
    sl.registerLazySingleton(
      () => MerchantDeviceTokenSyncService(sl(), sl(), sl()),
    );
  }

  void _merchantSponsorship() {
    sl.registerLazySingleton(() => MerchantSponsorshipApi(sl()));
    sl.registerLazySingleton<IMerchantSponsorshipRepo>(
      () => MerchantSponsorshipRepo(sl()),
    );
    sl.registerLazySingleton(() => GetMerchantSponsorshipUseCase(sl()));
    sl.registerLazySingleton(() => BuyMerchantSponsorshipUseCase(sl()));
    sl.registerFactory(() => MerchantSponsorshipCubit(sl(), sl()));
  }

  void _barberSponsorship() {
    sl.registerLazySingleton(() => BarberSponsorshipApi(sl()));
    sl.registerLazySingleton<IBarberSponsorshipRepo>(
      () => BarberSponsorshipRepo(sl()),
    );
    sl.registerLazySingleton(() => GetBarberSponsorshipUseCase(sl()));
    sl.registerLazySingleton(() => BuyBarberSponsorshipUseCase(sl()));
    sl.registerFactory(() => BarberSponsorshipCubit(sl(), sl()));
  }

  void _merchantSubscription() {
    sl.registerLazySingleton(() => MerchantSubscriptionApi(sl()));
    sl.registerLazySingleton<IMerchantSubscriptionRepo>(
      () => MerchantSubscriptionRepo(sl()),
    );
    sl.registerLazySingleton(() => GetMerchantSubscriptionUseCase(sl()));
    sl.registerLazySingleton(() => GetMerchantSubscriptionPlansUseCase(sl()));
    sl.registerLazySingleton(() => SubscribeMerchantUseCase(sl()));
    sl.registerLazySingleton(() => GetMerchantSubscriptionRequestsUseCase(sl()));
    sl.registerFactory(() => MerchantSubscriptionCubit(sl(), sl(), sl()));
    sl.registerFactory(() => MerchantSubscriptionRequestsCubit(sl()));
  }

  void _merchantBroadcast() {
    sl.registerLazySingleton(() => MerchantBroadcastApi(sl()));
    sl.registerLazySingleton<IMerchantBroadcastRepo>(
      () => MerchantBroadcastRepo(sl()),
    );
    sl.registerLazySingleton(() => SendMerchantBroadcastUseCase(sl()));
    sl.registerLazySingleton(() => GetMerchantBroadcastsUseCase(sl()));
    sl.registerFactory(() => MerchantBroadcastCubit(sl()));
    sl.registerFactory(() => MerchantBroadcastListCubit(sl()));
  }

  void _merchantWallet() {
    sl.registerLazySingleton(() => MerchantWalletApi(sl()));
    sl.registerLazySingleton<IMerchantWalletRepo>(
      () => MerchantWalletRepo(sl()),
    );
    sl.registerLazySingleton(() => GetMerchantWalletUseCase(sl()));
    sl.registerFactory(() => MerchantWalletCubit(sl()));
  }

  void _merchantWalletRequests() {
    sl.registerLazySingleton(() => MerchantWalletRequestsApi(sl()));
    sl.registerLazySingleton<IMerchantWalletRequestsRepo>(
      () => MerchantWalletRequestsRepo(sl()),
    );
    sl.registerLazySingleton(() => merchant_wallet.GetWalletRequestsUseCase(sl()));
    sl.registerLazySingleton(
      () => merchant_wallet.GetWalletRequestDetailUseCase(sl()),
    );
    sl.registerLazySingleton(() => merchant_wallet.CreateWalletRequestUseCase(sl()));
    sl.registerLazySingleton(() => merchant_wallet.CancelWalletRequestUseCase(sl()));
    sl.registerLazySingleton(
      () => merchant_wallet.GetWalletRequestAttachmentUseCase(sl()),
    );
    sl.registerLazySingleton(() => merchant_wallet.GetTransferAccountsUseCase(sl()));
    sl.registerLazySingleton(() => merchant_wallet.GetWithdrawMethodsUseCase(sl()));
    sl.registerFactory(() => MerchantWalletRequestsCubit(sl(), sl(), sl()));
    sl.registerFactory(
      () => merchant_wallet.CreateWalletRequestCubit(sl(), sl(), sl()),
    );
  }

  void _initNotificationRouter() {
    sl.registerLazySingleton<MerchantNotificationRouter>(
      () => MerchantNotificationRouter(),
    );
    sl.registerLazySingleton<BarberNotificationRouter>(
      () => BarberNotificationRouter(),
    );
    sl.registerLazySingleton<NotificationRouter>(
      () => UserTypeNotificationRouter(),
    );
  }

  void _barberAuth() {
    sl.registerLazySingleton(() => BarberAuthApi(sl()));
    sl.registerLazySingleton<IBarberAuthRepo>(
      () => BarberAuthRepo(sl(), sl()),
    );
    sl.registerLazySingleton(() => BarberLoginUseCase(sl()));
    sl.registerLazySingleton(() => BarberRegisterUseCase(sl()));
    sl.registerLazySingleton(() => VerifyBarberRegisterOtpUseCase(sl()));
    sl.registerLazySingleton(() => ResendBarberRegisterOtpUseCase(sl()));
    sl.registerLazySingleton(() => ForgotBarberPasswordUseCase(sl()));
    sl.registerLazySingleton(() => VerifyBarberPasswordOtpUseCase(sl()));
    sl.registerLazySingleton(() => ResetBarberPasswordUseCase(sl()));
    sl.registerLazySingleton(() => BarberLogoutUseCase(sl(), sl()));
    sl.registerFactory(
      () => BarberAuthCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _barberProfile() {
    sl.registerLazySingleton(() => BarberProfileApi(sl()));
    sl.registerLazySingleton<IBarberProfileRepo>(
      () => BarberProfileRepo(sl(), sl()),
    );
    sl.registerLazySingleton(() => GetBarberProfileUseCase(sl()));
    sl.registerLazySingleton(() => UpdateBarberLocationUseCase(sl()));
    sl.registerLazySingleton(() => UpdateServesClientsUseCase(sl()));
    sl.registerLazySingleton(() => ChangeBarberPasswordUseCase(sl()));
    sl.registerLazySingleton(() => DeleteBarberAccountUseCase(sl()));
    sl.registerFactory(() => BarberProfileCubit(sl(), sl(), sl(), sl(), sl()));
  }

  void _barberPaymentMethods() {
    sl.registerLazySingleton(() => BarberPaymentMethodsApi(sl()));
    sl.registerLazySingleton<IBarberPaymentMethodsRepo>(
      () => BarberPaymentMethodsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetBarberPaymentMethodsUseCase(sl()));
    sl.registerFactory(() => BarberPaymentMethodsCubit(sl()));
  }

  void _barberDrinks() {
    sl.registerLazySingleton(() => BarberDrinksApi(sl()));
    sl.registerLazySingleton<IBarberDrinksRepo>(() => BarberDrinksRepo(sl()));
    sl.registerLazySingleton(() => GetDrinksUseCase(sl()));
    sl.registerLazySingleton(() => CreateDrinkUseCase(sl()));
    sl.registerLazySingleton(() => UpdateDrinkUseCase(sl()));
    sl.registerLazySingleton(() => DeleteDrinkUseCase(sl()));
    sl.registerFactory(() => BarberDrinksCubit(sl(), sl(), sl(), sl()));
  }

  void _barberDiscounts() {
    sl.registerLazySingleton(() => BarberDiscountsApi(sl()));
    sl.registerLazySingleton<IBarberDiscountsRepo>(() => BarberDiscountsRepo(sl()));
    sl.registerLazySingleton(() => GetBarberDiscountsUseCase(sl()));
    sl.registerLazySingleton(() => GetBarberDiscountByIdUseCase(sl()));
    sl.registerLazySingleton(() => CreateBarberDiscountUseCase(sl()));
    sl.registerLazySingleton(() => UpdateBarberDiscountUseCase(sl()));
    sl.registerLazySingleton(() => CloseBarberDiscountUseCase(sl()));
    sl.registerFactory(
      () => BarberDiscountsCubit(sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _barberHours() {
    sl.registerLazySingleton(() => BarberHoursApi(sl()));
    sl.registerLazySingleton<IBarberHoursRepo>(() => BarberHoursRepo(sl()));
    sl.registerLazySingleton(() => GetBarberHoursUseCase(sl()));
    sl.registerLazySingleton(() => UpdateBarberHoursUseCase(sl()));
    sl.registerFactory(() => BarberHoursCubit(sl(), sl()));
  }

  void _barberHomeService() {
    sl.registerLazySingleton(() => BarberHomeServiceApi(sl()));
    sl.registerLazySingleton<IBarberHomeServiceRepo>(
      () => BarberHomeServiceRepo(sl()),
    );
    sl.registerLazySingleton(() => GetHomeServiceSettingsUseCase(sl()));
    sl.registerLazySingleton(() => UpdateHomeServiceSettingsUseCase(sl()));
    sl.registerFactory(() => HomeServiceSettingsCubit(sl(), sl()));
  }

  void _barberHomeServiceRequests() {
    sl.registerLazySingleton(() => BarberHomeServiceRequestApi(sl()));
    sl.registerLazySingleton<IBarberHomeServiceRequestRepo>(
      () => BarberHomeServiceRequestRepo(sl()),
    );
    sl.registerLazySingleton(() => barber_hsr.GetHomeServiceRequestsUseCase(sl()));
    sl.registerLazySingleton(() => barber_hsr.GetHomeServiceRequestUseCase(sl()));
    sl.registerLazySingleton(() => UpdateHomeServiceRequestPriceUseCase(sl()));
    sl.registerLazySingleton(() => AcceptHomeServiceRequestUseCase(sl()));
    sl.registerLazySingleton(() => RejectHomeServiceRequestUseCase(sl()));
    sl.registerLazySingleton(() => UpdateHomeServiceRequestStatusUseCase(sl()));
    sl.registerFactory(
      () => barber_hsr.HomeServiceRequestsCubit(sl(), sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _barberHomeServiceHours() {
    sl.registerLazySingleton(() => BarberHomeServiceHoursApi(sl()));
    sl.registerLazySingleton<IBarberHomeServiceHoursRepo>(
      () => BarberHomeServiceHoursRepo(sl()),
    );
    sl.registerLazySingleton(() => GetHomeServiceHoursUseCase(sl()));
    sl.registerLazySingleton(() => UpdateHomeServiceHoursUseCase(sl()));
    sl.registerFactory(() => HomeServiceHoursCubit(sl(), sl()));
  }

  void _barberServices() {
    sl.registerLazySingleton(() => BarberServicesApi(sl()));
    sl.registerLazySingleton<IBarberServicesRepo>(
      () => BarberServicesRepo(sl()),
    );
    sl.registerLazySingleton(() => GetServiceCatalogUseCase(sl()));
    sl.registerLazySingleton(() => GetBarberServicesUseCase(sl()));
    sl.registerLazySingleton(() => CreateBarberServiceUseCase(sl()));
    sl.registerLazySingleton(() => UpdateBarberServiceUseCase(sl()));
    sl.registerLazySingleton(() => DeleteBarberServiceUseCase(sl()));
    sl.registerLazySingleton(() => GetOwnServicesUseCase(sl()));
    sl.registerLazySingleton(() => CreateOwnServiceUseCase(sl()));
    sl.registerLazySingleton(() => DeleteOwnServiceUseCase(sl()));
    sl.registerFactory(
      () => BarberServicesCubit(sl(), sl(), sl(), sl(), sl()),
    );
    sl.registerFactory(() => OwnServicesCubit(sl(), sl(), sl()));
  }

  void _barberDocuments() {
    sl.registerLazySingleton(() => BarberDocumentsApi(sl()));
    sl.registerLazySingleton<IBarberDocumentsRepo>(
      () => BarberDocumentsRepo(sl()),
    );
    sl.registerLazySingleton(() => barber.GetDocumentsUseCase(sl()));
    sl.registerLazySingleton(() => barber.UploadDocumentFileUseCase(sl()));
    sl.registerLazySingleton(() => barber.DeleteDocumentFileUseCase(sl()));
    sl.registerLazySingleton(() => barber.DownloadDocumentFileUseCase(sl()));
    sl.registerLazySingleton(
      () => BarberDocumentsCubit(sl(), sl(), sl(), sl()),
    );
  }

  void _barberStore() {
    sl.registerLazySingleton(() => BarberStoreApi(sl()));
    sl.registerLazySingleton<IBarberStoreRepo>(() => BarberStoreRepo(sl()));
    sl.registerLazySingleton(() => GetStoreMerchantsUseCase(sl()));
    sl.registerLazySingleton(() => GetMerchantProductsUseCase(sl()));
    sl.registerLazySingleton(() => GetCartUseCase(sl()));
    sl.registerLazySingleton(() => PutCartUseCase(sl()));
    sl.registerLazySingleton(() => GetQuoteUseCase(sl()));
    sl.registerLazySingleton(() => CheckoutCartUseCase(sl()));
    sl.registerLazySingleton(() => GetStoreOrdersUseCase(sl()));
    sl.registerLazySingleton(() => GetStoreOrderUseCase(sl()));
    sl.registerLazySingleton(() => CancelStoreOrderUseCase(sl()));
    sl.registerFactory(() => BarberStoreMerchantsCubit(sl()));
    sl.registerFactory(
      () => BarberStoreCartCubit(sl(), sl(), sl(), sl(), sl()),
    );
    sl.registerFactory(() => BarberStoreOrdersCubit(sl(), sl(), sl()));
  }

  void _barberStorefrontProducts() {
    sl.registerLazySingleton(() => BarberStorefrontProductsApi(sl()));
    sl.registerLazySingleton<IBarberStorefrontProductsRepo>(
      () => BarberStorefrontProductsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetStorefrontProductsUseCase(sl()));
    sl.registerLazySingleton(() => CreateStorefrontProductUseCase(sl()));
    sl.registerLazySingleton(() => UpdateStorefrontProductUseCase(sl()));
    sl.registerLazySingleton(() => DeleteStorefrontProductUseCase(sl()));
    sl.registerLazySingleton(() => SetStorefrontProductStockUseCase(sl()));
    sl.registerFactory(
      () => BarberStorefrontProductsCubit(sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _barberStorefrontCategories() {
    sl.registerLazySingleton(() => BarberStorefrontCategoriesApi(sl()));
    sl.registerLazySingleton<IBarberStorefrontCategoriesRepo>(
      () => BarberStorefrontCategoriesRepo(sl()),
    );
    sl.registerLazySingleton(
      () => GetAssignableStorefrontCategoriesUseCase(sl()),
    );
    sl.registerLazySingleton(() => GetOwnStorefrontCategoriesUseCase(sl()));
    sl.registerLazySingleton(() => CreateStorefrontCategoryUseCase(sl()));
    sl.registerLazySingleton(() => UpdateStorefrontCategoryUseCase(sl()));
    sl.registerLazySingleton(() => DeleteStorefrontCategoryUseCase(sl()));
    sl.registerFactory(
      () => BarberStorefrontCategoriesCubit(sl(), sl(), sl(), sl()),
    );
  }

  void _barberStorefrontDelivery() {
    sl.registerLazySingleton(() => BarberStorefrontDeliveryApi(sl()));
    sl.registerLazySingleton<IBarberStorefrontDeliveryRepo>(
      () => BarberStorefrontDeliveryRepo(sl()),
    );
    sl.registerLazySingleton(() => GetStorefrontDeliveryUseCase(sl()));
    sl.registerLazySingleton(() => UpdateStorefrontDeliveryUseCase(sl()));
    sl.registerFactory(() => BarberStorefrontDeliveryCubit(sl(), sl()));
  }

  void _barberStorefrontOrders() {
    sl.registerLazySingleton(() => BarberStorefrontOrdersApi(sl()));
    sl.registerLazySingleton<IBarberStorefrontOrdersRepo>(
      () => BarberStorefrontOrdersRepo(sl()),
    );
    sl.registerLazySingleton(() => GetStorefrontOrdersUseCase(sl()));
    sl.registerLazySingleton(() => GetStorefrontOrderUseCase(sl()));
    sl.registerLazySingleton(() => AcceptStorefrontOrderUseCase(sl()));
    sl.registerLazySingleton(() => RejectStorefrontOrderUseCase(sl()));
    sl.registerLazySingleton(() => AdvanceStorefrontOrderStatusUseCase(sl()));
    sl.registerFactory(
      () => BarberStorefrontOrdersCubit(sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _barberWallet() {
    sl.registerLazySingleton(() => BarberWalletApi(sl()));
    sl.registerLazySingleton<IBarberWalletRepo>(() => BarberWalletRepo(sl()));
    sl.registerLazySingleton(() => GetBarberWalletUseCase(sl()));
    sl.registerFactory(() => BarberWalletCubit(sl()));
  }

  void _barberWalletRequests() {
    sl.registerLazySingleton(() => BarberWalletRequestsApi(sl()));
    sl.registerLazySingleton<IBarberWalletRequestsRepo>(
      () => BarberWalletRequestsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetWalletRequestsUseCase(sl()));
    sl.registerLazySingleton(() => GetWalletRequestDetailUseCase(sl()));
    sl.registerLazySingleton(() => CreateWalletRequestUseCase(sl()));
    sl.registerLazySingleton(() => CancelWalletRequestUseCase(sl()));
    sl.registerLazySingleton(() => GetWalletRequestAttachmentUseCase(sl()));
    sl.registerLazySingleton(() => GetTransferAccountsUseCase(sl()));
    sl.registerLazySingleton(() => GetWithdrawMethodsUseCase(sl()));
    sl.registerFactory(() => BarberWalletRequestsCubit(sl(), sl()));
    sl.registerFactory(() => CreateWalletRequestCubit(sl(), sl(), sl()));
  }

  void _barberMoney() {
    sl.registerLazySingleton(() => BarberMoneyApi(sl()));
    sl.registerLazySingleton(() => BarberMoneyPinApi(sl()));
    sl.registerLazySingleton<IBarberMoneyRepo>(() => BarberMoneyRepo(sl()));
    sl.registerLazySingleton<IBarberMoneyPinRepo>(() => BarberMoneyPinRepo(sl()));

    sl.registerLazySingleton(() => GetMoneyItemsUseCase(sl()));
    sl.registerLazySingleton(() => CreateMoneyItemUseCase(sl()));
    sl.registerLazySingleton(() => UpdateMoneyItemUseCase(sl()));
    sl.registerLazySingleton(() => DeleteMoneyItemUseCase(sl()));
    sl.registerLazySingleton(() => GetMoneyEntriesUseCase(sl()));
    sl.registerLazySingleton(() => CreateMoneyEntryUseCase(sl()));
    sl.registerLazySingleton(() => GetMoneySummaryUseCase(sl()));
    sl.registerLazySingleton(() => GetPendingOccurrencesUseCase(sl()));
    sl.registerLazySingleton(() => ConfirmOccurrenceUseCase(sl()));
    sl.registerLazySingleton(() => DismissOccurrenceUseCase(sl()));
    sl.registerLazySingleton(() => CheckMoneyPinUseCase(sl()));
    sl.registerLazySingleton(() => SetupMoneyPinUseCase(sl()));
    sl.registerLazySingleton(() => VerifyMoneyPinUseCase(sl()));
    sl.registerLazySingleton(() => ChangeMoneyPinUseCase(sl()));
    sl.registerLazySingleton(() => GetMoneyPinResetStatusUseCase(sl()));
    sl.registerLazySingleton(() => RequestMoneyPinResetUseCase(sl()));

    sl.registerFactory(
      () => MoneyPinCubit(sl(), sl(), sl(), sl(), sl(), sl()),
    );
    sl.registerFactory(() => MoneyHomeCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => MoneyItemsCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => MoneyEntriesCubit(sl(), sl()));
  }

  void _barberReviews() {
    sl.registerLazySingleton(() => BarberReviewsApi(sl()));
    sl.registerLazySingleton<IBarberReviewsRepo>(() => BarberReviewsRepo(sl()));
    sl.registerLazySingleton(() => GetBarberReviewsUseCase(sl()));
    sl.registerFactory(() => BarberReviewsCubit(sl()));
  }

  void _barberInvite() {
    sl.registerLazySingleton(() => BarberInviteApi(sl()));
    sl.registerLazySingleton<IBarberInviteRepo>(() => BarberInviteRepo(sl()));
    sl.registerLazySingleton(() => GetBarberInviteUseCase(sl()));
    sl.registerLazySingleton(() => RegenerateBarberInviteUseCase(sl()));
    sl.registerFactory(() => BarberInviteCubit(sl(), sl()));
  }

  void _barberSubscription() {
    sl.registerLazySingleton(() => BarberSubscriptionApi(sl()));
    sl.registerLazySingleton<IBarberSubscriptionRepo>(
      () => BarberSubscriptionRepo(sl()),
    );
    sl.registerLazySingleton(() => GetBarberSubscriptionUseCase(sl()));
    sl.registerLazySingleton(() => GetBarberSubscriptionPlansUseCase(sl()));
    sl.registerLazySingleton(() => SubscribeBarberUseCase(sl()));
    sl.registerLazySingleton(() => GetBarberSubscriptionRequestsUseCase(sl()));
    sl.registerFactory(() => BarberSubscriptionCubit(sl(), sl(), sl()));
    sl.registerFactory(() => BarberSubscriptionRequestsCubit(sl()));
  }

  void _barberTeam() {
    sl.registerLazySingleton(() => BarberTeamApi(sl()));
    sl.registerLazySingleton<IBarberTeamRepo>(() => BarberTeamRepo(sl()));
    sl.registerLazySingleton(() => GetTeamUseCase(sl()));
    sl.registerLazySingleton(() => AddTeamMemberUseCase(sl()));
    sl.registerLazySingleton(() => GetTeamMemberUseCase(sl()));
    sl.registerLazySingleton(() => UpdateTeamMemberUseCase(sl()));
    sl.registerLazySingleton(() => SetMemberAvailabilityUseCase(sl()));
    sl.registerLazySingleton(() => BlockTeamMemberUseCase(sl()));
    sl.registerLazySingleton(() => ActivateTeamMemberUseCase(sl()));
    sl.registerLazySingleton(() => DeleteTeamMemberPermanentlyUseCase(sl()));
    sl.registerFactory(() => BarberTeamCubit(sl(), sl()));
    sl.registerFactory(
      () => TeamMemberDetailCubit(sl(), sl(), sl(), sl(), sl(), sl()),
    );

    sl.registerLazySingleton(() => BarberTeamHoursApi(sl()));
    sl.registerLazySingleton<IBarberTeamHoursRepo>(
      () => BarberTeamHoursRepo(sl()),
    );
    sl.registerLazySingleton(() => GetMemberHoursUseCase(sl()));
    sl.registerLazySingleton(() => UpdateMemberHoursUseCase(sl()));
    sl.registerFactory(() => MemberHoursCubit(sl(), sl()));

    sl.registerLazySingleton(() => BarberTeamServicesApi(sl()));
    sl.registerLazySingleton<IBarberTeamServicesRepo>(
      () => BarberTeamServicesRepo(sl()),
    );
    sl.registerLazySingleton(() => GetMemberServiceCatalogUseCase(sl()));
    sl.registerLazySingleton(() => GetMemberServicesUseCase(sl()));
    sl.registerLazySingleton(() => CreateMemberServiceUseCase(sl()));
    sl.registerLazySingleton(() => UpdateMemberServiceUseCase(sl()));
    sl.registerLazySingleton(() => DeleteMemberServiceUseCase(sl()));
    sl.registerFactory(
      () => MemberServicesCubit(sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _barberEarnings() {
    sl.registerLazySingleton(() => BarberEarningsApi(sl()));
    sl.registerLazySingleton<IBarberEarningsRepo>(
      () => BarberEarningsRepo(sl()),
    );
    sl.registerLazySingleton(() => GetEarningsUseCase(sl()));
    sl.registerLazySingleton(() => GetMemberEarningsUseCase(sl()));
    sl.registerLazySingleton(() => GetMemberClientsUseCase(sl()));
    sl.registerFactory(() => EarningsCubit(sl()));
    sl.registerFactory(() => MemberEarningsCubit(sl()));
    sl.registerFactory(() => MemberClientsCubit(sl()));
  }

  void _barberBookings() {
    sl.registerLazySingleton(() => BarberBookingApi(sl()));
    sl.registerLazySingleton<IBarberBookingRepo>(() => BarberBookingRepo(sl()));
    sl.registerLazySingleton(() => GetBookingsUseCase(sl()));
    sl.registerLazySingleton(() => GetPendingBookingsUseCase(sl()));
    sl.registerLazySingleton(() => GetQueueUseCase(sl()));
    sl.registerLazySingleton(() => GetBookingUseCase(sl()));
    sl.registerLazySingleton(() => ConfirmBookingUseCase(sl()));
    sl.registerLazySingleton(() => RejectBookingUseCase(sl()));
    sl.registerLazySingleton(() => AdvanceBookingStatusUseCase(sl()));
    sl.registerLazySingleton(() => CreateWalkInUseCase(sl()));
    sl.registerLazySingleton(() => UpdateBookingBillingUseCase(sl()));
    sl.registerLazySingleton(() => GetWalkInOptionsUseCase(sl()));
    sl.registerLazySingleton(() => GetUnresolvedBookingsUseCase(sl()));
    sl.registerLazySingleton(() => SettleBookingsUseCase(sl()));
    sl.registerFactory(
      () => BookingsCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
    );
    sl.registerFactory(() => WalkInOptionsCubit(sl()));
    sl.registerFactory(() => UnresolvedBookingsCubit(sl(), sl()));
  }

  void _barberNotifications() {
    sl.registerLazySingleton(() => BarberNotificationsApi(sl()));
    sl.registerLazySingleton<IBarberNotificationsRepo>(
      () => BarberNotificationsRepo(sl()),
    );
    sl.registerLazySingleton(() => barber.GetNotificationsUseCase(sl()));
    sl.registerLazySingleton(
      () => barber.GetUnseenNotificationsCountUseCase(sl()),
    );
    sl.registerLazySingleton(
      () => barber.MarkAllNotificationsSeenUseCase(sl()),
    );
    sl.registerLazySingleton(() => barber.MarkNotificationClickedUseCase(sl()));
    sl.registerLazySingleton(
      () => BarberNotificationsCubit(sl(), sl(), sl(), sl()),
    );
  }

  void _barberDeviceToken() {
    sl.registerLazySingleton(() => BarberDeviceTokenApi(sl()));
    sl.registerLazySingleton<IBarberDeviceTokenRepo>(
      () => BarberDeviceTokenRepo(sl()),
    );
    sl.registerLazySingleton(() => barber.RegisterDeviceTokenUseCase(sl()));
    sl.registerLazySingleton(
      () => barber.UnregisterAllDeviceTokensUseCase(sl()),
    );
    sl.registerLazySingleton(
      () => BarberDeviceTokenSyncService(sl(), sl(), sl()),
    );
  }

  void _barberBroadcast() {
    sl.registerLazySingleton(() => BarberBroadcastApi(sl()));
    sl.registerLazySingleton<IBarberBroadcastRepo>(
      () => BarberBroadcastRepo(sl()),
    );
    sl.registerLazySingleton(() => SendBarberBroadcastUseCase(sl()));
    sl.registerLazySingleton(() => GetBroadcastsUseCase(sl()));
    sl.registerFactory(() => BarberBroadcastCubit(sl()));
    sl.registerFactory(() => BroadcastListCubit(sl()));
  }
}
