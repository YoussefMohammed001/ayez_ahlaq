import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/bookings/domain/entities/booking.dart';
import '../../../features/barber/bookings/presentation/pages/booking_detail_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberBookingRoutes = [
  GoRoute(
    path: Routes.barberBookingDetailsScreen,
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: bookingsCubit),
        BlocProvider.value(value: barberServicesCubit),
        BlocProvider.value(value: barberProfileCubit),
      ],
      child: BookingDetailScreen(booking: state.extra as Booking),
    ),
  ),
];
