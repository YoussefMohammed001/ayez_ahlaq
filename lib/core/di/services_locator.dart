import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import '../../features/merchant/dashboard/data/apis/merchant_dashboard_api.dart';
import '../../features/merchant/dashboard/data/repos/merchant_dashboard_repo.dart';
import '../../features/merchant/dashboard/domain/repos/i_merchant_dashboard_repo.dart';
import '../../features/merchant/dashboard/domain/use_cases/get_dashboard_use_case.dart';
import '../../features/merchant/dashboard/presentation/manager/merchant_dashboard_cubit.dart';
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
import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/secure_storage/secure_storage.dart';
import '../crash_reporting/crashlytics_tool.dart';
import '../crash_reporting/sentry_tool.dart';
import '../crash_reporting/vso_crash_reporting_manager.dart';
import '../helpers/notification_service.dart';
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
    _initNotificationService();
    _initSessionManager();
    _initCrashReporting();

    _merchantAuth();
    _merchantDashboard();
    _merchantCategories();
    _merchantProducts();
    _merchantDiscounts();
    _merchantOrders();
    _merchantProfile();
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
    sl.registerLazySingleton(() => MerchantLogoutUseCase(sl()));
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
    sl.registerFactory(() => MerchantProfileCubit(sl(), sl(), sl()));
    sl.registerLazySingleton(() => GetPhonesUseCase(sl()));
    sl.registerLazySingleton(() => AddPhoneUseCase(sl()));
    sl.registerLazySingleton(() => DeletePhoneUseCase(sl()));
    sl.registerFactory(() => MerchantPhonesCubit(sl(), sl(), sl()));
  }
}
