import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/merchant/sales/presentation/manager/new_sale_cubit.dart';
import '../../../features/merchant/sales/presentation/pages/new_sale_screen.dart';
import '../../../features/merchant/sales/presentation/pages/sale_details_screen.dart';
import '../../../features/merchant/sales/presentation/pages/sales_screen.dart';
import '../../di/sl.dart';
import '../route_guards.dart';
import '../route_paths.dart';
import '../scoped_cubits/merchant_scoped_cubits.dart';

final List<RouteBase> merchantSalesRoutes = [
  GoRoute(
    path: Routes.merchantSalesScreen,
    builder: (_, _) => BlocProvider.value(
      value: salesCubit..load(),
      child: const SalesScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantNewSaleScreen,
    builder: (_, _) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<NewSaleCubit>()..loadMethods()),
        BlocProvider.value(value: merchantProductsCubit),
      ],
      child: const NewSaleScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantSaleDetailsScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<int>(state),
    builder: (_, state) => BlocProvider.value(
      value: salesCubit,
      child: SaleDetailsScreen(saleId: state.extra as int),
    ),
  ),
];
