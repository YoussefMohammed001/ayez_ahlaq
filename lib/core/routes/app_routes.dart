import 'dart:typed_data';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../env/env.dart';
import '../../features/customer/auth/presentation/manager/customer_auth_cubit.dart';
import '../../features/customer/auth/presentation/pages/customer_login_screen.dart';
import '../../features/customer/auth/presentation/pages/customer_register_screen.dart';
import '../../features/customer/profile/presentation/pages/customer_change_password_screen.dart';
import '../../features/customer/profile/presentation/pages/customer_delete_account_screen.dart';
import '../../features/barber/profile/presentation/pages/barber_delete_account_screen.dart';
import '../../features/merchant/profile/presentation/pages/merchant_delete_account_screen.dart';
import '../../features/customer/auth/presentation/pages/customer_verify_otp_screen.dart';
import '../../features/customer/auth/presentation/pages/customer_forgot_password_screen.dart';
import '../../features/customer/auth/presentation/pages/customer_reset_password_otp_screen.dart';
import '../../features/customer/auth/presentation/pages/customer_reset_password_screen.dart';
import '../../features/barber/auth/presentation/pages/barber_register_screen.dart';
import '../../features/barber/auth/presentation/pages/barber_verify_otp_screen.dart';
import '../../features/barber/auth/presentation/pages/barber_forgot_password_screen.dart';
import '../../features/barber/auth/presentation/pages/barber_reset_password_otp_screen.dart';
import '../../features/barber/auth/presentation/pages/barber_reset_password_screen.dart';
import '../../features/merchant/auth/presentation/pages/merchant_verify_otp_screen.dart';
import '../../features/merchant/auth/presentation/pages/merchant_forgot_password_screen.dart';
import '../../features/merchant/auth/presentation/pages/merchant_reset_password_otp_screen.dart';
import '../../features/merchant/auth/presentation/pages/merchant_reset_password_screen.dart';
import '../../features/customer/shops/presentation/manager/customer_shop_detail_cubit.dart';
import '../../features/customer/shops/presentation/manager/customer_shops_cubit.dart';
import '../../features/customer/presentation/pages/customer_shell.dart';
import '../../features/customer/profile/presentation/manager/customer_profile_cubit.dart';
import '../../features/customer/shops/presentation/pages/customer_shop_detail_screen.dart';
import '../../features/customer/shops/presentation/pages/browse_shops_screen.dart';
import '../../features/customer/booking/presentation/manager/booking_detail_cubit.dart';
import '../../features/customer/booking/presentation/manager/booking_flow_cubit.dart';
import '../../features/customer/booking/presentation/manager/my_bookings_cubit.dart';
import '../../features/customer/booking/presentation/pages/booking_detail_screen.dart'
    as customer_booking;
import '../../features/customer/booking/presentation/pages/booking_summary_screen.dart';
import '../../features/customer/booking/presentation/pages/choose_barber_screen.dart';
import '../../features/customer/booking/presentation/pages/choose_service_screen.dart';
import '../../features/customer/booking/presentation/pages/choose_style_screen.dart';
import '../../features/customer/booking/presentation/pages/choose_time_screen.dart';
import '../../features/customer/booking/presentation/pages/my_bookings_screen.dart';
import '../../features/customer/store/domain/entities/store_order.dart' as customer_store;
import '../../features/customer/payment_methods/presentation/manager/payment_methods_cubit.dart';
import '../../features/customer/store/presentation/manager/store_cart_cubit.dart';
import '../../features/customer/store/presentation/manager/store_orders_cubit.dart';
import '../../features/customer/store/presentation/pages/my_store_orders_screen.dart';
import '../../features/customer/store/presentation/pages/store_cart_screen.dart';
import '../../features/customer/store/presentation/pages/store_order_details_screen.dart'
    as customer_store;
import '../../features/customer/store/presentation/pages/store_products_screen.dart';
import '../../features/customer/favorites/presentation/manager/favorites_cubit.dart';
import '../../features/customer/favorites/presentation/manager/invite_preview_cubit.dart';
import '../../features/customer/favorites/presentation/pages/enter_invite_code_screen.dart';
import '../../features/customer/favorites/presentation/pages/favorites_screen.dart';
import '../../features/customer/favorites/presentation/pages/invite_preview_screen.dart';
import '../../features/customer/notifications/presentation/manager/customer_notifications_cubit.dart';
import '../../features/customer/notifications/presentation/pages/customer_notifications_screen.dart';
import '../../features/customer/wallet/domain/entities/wallet_request.dart'
    as customer_wallet;
import '../../features/customer/wallet/presentation/manager/customer_wallet_cubit.dart';
import '../../features/customer/wallet/presentation/manager/customer_wallet_requests_cubit.dart';
import '../../features/customer/wallet/presentation/manager/create_wallet_request_cubit.dart'
    as customer_wallet;
import '../../features/customer/wallet/presentation/pages/customer_wallet_screen.dart';
import '../../features/customer/wallet/presentation/pages/customer_wallet_requests_screen.dart';
import '../../features/customer/wallet/presentation/pages/create_customer_wallet_request_screen.dart';
import '../../features/customer/wallet/presentation/pages/customer_wallet_request_detail_screen.dart';
import '../../features/customer/wallet/presentation/pages/wallet_request_attachment_screen.dart'
    as customer_wallet;
import '../../features/customer/ratings/presentation/manager/customer_ratings_cubit.dart';
import '../../features/customer/ratings/presentation/pages/customer_ratings_screen.dart';
import '../../features/barber/auth/presentation/manager/barber_auth_cubit.dart';
import '../../features/barber/auth/presentation/pages/barber_login_screen.dart';
import '../../features/barber/bookings/domain/entities/booking.dart';
import '../../features/barber/bookings/presentation/manager/bookings_cubit.dart';
import '../../features/barber/bookings/presentation/pages/booking_detail_screen.dart';
import '../../features/barber/presentation/pages/barber_shell.dart';
import '../../features/barber/profile/presentation/manager/barber_profile_cubit.dart';
import '../../features/barber/hours/presentation/manager/barber_hours_cubit.dart';
import '../../features/barber/hours/presentation/pages/barber_hours_screen.dart';
import '../../features/barber/drinks/presentation/manager/barber_drinks_cubit.dart';
import '../../features/barber/drinks/presentation/pages/barber_drinks_screen.dart';
import '../../features/barber/sponsorship/presentation/manager/barber_sponsorship_cubit.dart';
import '../../features/barber/sponsorship/presentation/pages/barber_sponsorship_screen.dart';
import '../../features/merchant/sponsorship/presentation/manager/merchant_sponsorship_cubit.dart';
import '../../features/merchant/sponsorship/presentation/pages/merchant_sponsorship_screen.dart';
import '../../features/barber/profile/domain/entities/barber_profile.dart';
import '../../features/barber/profile/presentation/pages/barber_location_screen.dart';
import '../../features/barber/profile/presentation/pages/barber_change_password_screen.dart';
import '../../features/barber/services/presentation/manager/barber_services_cubit.dart';
import '../../features/barber/services/presentation/manager/own_services_cubit.dart';
import '../../features/barber/services/presentation/pages/barber_services_screen.dart';
import '../../features/barber/documents/presentation/manager/barber_documents_cubit.dart';
import '../../features/barber/documents/presentation/helpers/document_view_args.dart'
    as barber_documents;
import '../../features/barber/documents/presentation/pages/document_viewer_screen.dart'
    as barber_documents;
import '../../features/barber/documents/presentation/pages/barber_documents_screen.dart';
import '../../features/barber/wallet/domain/entities/wallet_request.dart'
    as barber_wallet;
import '../../features/barber/wallet/presentation/manager/barber_wallet_requests_cubit.dart';
import '../../features/barber/wallet/presentation/manager/create_wallet_request_cubit.dart'
    as barber_wallet;
import '../../features/barber/wallet/presentation/pages/barber_wallet_requests_screen.dart';
import '../../features/barber/wallet/presentation/pages/create_wallet_request_screen.dart';
import '../../features/barber/wallet/presentation/pages/wallet_request_detail_screen.dart';
import '../../features/barber/wallet/presentation/pages/wallet_request_attachment_screen.dart'
    as barber_wallet;
import '../../features/merchant/wallet/domain/entities/wallet_request.dart'
    as merchant_wallet;
import '../../features/merchant/wallet/presentation/manager/merchant_wallet_cubit.dart';
import '../../features/merchant/wallet/presentation/manager/merchant_wallet_requests_cubit.dart';
import '../../features/merchant/wallet/presentation/manager/create_wallet_request_cubit.dart'
    as merchant_wallet;
import '../../features/merchant/wallet/presentation/pages/merchant_wallet_screen.dart';
import '../../features/merchant/wallet/presentation/pages/merchant_wallet_requests_screen.dart';
import '../../features/merchant/wallet/presentation/pages/create_merchant_wallet_request_screen.dart';
import '../../features/merchant/wallet/presentation/pages/merchant_wallet_request_detail_screen.dart';
import '../../features/merchant/wallet/presentation/pages/wallet_request_attachment_screen.dart'
    as merchant_wallet;
import '../../features/barber/store/domain/entities/store_merchant.dart';
import '../../features/barber/store/domain/entities/store_order.dart';
import '../../features/barber/store/presentation/manager/barber_store_cart_cubit.dart';
import '../../features/barber/store/presentation/manager/barber_store_merchants_cubit.dart';
import '../../features/barber/store/presentation/manager/barber_store_orders_cubit.dart';
import '../../features/barber/store/presentation/pages/barber_store_cart_screen.dart';
import '../../features/barber/store/presentation/pages/store_home_screen.dart';
import '../../features/barber/store/presentation/pages/barber_store_order_details_screen.dart';
import '../../features/barber/store/presentation/pages/barber_store_products_screen.dart';
import '../../features/barber/storefront/categories/presentation/manager/barber_storefront_categories_cubit.dart';
import '../../features/barber/storefront/delivery/presentation/manager/barber_storefront_delivery_cubit.dart';
import '../../features/barber/storefront/orders/domain/entities/storefront_order.dart';
import '../../features/barber/storefront/orders/presentation/manager/barber_storefront_orders_cubit.dart';
import '../../features/barber/storefront/orders/presentation/pages/storefront_order_details_screen.dart';
import '../../features/barber/storefront/presentation/pages/storefront_home_screen.dart';
import '../../features/barber/storefront/products/domain/entities/storefront_product.dart';
import '../../features/barber/storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../../features/barber/storefront/products/presentation/pages/storefront_product_details_screen.dart';
import '../../features/barber/storefront/products/presentation/pages/storefront_product_form_screen.dart';
import '../../features/barber/wallet/presentation/manager/barber_wallet_cubit.dart';
import '../../features/barber/wallet/presentation/pages/barber_wallet_screen.dart';
import '../../features/barber/reviews/presentation/manager/barber_reviews_cubit.dart';
import '../../features/barber/reviews/presentation/pages/barber_reviews_screen.dart';
import '../../features/barber/invite/presentation/manager/barber_invite_cubit.dart';
import '../../features/barber/invite/presentation/pages/barber_invite_screen.dart';
import '../../features/barber/subscription/presentation/manager/barber_subscription_cubit.dart';
import '../../features/barber/subscription/presentation/manager/barber_subscription_requests_cubit.dart';
import '../../features/barber/subscription/presentation/pages/barber_subscription_screen.dart';
import '../../features/barber/subscription/presentation/pages/barber_subscription_requests_screen.dart';
import '../../features/barber/broadcast/presentation/manager/barber_broadcast_cubit.dart';
import '../../features/barber/broadcast/presentation/manager/broadcast_list_cubit.dart';
import '../../features/barber/broadcast/presentation/pages/barber_broadcast_screen.dart';
import '../../features/barber/broadcast/presentation/pages/broadcast_list_screen.dart';
import '../../features/merchant/subscription/presentation/manager/merchant_subscription_cubit.dart';
import '../../features/merchant/subscription/presentation/manager/merchant_subscription_requests_cubit.dart';
import '../../features/merchant/subscription/presentation/pages/merchant_subscription_screen.dart';
import '../../features/merchant/subscription/presentation/pages/merchant_subscription_requests_screen.dart';
import '../../features/merchant/broadcast/presentation/manager/merchant_broadcast_cubit.dart';
import '../../features/merchant/broadcast/presentation/manager/merchant_broadcast_list_cubit.dart';
import '../../features/merchant/broadcast/presentation/pages/merchant_broadcast_list_screen.dart';
import '../../features/merchant/broadcast/presentation/pages/merchant_broadcast_screen.dart';
import '../../features/barber/notifications/presentation/manager/barber_notifications_cubit.dart';
import '../../features/barber/notifications/presentation/pages/barber_notifications_screen.dart';
import '../../features/barber/team/presentation/manager/barber_team_cubit.dart';
import '../../features/barber/team/presentation/manager/earnings_cubit.dart';
import '../../features/barber/team/presentation/manager/member_clients_cubit.dart';
import '../../features/barber/team/presentation/manager/member_earnings_cubit.dart';
import '../../features/barber/team/presentation/manager/member_hours_cubit.dart';
import '../../features/barber/team/presentation/manager/member_services_cubit.dart';
import '../../features/barber/team/presentation/manager/team_member_detail_cubit.dart';
import '../../features/barber/team/presentation/pages/earnings_screen.dart';
import '../../features/barber/team/presentation/pages/team_member_detail_screen.dart';
import '../../features/barber/team/presentation/pages/team_screen.dart';
import '../../features/merchant/auth/presentation/manager/merchant_auth_cubit.dart';
import '../../features/merchant/auth/presentation/pages/merchant_login_screen.dart';
import '../../features/merchant/auth/presentation/pages/merchant_register_screen.dart';
import '../../features/merchant/categories/presentation/manager/merchant_categories_cubit.dart';
import '../../features/merchant/categories/presentation/pages/merchant_categories_screen.dart';
import '../../features/merchant/dashboard/presentation/manager/merchant_dashboard_cubit.dart';
import '../../features/merchant/documents/presentation/manager/merchant_documents_cubit.dart';
import '../../features/merchant/documents/presentation/helpers/document_view_args.dart';
import '../../features/merchant/documents/presentation/pages/document_viewer_screen.dart';
import '../../features/merchant/documents/presentation/pages/merchant_documents_screen.dart';
import '../../features/merchant/delivery/presentation/manager/merchant_delivery_cubit.dart';
import '../../features/merchant/delivery/presentation/pages/merchant_delivery_screen.dart';
import '../../features/merchant/discounts/presentation/manager/merchant_discounts_cubit.dart';
import '../../features/merchant/discounts/domain/entities/discount.dart';
import '../../features/merchant/discounts/presentation/pages/discount_form_screen.dart';
import '../../features/merchant/discounts/presentation/manager/discount_quote_cubit.dart';
import '../../features/merchant/discounts/presentation/pages/discount_quote_screen.dart';
import '../../features/merchant/discounts/presentation/pages/merchant_discounts_screen.dart';
import '../../features/merchant/orders/domain/entities/purchase_order.dart';
import '../../features/merchant/orders/presentation/manager/merchant_orders_cubit.dart';
import '../../features/merchant/orders/presentation/pages/order_details_screen.dart';
import '../../features/merchant/presentation/pages/merchant_shell.dart';
import '../../features/merchant/products/presentation/manager/merchant_products_cubit.dart';
import '../../features/merchant/products/domain/entities/merchant_product.dart';
import '../../features/merchant/products/presentation/pages/product_details_screen.dart';
import '../../features/merchant/products/presentation/pages/product_form_screen.dart';
import '../../features/merchant/profile/domain/entities/merchant_profile.dart';
import '../../features/merchant/profile/presentation/manager/merchant_profile_cubit.dart';
import '../../features/merchant/profile/presentation/manager/merchant_phones_cubit.dart';
import '../../features/merchant/notifications/presentation/manager/merchant_notifications_cubit.dart';
import '../../features/merchant/notifications/presentation/pages/merchant_notifications_screen.dart';
import '../../shared/widgets/settings/about_app_screen.dart';
import '../../shared/widgets/success_screen.dart';
import '../../shared/widgets/success_screen_args.dart';
import '../../features/merchant/profile/presentation/pages/change_password_screen.dart';
import '../../features/merchant/profile/presentation/pages/merchant_location_screen.dart';
import '../../features/merchant/profile/presentation/pages/merchant_phones_screen.dart';
import '../../features/merchant/profile/presentation/pages/edit_profile_screen.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/user_type/presentation/pages/user_type_screen.dart';
import '../di/services_locator.dart';
import 'route_observer.dart';
import 'route_paths.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = ChuckerFlutter.navigatorKey;
final CustomGoRouterObserver customGoRouterObserver = CustomGoRouterObserver();

final MerchantProductsCubit _productsCubit = sl<MerchantProductsCubit>();
final MerchantOrdersCubit _ordersCubit = sl<MerchantOrdersCubit>();
final MerchantDashboardCubit _dashboardCubit = sl<MerchantDashboardCubit>();
final MerchantProfileCubit _profileCubit = sl<MerchantProfileCubit>();
final MerchantAuthCubit _authCubit = sl<MerchantAuthCubit>();
final MerchantCategoriesCubit _categoriesCubit = sl<MerchantCategoriesCubit>();
final MerchantDiscountsCubit _discountsCubit = sl<MerchantDiscountsCubit>();
final MerchantPhonesCubit _phonesCubit = sl<MerchantPhonesCubit>();
final MerchantDeliveryCubit _deliveryCubit = sl<MerchantDeliveryCubit>();
final MerchantDocumentsCubit _documentsCubit = sl<MerchantDocumentsCubit>();
final MerchantNotificationsCubit _notificationsCubit =
    sl<MerchantNotificationsCubit>();
final CustomerAuthCubit _customerAuthCubit = sl<CustomerAuthCubit>();
final CustomerShopsCubit _customerShopsCubit = sl<CustomerShopsCubit>();
final CustomerProfileCubit _customerProfileCubit = sl<CustomerProfileCubit>();
final CustomerShopDetailCubit _customerShopDetailCubit =
    sl<CustomerShopDetailCubit>();
final BookingFlowCubit _bookingFlowCubit = sl<BookingFlowCubit>();
final MyBookingsCubit _myBookingsCubit = sl<MyBookingsCubit>();
final BookingDetailCubit _customerBookingDetailCubit = sl<BookingDetailCubit>();
final StoreCartCubit _customerStoreCartCubit = sl<StoreCartCubit>();
final StoreOrdersCubit _customerStoreOrdersCubit = sl<StoreOrdersCubit>();
final PaymentMethodsCubit _customerPaymentMethodsCubit = sl<PaymentMethodsCubit>();
final FavoritesCubit _customerFavoritesCubit = sl<FavoritesCubit>();
final InvitePreviewCubit _customerInvitePreviewCubit = sl<InvitePreviewCubit>();
final CustomerNotificationsCubit _customerNotificationsCubit =
    sl<CustomerNotificationsCubit>();
final BarberAuthCubit _barberAuthCubit = sl<BarberAuthCubit>();
final BarberProfileCubit _barberProfileCubit = sl<BarberProfileCubit>();
final BarberHoursCubit _barberHoursCubit = sl<BarberHoursCubit>();
final BarberDrinksCubit _barberDrinksCubit = sl<BarberDrinksCubit>();
final BarberSponsorshipCubit _barberSponsorshipCubit =
    sl<BarberSponsorshipCubit>();
final MerchantSponsorshipCubit _merchantSponsorshipCubit =
    sl<MerchantSponsorshipCubit>();
final BarberServicesCubit _barberServicesCubit = sl<BarberServicesCubit>();
final OwnServicesCubit _ownServicesCubit = sl<OwnServicesCubit>();
final BarberDocumentsCubit _barberDocumentsCubit = sl<BarberDocumentsCubit>();
final BarberStoreMerchantsCubit _barberStoreMerchantsCubit =
    sl<BarberStoreMerchantsCubit>();
final BarberStoreCartCubit _barberStoreCartCubit = sl<BarberStoreCartCubit>();
final BarberStoreOrdersCubit _barberStoreOrdersCubit =
    sl<BarberStoreOrdersCubit>();
final BarberStorefrontProductsCubit _barberStorefrontProductsCubit =
    sl<BarberStorefrontProductsCubit>();
final BarberStorefrontCategoriesCubit _barberStorefrontCategoriesCubit =
    sl<BarberStorefrontCategoriesCubit>();
final BarberStorefrontDeliveryCubit _barberStorefrontDeliveryCubit =
    sl<BarberStorefrontDeliveryCubit>();
final BarberStorefrontOrdersCubit _barberStorefrontOrdersCubit =
    sl<BarberStorefrontOrdersCubit>();
final BarberWalletCubit _barberWalletCubit = sl<BarberWalletCubit>();
final BarberWalletRequestsCubit _barberWalletRequestsCubit =
    sl<BarberWalletRequestsCubit>();
final CustomerWalletCubit _customerWalletCubit = sl<CustomerWalletCubit>();
final CustomerWalletRequestsCubit _customerWalletRequestsCubit =
    sl<CustomerWalletRequestsCubit>();
final BarberReviewsCubit _barberReviewsCubit = sl<BarberReviewsCubit>();
final BarberInviteCubit _barberInviteCubit = sl<BarberInviteCubit>();
final BarberSubscriptionCubit _barberSubscriptionCubit =
    sl<BarberSubscriptionCubit>();
final BarberSubscriptionRequestsCubit _barberSubscriptionRequestsCubit =
    sl<BarberSubscriptionRequestsCubit>();
final BarberBroadcastCubit _barberBroadcastCubit = sl<BarberBroadcastCubit>();
final BroadcastListCubit _barberBroadcastListCubit = sl<BroadcastListCubit>();
final MerchantSubscriptionCubit _merchantSubscriptionCubit =
    sl<MerchantSubscriptionCubit>();
final MerchantSubscriptionRequestsCubit _merchantSubscriptionRequestsCubit =
    sl<MerchantSubscriptionRequestsCubit>();
final MerchantBroadcastCubit _merchantBroadcastCubit =
    sl<MerchantBroadcastCubit>();
final MerchantBroadcastListCubit _merchantBroadcastListCubit =
    sl<MerchantBroadcastListCubit>();
final MerchantWalletCubit _merchantWalletCubit = sl<MerchantWalletCubit>();
final MerchantWalletRequestsCubit _merchantWalletRequestsCubit =
    sl<MerchantWalletRequestsCubit>();
final BarberNotificationsCubit _barberNotificationsCubit =
    sl<BarberNotificationsCubit>();
final BarberTeamCubit _barberTeamCubit = sl<BarberTeamCubit>();
final TeamMemberDetailCubit _teamMemberDetailCubit =
    sl<TeamMemberDetailCubit>();
final MemberHoursCubit _memberHoursCubit = sl<MemberHoursCubit>();
final MemberServicesCubit _memberServicesCubit = sl<MemberServicesCubit>();
final MemberEarningsCubit _memberEarningsCubit = sl<MemberEarningsCubit>();
final MemberClientsCubit _memberClientsCubit = sl<MemberClientsCubit>();
final EarningsCubit _earningsCubit = sl<EarningsCubit>();
final BookingsCubit _bookingsCubit = sl<BookingsCubit>();

final routes = GoRouter(
  initialLocation: Routes.splashScreen,
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: isDevEnvironment(),
  observers: [customGoRouterObserver],
  routes: [
    GoRoute(
      path: Routes.splashScreen,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.userTypeScreen,
      builder: (_, __) => const UserTypeScreen(),
    ),
    GoRoute(
      path: Routes.loginScreen,
      builder: (_, __) => BlocProvider.value(
        value: _authCubit,
        child: const MerchantLoginScreen(),
      ),
    ),
    GoRoute(
      path: Routes.registerScreen,
      builder: (_, __) => BlocProvider.value(
        value: _authCubit,
        child: const MerchantRegisterScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerLoginScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerAuthCubit,
        child: const CustomerLoginScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerRegisterScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerAuthCubit,
        child: const CustomerRegisterScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerChangePasswordScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerProfileCubit,
        child: const CustomerChangePasswordScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerDeleteAccountScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerProfileCubit,
        child: const CustomerDeleteAccountScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberDeleteAccountScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberProfileCubit,
        child: const BarberDeleteAccountScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantDeleteAccountScreen,
      builder: (_, __) => BlocProvider.value(
        value: _profileCubit,
        child: const MerchantDeleteAccountScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerVerifyOtpScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerAuthCubit,
        child: const CustomerVerifyOtpScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerForgotPasswordScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerAuthCubit,
        child: const CustomerForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerResetPasswordOtpScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerAuthCubit,
        child: const CustomerResetPasswordOtpScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerResetPasswordScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerAuthCubit,
        child: const CustomerResetPasswordScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberRegisterScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberAuthCubit,
        child: const BarberRegisterScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberVerifyOtpScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberAuthCubit,
        child: const BarberVerifyOtpScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberForgotPasswordScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberAuthCubit,
        child: const BarberForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberResetPasswordOtpScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberAuthCubit,
        child: const BarberResetPasswordOtpScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberResetPasswordScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberAuthCubit,
        child: const BarberResetPasswordScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantVerifyOtpScreen,
      builder: (_, __) => BlocProvider.value(
        value: _authCubit,
        child: const MerchantVerifyOtpScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantForgotPasswordScreen,
      builder: (_, __) => BlocProvider.value(
        value: _authCubit,
        child: const MerchantForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantResetPasswordOtpScreen,
      builder: (_, __) => BlocProvider.value(
        value: _authCubit,
        child: const MerchantResetPasswordOtpScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantResetPasswordScreen,
      builder: (_, __) => BlocProvider.value(
        value: _authCubit,
        child: const MerchantResetPasswordScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerShell,
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _customerShopsCubit),
          BlocProvider.value(value: _customerStoreOrdersCubit),
          BlocProvider.value(value: _customerFavoritesCubit),
          BlocProvider.value(value: _customerProfileCubit),
          BlocProvider.value(value: _customerNotificationsCubit),
          BlocProvider.value(value: _myBookingsCubit),
        ],
        child: CustomerShell(onLogout: _handleCustomerLogout),
      ),
    ),
    GoRoute(
      path: Routes.customerBrowseShopsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerShopsCubit,
        child: const BrowseShopsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerShopDetailScreen,
      builder: (_, state) => BlocProvider.value(
        value: _customerShopDetailCubit,
        child: CustomerShopDetailScreen(shopId: state.extra as int),
      ),
    ),
    GoRoute(
      path: Routes.customerChooseServiceScreen,
      builder: (_, __) => BlocProvider.value(
        value: _bookingFlowCubit,
        child: const ChooseServiceScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerChooseStyleScreen,
      builder: (_, __) => BlocProvider.value(
        value: _bookingFlowCubit,
        child: const ChooseStyleScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerChooseBarberScreen,
      builder: (_, __) => BlocProvider.value(
        value: _bookingFlowCubit,
        child: const ChooseBarberScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerChooseTimeScreen,
      builder: (_, __) => BlocProvider.value(
        value: _bookingFlowCubit,
        child: const ChooseTimeScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerBookingSummaryScreen,
      builder: (_, __) => BlocProvider.value(
        value: _bookingFlowCubit,
        child: const BookingSummaryScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerBookingsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _myBookingsCubit,
        child: const MyBookingsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerBookingDetailScreen,
      builder: (_, state) => BlocProvider.value(
        value: _customerBookingDetailCubit,
        child: customer_booking.BookingDetailScreen(bookingId: state.extra as int),
      ),
    ),
    GoRoute(
      path: Routes.customerStoreProductsScreen,
      builder: (_, state) => BlocProvider.value(
        value: _customerStoreCartCubit,
        child: StoreProductsScreen(shopId: state.extra as int),
      ),
    ),
    GoRoute(
      path: Routes.customerStoreCartScreen,
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _customerStoreCartCubit),
          BlocProvider.value(value: _customerPaymentMethodsCubit),
        ],
        child: const StoreCartScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerStoreOrdersScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerStoreOrdersCubit,
        child: const MyStoreOrdersScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerStoreOrderDetailScreen,
      builder: (_, state) => BlocProvider.value(
        value: _customerStoreOrdersCubit,
        child: customer_store.StoreOrderDetailsScreen(
          order: state.extra as customer_store.StoreOrder,
        ),
      ),
    ),
    GoRoute(
      path: Routes.customerFavoritesScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerFavoritesCubit,
        child: const FavoritesScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerEnterInviteCodeScreen,
      builder: (_, __) => const EnterInviteCodeScreen(),
    ),
    GoRoute(
      path: Routes.customerInvitePreviewScreen,
      builder: (_, state) => BlocProvider.value(
        value: _customerInvitePreviewCubit,
        child: InvitePreviewScreen(inviteCode: state.extra as String),
      ),
    ),
    GoRoute(
      path: Routes.customerNotificationsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerNotificationsCubit,
        child: const CustomerNotificationsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberLoginScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberAuthCubit,
        child: const BarberLoginScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberShell,
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _barberProfileCubit),
          BlocProvider.value(value: _barberServicesCubit),
          BlocProvider.value(value: _ownServicesCubit),
          BlocProvider.value(value: _barberStoreMerchantsCubit),
          BlocProvider.value(value: _barberStoreCartCubit),
          BlocProvider.value(value: _barberNotificationsCubit),
          BlocProvider.value(value: _bookingsCubit),
          BlocProvider.value(value: _barberStorefrontProductsCubit),
          BlocProvider.value(value: _barberStorefrontCategoriesCubit),
          BlocProvider.value(value: _barberStorefrontDeliveryCubit),
          BlocProvider.value(value: _barberStorefrontOrdersCubit),
          BlocProvider.value(value: _earningsCubit),
          BlocProvider.value(value: _barberSubscriptionCubit),
        ],
        child: BarberShell(onLogout: _handleBarberLogout),
      ),
    ),
    GoRoute(
      path: Routes.barberHoursScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberHoursCubit..loadHours(),
        child: const BarberHoursScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberSponsorshipScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberSponsorshipCubit..loadSponsorship(),
        child: const BarberSponsorshipScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberDrinksScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberDrinksCubit..loadDrinks(),
        child: const BarberDrinksScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberLocationScreen,
      builder: (_, state) => BlocProvider.value(
        value: _barberProfileCubit,
        child: BarberLocationScreen(profile: state.extra as BarberProfile?),
      ),
    ),
    GoRoute(
      path: Routes.barberChangePasswordScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberProfileCubit,
        child: const BarberChangePasswordScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberDocumentsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberDocumentsCubit,
        child: const BarberDocumentsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberServicesScreen,
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _barberServicesCubit),
          BlocProvider.value(value: _ownServicesCubit),
        ],
        child: const BarberServicesScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberDocumentViewerScreen,
      builder: (_, state) {
        final args = state.extra as barber_documents.DocumentViewArgs;
        return barber_documents.DocumentViewerScreen(
          document: args.document,
          bytes: args.bytes,
        );
      },
    ),
    GoRoute(
      path: Routes.barberStoreMerchantsScreen,
      builder: (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _barberStoreMerchantsCubit..loadMerchants()),
          BlocProvider.value(value: _barberStoreCartCubit),
          BlocProvider.value(value: _barberStoreOrdersCubit..loadOrders()),
        ],
        child: StoreHomeScreen(initialTabIndex: state.extra as int? ?? 0),
      ),
    ),
    GoRoute(
      path: Routes.barberStoreProductsScreen,
      builder: (_, state) => BlocProvider.value(
        value: _barberStoreCartCubit,
        child: BarberStoreProductsScreen(
          merchant: state.extra as StoreMerchant,
        ),
      ),
    ),
    GoRoute(
      path: Routes.barberStoreCartScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberStoreCartCubit,
        child: const BarberStoreCartScreen(),
      ),
    ),
    GoRoute(
      path: Routes.successScreen,
      builder: (_, state) {
        final args = state.extra as SuccessScreenArgs;
        return SuccessScreen(message: args.message, doneRoute: args.doneRoute);
      },
    ),
    GoRoute(
      path: Routes.barberStoreOrderDetailsScreen,
      builder: (_, state) => BlocProvider.value(
        value: _barberStoreOrdersCubit,
        child: BarberStoreOrderDetailsScreen(order: state.extra as StoreOrder),
      ),
    ),
    GoRoute(
      path: Routes.barberWalletScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberWalletCubit..loadWallet(),
        child: const BarberWalletScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberWalletRequestsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberWalletRequestsCubit..loadRequests(),
        child: const BarberWalletRequestsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.createBarberWalletRequestScreen,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<barber_wallet.CreateWalletRequestCubit>(),
        child: const CreateWalletRequestScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberWalletRequestDetailScreen,
      builder: (_, state) => BlocProvider.value(
        value: _barberWalletRequestsCubit,
        child: WalletRequestDetailScreen(
          request: state.extra as barber_wallet.WalletRequest,
        ),
      ),
    ),
    GoRoute(
      path: Routes.barberWalletRequestAttachmentScreen,
      builder: (_, state) => barber_wallet.WalletRequestAttachmentScreen(
        bytes: state.extra as Uint8List,
      ),
    ),
    GoRoute(
      path: Routes.customerWalletScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerWalletCubit..loadWallet(),
        child: const CustomerWalletScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerWalletRequestsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _customerWalletRequestsCubit..loadRequests(),
        child: const CustomerWalletRequestsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.createCustomerWalletRequestScreen,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<customer_wallet.CreateWalletRequestCubit>(),
        child: const CreateCustomerWalletRequestScreen(),
      ),
    ),
    GoRoute(
      path: Routes.customerWalletRequestDetailScreen,
      builder: (_, state) => BlocProvider.value(
        value: _customerWalletRequestsCubit,
        child: CustomerWalletRequestDetailScreen(
          request: state.extra as customer_wallet.WalletRequest,
        ),
      ),
    ),
    GoRoute(
      path: Routes.customerWalletRequestAttachmentScreen,
      builder: (_, state) => customer_wallet.WalletRequestAttachmentScreen(
        bytes: state.extra as Uint8List,
      ),
    ),
    GoRoute(
      path: Routes.customerRatingsScreen,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<CustomerRatingsCubit>()..loadRatings(),
        child: const CustomerRatingsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberReviewsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberReviewsCubit..loadReviews(),
        child: const BarberReviewsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberInviteScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberInviteCubit..loadInvite(),
        child: const BarberInviteScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberSubscriptionScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberSubscriptionCubit..load(),
        child: const BarberSubscriptionScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberSubscriptionRequestsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberSubscriptionRequestsCubit..loadRequests(),
        child: const BarberSubscriptionRequestsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberNotificationsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberNotificationsCubit..loadNotifications(),
        child: const BarberNotificationsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberBroadcastScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberBroadcastCubit,
        child: const BarberBroadcastScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberBroadcastListScreen,
      builder: (_, __) => BlocProvider.value(
        value: _barberBroadcastListCubit,
        child: const BroadcastListScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberTeamScreen,
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _barberTeamCubit..loadTeam()),
          BlocProvider.value(value: _barberProfileCubit),
        ],
        child: const TeamScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberTeamMemberDetailScreen,
      builder: (_, state) {
        final memberId = state.extra as int;
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: _teamMemberDetailCubit..loadMember(memberId),
            ),
            BlocProvider.value(
              value: _memberHoursCubit..loadHours(memberId),
            ),
            BlocProvider.value(
              value: _memberServicesCubit..loadServices(memberId),
            ),
            BlocProvider.value(
              value: _memberEarningsCubit..loadEarnings(memberId),
            ),
            BlocProvider.value(
              value: _memberClientsCubit..loadClients(memberId),
            ),
          ],
          child: const TeamMemberDetailScreen(),
        );
      },
    ),
    GoRoute(
      path: Routes.barberEarningsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _earningsCubit..loadEarnings(),
        child: const EarningsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberBookingDetailsScreen,
      builder: (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _bookingsCubit),
          BlocProvider.value(value: _barberServicesCubit),
        ],
        child: BookingDetailScreen(booking: state.extra as Booking),
      ),
    ),
    GoRoute(
      path: Routes.merchantShell,
      builder: (_, __) => _merchantProviders(
        child: MerchantShell(onLogout: _handleLogout),
      ),
    ),
    GoRoute(
      path: Routes.merchantProductFormScreen,
      builder: (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _productsCubit),
          BlocProvider.value(value: _categoriesCubit),
        ],
        child: ProductFormScreen(
          product: state.extra as MerchantProduct?,
        ),
      ),
    ),
    GoRoute(
      path: Routes.merchantProductDetailsScreen,
      builder: (_, state) => BlocProvider.value(
        value: _productsCubit,
        child: ProductDetailsScreen(productId: state.extra as int),
      ),
    ),
    GoRoute(
      path: Routes.merchantCategoriesScreen,
      builder: (_, state) => BlocProvider.value(
        value: _categoriesCubit,
        child: MerchantCategoriesScreen(
          categoryLimit: state.extra as int? ?? 0,
        ),
      ),
    ),
    GoRoute(
      path: Routes.merchantDiscountsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _discountsCubit,
        child: const MerchantDiscountsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantDiscountFormScreen,
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _discountsCubit),
          BlocProvider.value(value: _productsCubit),
        ],
        child: DiscountFormScreen(discount: __.extra as Discount?),
      ),
    ),
    GoRoute(
      path: Routes.merchantDiscountQuoteScreen,
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _discountsCubit),
          BlocProvider.value(value: _productsCubit),
          BlocProvider(create: (_) => sl<DiscountQuoteCubit>()),
        ],
        child: const DiscountQuoteScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantEditProfileScreen,
      builder: (_, state) => BlocProvider.value(
        value: _profileCubit,
        child: EditProfileScreen(profile: state.extra as MerchantProfile),
      ),
    ),
    GoRoute(
      path: Routes.merchantChangePasswordScreen,
      builder: (_, __) => BlocProvider.value(
        value: _profileCubit,
        child: const ChangePasswordScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantPhonesScreen,
      builder: (_, __) => BlocProvider.value(
        value: _phonesCubit..loadPhones(),
        child: const MerchantPhonesScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantLocationScreen,
      builder: (_, state) => BlocProvider.value(
        value: _profileCubit,
        child: MerchantLocationScreen(profile: state.extra as MerchantProfile?),
      ),
    ),
    GoRoute(
      path: Routes.merchantDocumentsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _documentsCubit,
        child: const MerchantDocumentsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantDocumentViewerScreen,
      builder: (_, state) {
        final args = state.extra as DocumentViewArgs;
        return DocumentViewerScreen(
          document: args.document,
          bytes: args.bytes,
        );
      },
    ),
    GoRoute(
      path: Routes.merchantNotificationsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _notificationsCubit..loadNotifications(),
        child: const MerchantNotificationsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantDeliveryScreen,
      builder: (_, __) => BlocProvider.value(
        value: _deliveryCubit..loadDelivery(),
        child: const MerchantDeliveryScreen(),
      ),
    ),
    GoRoute(
      path: Routes.barberStorefrontHomeScreen,
      builder: (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _barberStorefrontProductsCubit..loadProducts()),
          BlocProvider.value(value: _barberStorefrontCategoriesCubit..loadCategories()),
          BlocProvider.value(value: _barberStorefrontDeliveryCubit..loadDelivery()),
          BlocProvider.value(value: _barberStorefrontOrdersCubit..loadOrders()),
        ],
        child: StorefrontHomeScreen(
          initialTabIndex: state.extra as int? ?? 0,
          showBackButton: true,
        ),
      ),
    ),
    GoRoute(
      path: Routes.barberStorefrontProductFormScreen,
      builder: (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _barberStorefrontProductsCubit),
          BlocProvider.value(value: _barberStorefrontCategoriesCubit),
        ],
        child: StorefrontProductFormScreen(
          product: state.extra as StorefrontProduct?,
        ),
      ),
    ),
    GoRoute(
      path: Routes.barberStorefrontProductDetailsScreen,
      builder: (_, state) => BlocProvider.value(
        value: _barberStorefrontProductsCubit,
        child: StorefrontProductDetailsScreen(productId: state.extra as int),
      ),
    ),
    GoRoute(
      path: Routes.barberStorefrontOrderDetailsScreen,
      builder: (_, state) => BlocProvider.value(
        value: _barberStorefrontOrdersCubit,
        child: StorefrontOrderDetailsScreen(
          order: state.extra as StorefrontOrder,
        ),
      ),
    ),
    GoRoute(
      path: Routes.aboutScreen,
      builder: (_, __) => const AboutAppScreen(),
    ),
    GoRoute(
      path: Routes.merchantOrderDetailsScreen,
      builder: (_, state) => BlocProvider.value(
        value: _ordersCubit,
        child: OrderDetailsScreen(order: state.extra as PurchaseOrder),
      ),
    ),
    GoRoute(
      path: Routes.merchantSponsorshipScreen,
      builder: (_, __) => BlocProvider.value(
        value: _merchantSponsorshipCubit..loadSponsorship(),
        child: const MerchantSponsorshipScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantSubscriptionScreen,
      builder: (_, __) => BlocProvider.value(
        value: _merchantSubscriptionCubit..load(),
        child: const MerchantSubscriptionScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantSubscriptionRequestsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _merchantSubscriptionRequestsCubit..loadRequests(),
        child: const MerchantSubscriptionRequestsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantBroadcastScreen,
      builder: (_, state) => BlocProvider.value(
        value: _merchantBroadcastCubit,
        child: MerchantBroadcastScreen(
          profile: state.extra as MerchantProfile?,
        ),
      ),
    ),
    GoRoute(
      path: Routes.merchantBroadcastListScreen,
      builder: (_, state) => BlocProvider.value(
        value: _merchantBroadcastListCubit,
        child: MerchantBroadcastListScreen(
          profile: state.extra as MerchantProfile?,
        ),
      ),
    ),
    GoRoute(
      path: Routes.merchantWalletScreen,
      builder: (_, __) => BlocProvider.value(
        value: _merchantWalletCubit..loadWallet(),
        child: const MerchantWalletScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantWalletRequestsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _merchantWalletRequestsCubit..loadRequests(),
        child: const MerchantWalletRequestsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.createMerchantWalletRequestScreen,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<merchant_wallet.CreateWalletRequestCubit>(),
        child: const CreateMerchantWalletRequestScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantWalletRequestDetailScreen,
      builder: (_, state) => BlocProvider.value(
        value: _merchantWalletRequestsCubit,
        child: MerchantWalletRequestDetailScreen(
          request: state.extra as merchant_wallet.WalletRequest,
        ),
      ),
    ),
    GoRoute(
      path: Routes.merchantWalletRequestAttachmentScreen,
      builder: (_, state) => merchant_wallet.WalletRequestAttachmentScreen(
        bytes: state.extra as Uint8List,
      ),
    ),
  ],
);

Widget _merchantProviders({required Widget child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider.value(value: _dashboardCubit),
      BlocProvider.value(value: _productsCubit),
      BlocProvider.value(value: _ordersCubit),
      BlocProvider.value(value: _profileCubit),
      BlocProvider.value(value: _categoriesCubit),
      BlocProvider.value(value: _discountsCubit),
      BlocProvider.value(value: _documentsCubit),
      BlocProvider.value(value: _notificationsCubit),
      BlocProvider.value(value: _merchantSubscriptionCubit),
    ],
    child: child,
  );
}

Future<void> _handleLogout() async {
  await _authCubit.logout();
  rootNavigatorKey.currentContext?.go(Routes.loginScreen);
}

Future<void> _handleBarberLogout() async {
  await _barberAuthCubit.logout();
  rootNavigatorKey.currentContext?.go(Routes.barberLoginScreen);
}

Future<void> _handleCustomerLogout() async {
  await _customerAuthCubit.logout();
  rootNavigatorKey.currentContext?.go(Routes.customerLoginScreen);
}
