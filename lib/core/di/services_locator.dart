import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/barber/auth/data/apis/barber_auth_api.dart';
import '../../features/barber/auth/data/repos/barber_auth_repo.dart';
import '../../features/barber/auth/domain/repos/i_barber_auth_repo.dart';
import '../../features/barber/auth/domain/use_cases/barber_login_use_case.dart';
import '../../features/barber/auth/domain/use_cases/barber_logout_use_case.dart';
import '../../features/barber/auth/presentation/manager/barber_auth_cubit.dart';
import '../../features/barber/profile/data/apis/barber_profile_api.dart';
import '../../features/barber/profile/data/repos/barber_profile_repo.dart';
import '../../features/barber/profile/domain/repos/i_barber_profile_repo.dart';
import '../../features/barber/profile/domain/use_cases/get_barber_profile_use_case.dart';
import '../../features/barber/profile/domain/use_cases/update_barber_location_use_case.dart';
import '../../features/barber/profile/domain/use_cases/change_barber_password_use_case.dart';
import '../../features/barber/profile/presentation/manager/barber_profile_cubit.dart';
import '../../features/barber/hours/data/apis/barber_hours_api.dart';
import '../../features/barber/hours/data/repos/barber_hours_repo.dart';
import '../../features/barber/hours/domain/repos/i_barber_hours_repo.dart';
import '../../features/barber/hours/domain/use_cases/get_barber_hours_use_case.dart';
import '../../features/barber/hours/domain/use_cases/update_barber_hours_use_case.dart';
import '../../features/barber/hours/presentation/manager/barber_hours_cubit.dart';
import '../../features/barber/services/data/apis/barber_services_api.dart';
import '../../features/barber/services/data/repos/barber_services_repo.dart';
import '../../features/barber/services/domain/repos/i_barber_services_repo.dart';
import '../../features/barber/services/domain/use_cases/create_barber_service_use_case.dart';
import '../../features/barber/services/domain/use_cases/delete_barber_service_use_case.dart';
import '../../features/barber/services/domain/use_cases/get_barber_services_use_case.dart';
import '../../features/barber/services/domain/use_cases/get_service_catalog_use_case.dart';
import '../../features/barber/services/domain/use_cases/update_barber_service_use_case.dart';
import '../../features/barber/services/presentation/manager/barber_services_cubit.dart';
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
import '../../features/barber/store/domain/use_cases/place_store_order_use_case.dart';
import '../../features/barber/store/domain/use_cases/quote_cart_use_case.dart';
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
import '../../features/barber/storefront/orders/domain/use_cases/get_storefront_orders_use_case.dart';
import '../../features/barber/storefront/orders/domain/use_cases/reject_storefront_order_use_case.dart';
import '../../features/barber/storefront/orders/presentation/manager/barber_storefront_orders_cubit.dart';
import '../../features/barber/wallet/data/apis/barber_wallet_api.dart';
import '../../features/barber/wallet/data/repos/barber_wallet_repo.dart';
import '../../features/barber/wallet/domain/repos/i_barber_wallet_repo.dart';
import '../../features/barber/wallet/domain/use_cases/get_barber_wallet_use_case.dart';
import '../../features/barber/wallet/presentation/manager/barber_wallet_cubit.dart';
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
import '../../features/barber/bookings/data/apis/barber_booking_api.dart';
import '../../features/barber/bookings/data/repos/barber_booking_repo.dart';
import '../../features/barber/bookings/domain/repos/i_barber_booking_repo.dart';
import '../../features/barber/bookings/domain/use_cases/advance_booking_status_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/confirm_booking_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/create_walk_in_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/get_booking_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/get_bookings_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/get_pending_bookings_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/get_queue_use_case.dart';
import '../../features/barber/bookings/domain/use_cases/reject_booking_use_case.dart';
import '../../features/barber/bookings/presentation/manager/bookings_cubit.dart';
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
import '../../features/barber/team/domain/use_cases/create_member_service_use_case.dart';
import '../../features/barber/team/domain/use_cases/delete_member_service_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_earnings_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_member_hours_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_member_service_catalog_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_member_services_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_team_member_use_case.dart';
import '../../features/barber/team/domain/use_cases/get_team_use_case.dart';
import '../../features/barber/team/domain/use_cases/reset_member_password_use_case.dart';
import '../../features/barber/team/domain/use_cases/set_member_availability_use_case.dart';
import '../../features/barber/team/domain/use_cases/update_member_hours_use_case.dart';
import '../../features/barber/team/domain/use_cases/update_member_service_use_case.dart';
import '../../features/barber/team/domain/use_cases/update_team_member_use_case.dart';
import '../../features/barber/team/presentation/manager/barber_team_cubit.dart';
import '../../features/barber/team/presentation/manager/earnings_cubit.dart';
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
import '../../features/merchant/discounts/data/apis/merchant_discounts_api.dart';
import '../../features/merchant/discounts/data/repos/merchant_discounts_repo.dart';
import '../../features/merchant/discounts/domain/repos/i_merchant_discounts_repo.dart';
import '../../features/merchant/discounts/domain/use_cases/close_discount_use_case.dart';
import '../../features/merchant/discounts/domain/use_cases/create_discount_use_case.dart';
import '../../features/merchant/discounts/domain/use_cases/get_discount_shops_use_case.dart';
import '../../features/merchant/discounts/domain/use_cases/get_discounts_use_case.dart';
import '../../features/merchant/discounts/domain/use_cases/update_discount_use_case.dart';
import '../../features/merchant/discounts/presentation/manager/merchant_discounts_cubit.dart';
import '../../features/merchant/orders/data/apis/merchant_orders_api.dart';
import '../../features/merchant/orders/data/repos/merchant_orders_repo.dart';
import '../../features/merchant/orders/domain/repos/i_merchant_orders_repo.dart';
import '../../features/merchant/orders/domain/use_cases/accept_order_use_case.dart';
import '../../features/merchant/orders/domain/use_cases/advance_order_status_use_case.dart';
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

    _merchantAuth();
    _merchantDashboard();
    _merchantCategories();
    _merchantDocuments();
    _merchantProducts();
    _merchantDiscounts();
    _merchantOrders();
    _merchantProfile();
    _merchantDelivery();
    _merchantNotifications();
    _merchantDeviceToken();

    _barberAuth();
    _barberProfile();
    _barberHours();
    _barberServices();
    _barberDocuments();
    _barberStore();
    _barberStorefrontProducts();
    _barberStorefrontCategories();
    _barberStorefrontDelivery();
    _barberStorefrontOrders();
    _barberWallet();
    _barberReviews();
    _barberInvite();
    _barberTeam();
    _barberEarnings();
    _barberBookings();
    _barberNotifications();
    _barberDeviceToken();

    _initNotificationRouter();
    _initNotificationService();
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

  void _merchantAuth() {
    sl.registerLazySingleton(() => MerchantAuthApi(sl()));
    sl.registerLazySingleton(() => AuthLocalDataSource(sl(), sl()));
    sl.registerLazySingleton<IMerchantAuthRepo>(
      () => MerchantAuthRepo(sl(), sl()),
    );
    sl.registerLazySingleton(() => MerchantLoginUseCase(sl()));
    sl.registerLazySingleton(() => MerchantRegisterUseCase(sl()));
    sl.registerLazySingleton(() => MerchantLogoutUseCase(sl(), sl()));
    sl.registerFactory(() => MerchantAuthCubit(sl(), sl(), sl()));
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
    sl.registerLazySingleton(() => GetDiscountShopsUseCase(sl()));
    sl.registerLazySingleton(() => CreateDiscountUseCase(sl()));
    sl.registerLazySingleton(() => UpdateDiscountUseCase(sl()));
    sl.registerLazySingleton(() => CloseDiscountUseCase(sl()));
    sl.registerFactory(
      () => MerchantDiscountsCubit(sl(), sl(), sl(), sl(), sl()),
    );
  }

  void _merchantOrders() {
    sl.registerLazySingleton(() => MerchantOrdersApi(sl()));
    sl.registerLazySingleton<IMerchantOrdersRepo>(
      () => MerchantOrdersRepo(sl()),
    );
    sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
    sl.registerLazySingleton(() => AcceptOrderUseCase(sl()));
    sl.registerLazySingleton(() => RejectOrderUseCase(sl()));
    sl.registerLazySingleton(() => AdvanceOrderStatusUseCase(sl()));
    sl.registerFactory(() => MerchantOrdersCubit(sl(), sl(), sl(), sl()));
  }

  void _merchantProfile() {
    sl.registerLazySingleton(() => MerchantProfileApi(sl()));
    sl.registerLazySingleton<IMerchantProfileRepo>(
      () => MerchantProfileRepo(sl()),
    );
    sl.registerLazySingleton(() => GetMerchantProfileUseCase(sl()));
    sl.registerLazySingleton(() => UpdateMerchantProfileUseCase(sl()));
    sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
    sl.registerLazySingleton(() => MerchantProfileCubit(sl(), sl(), sl()));
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
    sl.registerLazySingleton(() => BarberLogoutUseCase(sl(), sl()));
    sl.registerFactory(() => BarberAuthCubit(sl(), sl()));
  }

  void _barberProfile() {
    sl.registerLazySingleton(() => BarberProfileApi(sl()));
    sl.registerLazySingleton<IBarberProfileRepo>(
      () => BarberProfileRepo(sl()),
    );
    sl.registerLazySingleton(() => GetBarberProfileUseCase(sl()));
    sl.registerLazySingleton(() => UpdateBarberLocationUseCase(sl()));
    sl.registerLazySingleton(() => ChangeBarberPasswordUseCase(sl()));
    sl.registerFactory(() => BarberProfileCubit(sl(), sl(), sl()));
  }

  void _barberHours() {
    sl.registerLazySingleton(() => BarberHoursApi(sl()));
    sl.registerLazySingleton<IBarberHoursRepo>(() => BarberHoursRepo(sl()));
    sl.registerLazySingleton(() => GetBarberHoursUseCase(sl()));
    sl.registerLazySingleton(() => UpdateBarberHoursUseCase(sl()));
    sl.registerFactory(() => BarberHoursCubit(sl(), sl()));
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
    sl.registerFactory(
      () => BarberServicesCubit(sl(), sl(), sl(), sl(), sl()),
    );
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
    sl.registerLazySingleton(() => QuoteCartUseCase(sl()));
    sl.registerLazySingleton(() => PlaceStoreOrderUseCase(sl()));
    sl.registerLazySingleton(() => GetStoreOrdersUseCase(sl()));
    sl.registerLazySingleton(() => GetStoreOrderUseCase(sl()));
    sl.registerLazySingleton(() => CancelStoreOrderUseCase(sl()));
    sl.registerFactory(() => BarberStoreMerchantsCubit(sl()));
    sl.registerFactory(() => BarberStoreCartCubit(sl(), sl(), sl()));
    sl.registerFactory(() => BarberStoreOrdersCubit(sl(), sl()));
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
    sl.registerLazySingleton(() => DeleteStorefrontCategoryUseCase(sl()));
    sl.registerFactory(
      () => BarberStorefrontCategoriesCubit(sl(), sl(), sl()),
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
    sl.registerLazySingleton(() => AcceptStorefrontOrderUseCase(sl()));
    sl.registerLazySingleton(() => RejectStorefrontOrderUseCase(sl()));
    sl.registerLazySingleton(() => AdvanceStorefrontOrderStatusUseCase(sl()));
    sl.registerFactory(
      () => BarberStorefrontOrdersCubit(sl(), sl(), sl(), sl()),
    );
  }

  void _barberWallet() {
    sl.registerLazySingleton(() => BarberWalletApi(sl()));
    sl.registerLazySingleton<IBarberWalletRepo>(() => BarberWalletRepo(sl()));
    sl.registerLazySingleton(() => GetBarberWalletUseCase(sl()));
    sl.registerFactory(() => BarberWalletCubit(sl()));
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

  void _barberTeam() {
    sl.registerLazySingleton(() => BarberTeamApi(sl()));
    sl.registerLazySingleton<IBarberTeamRepo>(() => BarberTeamRepo(sl()));
    sl.registerLazySingleton(() => GetTeamUseCase(sl()));
    sl.registerLazySingleton(() => AddTeamMemberUseCase(sl()));
    sl.registerLazySingleton(() => GetTeamMemberUseCase(sl()));
    sl.registerLazySingleton(() => UpdateTeamMemberUseCase(sl()));
    sl.registerLazySingleton(() => SetMemberAvailabilityUseCase(sl()));
    sl.registerLazySingleton(() => ResetMemberPasswordUseCase(sl()));
    sl.registerLazySingleton(() => BlockTeamMemberUseCase(sl()));
    sl.registerLazySingleton(() => ActivateTeamMemberUseCase(sl()));
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
    sl.registerFactory(() => EarningsCubit(sl()));
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
    sl.registerFactory(
      () => BookingsCubit(sl(), sl(), sl(), sl(), sl(), sl()),
    );
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
}
