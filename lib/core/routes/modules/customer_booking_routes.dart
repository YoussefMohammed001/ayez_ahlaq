import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/customer/profile/presentation/pages/customer_bookings_and_services_menu_screen.dart';
import '../../../features/customer/booking/presentation/widgets/booking_list_sync.dart';
import '../../../features/customer/booking/presentation/pages/booking_detail_screen.dart'
    as customer_booking;
import '../../../features/customer/booking/presentation/pages/booking_summary_screen.dart';
import '../../../features/customer/booking/presentation/pages/choose_barber_screen.dart';
import '../../../features/customer/booking/presentation/pages/choose_service_screen.dart';
import '../../../features/customer/booking/presentation/pages/choose_style_screen.dart';
import '../../../features/customer/booking/presentation/pages/choose_time_screen.dart';
import '../../../features/customer/booking/presentation/pages/my_bookings_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> customerBookingRoutes = [
  GoRoute(
    path: Routes.customerBookingsAndServicesMenuScreen,
    builder: (_, __) => const CustomerBookingsAndServicesMenuScreen(),
  ),
  GoRoute(
    path: Routes.customerChooseServiceScreen,
    builder: (_, __) => BlocProvider.value(
      value: bookingFlowCubit,
      child: const ChooseServiceScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerChooseStyleScreen,
    builder: (_, __) => BlocProvider.value(
      value: bookingFlowCubit,
      child: const ChooseStyleScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerChooseBarberScreen,
    builder: (_, __) => BlocProvider.value(
      value: bookingFlowCubit,
      child: const ChooseBarberScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerChooseTimeScreen,
    builder: (_, __) => BlocProvider.value(
      value: bookingFlowCubit,
      child: const ChooseTimeScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerBookingSummaryScreen,
    builder: (_, __) => BlocProvider.value(
      value: bookingFlowCubit,
      child: const BookingSummaryScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerBookingsScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: myBookingsCubit),
        BlocProvider.value(value: homeServiceRequestsCubit),
      ],
      child: const MyBookingsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerBookingDetailScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<int>(state),
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: customerBookingDetailCubit),
        BlocProvider.value(value: myBookingsCubit),
      ],
      child: BookingListSync(
        child: customer_booking.BookingDetailScreen(
          bookingId: state.extra as int,
        ),
      ),
    ),
  ),
];
