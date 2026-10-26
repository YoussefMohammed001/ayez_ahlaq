import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/merchant/categories/presentation/pages/merchant_categories_screen.dart';
import '../../../features/merchant/customers/presentation/pages/merchant_customers_screen.dart';
import '../../../features/merchant/delivery/presentation/pages/merchant_delivery_screen.dart';
import '../../../features/merchant/discounts/domain/entities/discount.dart';
import '../../../features/merchant/discounts/presentation/pages/discount_form_screen.dart';
import '../../../features/merchant/discounts/presentation/manager/discount_quote_cubit.dart';
import '../../../features/merchant/discounts/presentation/pages/discount_quote_screen.dart';
import '../../../features/merchant/discounts/presentation/pages/merchant_discounts_screen.dart';
import '../../../features/merchant/orders/domain/entities/purchase_order.dart';
import '../../../features/merchant/orders/presentation/pages/order_details_screen.dart';
import '../../../features/merchant/products/domain/entities/merchant_product.dart';
import '../../../features/merchant/products/presentation/pages/product_details_screen.dart';
import '../../../features/merchant/products/presentation/pages/product_form_screen.dart';
import '../../di/services_locator.dart';
import '../route_paths.dart';
import '../scoped_cubits/merchant_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> merchantCatalogRoutes = [
  GoRoute(
    path: Routes.merchantProductFormScreen,
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: merchantProductsCubit),
        BlocProvider.value(value: merchantCategoriesCubit),
      ],
      child: ProductFormScreen(product: state.extra as MerchantProduct?),
    ),
  ),
  GoRoute(
    path: Routes.merchantProductDetailsScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<int>(state),
    builder: (_, state) => BlocProvider.value(
      value: merchantProductsCubit,
      child: ProductDetailsScreen(productId: state.extra as int),
    ),
  ),
  GoRoute(
    path: Routes.merchantCategoriesScreen,
    builder: (_, state) => BlocProvider.value(
      value: merchantCategoriesCubit,
      child: MerchantCategoriesScreen(categoryLimit: state.extra as int? ?? 0),
    ),
  ),
  GoRoute(
    path: Routes.merchantCustomersScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantCustomersCubit,
      child: const MerchantCustomersScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantDiscountsScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantDiscountsCubit,
      child: const MerchantDiscountsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantDiscountFormScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: merchantDiscountsCubit),
        BlocProvider.value(value: merchantProductsCubit),
      ],
      child: DiscountFormScreen(discount: __.extra as Discount?),
    ),
  ),
  GoRoute(
    path: Routes.merchantDiscountQuoteScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: merchantDiscountsCubit),
        BlocProvider.value(value: merchantProductsCubit),
        BlocProvider(create: (_) => sl<DiscountQuoteCubit>()),
      ],
      child: const DiscountQuoteScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantDeliveryScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantDeliveryCubit..loadDelivery(),
      child: const MerchantDeliveryScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantOrderDetailsScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<PurchaseOrder>(state),
    builder: (_, state) => BlocProvider.value(
      value: merchantOrdersCubit,
      child: OrderDetailsScreen(order: state.extra as PurchaseOrder),
    ),
  ),
];
