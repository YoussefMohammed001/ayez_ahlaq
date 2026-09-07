import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/nav_tab_item.dart';
import '../../bookings/presentation/manager/bookings_cubit.dart';
import '../../bookings/presentation/pages/bookings_home_screen.dart';
import '../../home/presentation/pages/barber_home_screen.dart';
import '../../notifications/presentation/manager/barber_notifications_cubit.dart';
import '../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../profile/presentation/manager/barber_profile_state.dart';
import '../../profile/presentation/pages/barber_force_change_password_screen.dart';
import '../../profile/presentation/pages/barber_location_screen.dart';
import '../../profile/presentation/pages/barber_profile_screen.dart';
import '../../../../shared/widgets/blocking_gate.dart';
import '../../services/presentation/manager/barber_services_cubit.dart';
import '../../store/presentation/manager/barber_store_merchants_cubit.dart';
import '../../store/presentation/pages/barber_store_merchants_screen.dart';
import '../../subscription/presentation/manager/barber_subscription_cubit.dart';
import '../../team/presentation/manager/earnings_cubit.dart';
import '../../../../generated/l10n.dart';

class BarberShell extends StatefulWidget {
  final VoidCallback onLogout;

  const BarberShell({super.key, required this.onLogout});

  @override
  State<BarberShell> createState() => _BarberShellState();
}

class _BarberShellState extends State<BarberShell> {
  int _index = 0;

  List<NavTabItem> get _tabs => [
    NavTabItem(Icons.home_rounded, S().tabHome),
    NavTabItem(Icons.event_available_rounded, S().tabBookings),
    NavTabItem(Icons.storefront_outlined, S().tabStore),
    NavTabItem(Icons.person_rounded, S().tabAccount),
  ];

  @override
  void initState() {
    super.initState();
    context.read<BarberProfileCubit>().loadProfile();
    context.read<BarberServicesCubit>().loadServices();
    context.read<BarberStoreMerchantsCubit>().loadMerchants();
    context.read<BarberNotificationsCubit>().refreshUnseenCount();
    context.read<EarningsCubit>().loadEarnings();
    context.read<BookingsCubit>().loadPending();
    context.read<BookingsCubit>().loadQueue();
    context.read<BookingsCubit>().loadHistory();
    context.read<BarberSubscriptionCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberProfileCubit, BarberProfileState>(
      buildWhen: (previous, current) => previous.profile != current.profile,
      builder: (context, profileState) {
        final profile = profileState.profile;
        return BlockingGate(
          isBlocked: profile != null && profile.mustChangePassword,
          title: S().forceChangePasswordTitle,
          onLogout: widget.onLogout,
          blockedBuilder: (_) => const BarberForceChangePasswordScreen(),
          builder: (_) => BlockingGate(
            isBlocked: profile != null && profile.needsLocation,
            title: S().locationTitle,
            onLogout: widget.onLogout,
            blockedBuilder: (_) =>
                BarberLocationScreen(profile: profile, blocking: true),
            builder: (_) => _buildShell(),
          ),
        );
      },
    );
  }

  Widget _buildShell() {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          BarberHomeScreen(onGoToTab: (i) => setState(() => _index = i)),
          const BookingsHomeScreen(),
          const BarberStoreMerchantsScreen(),
          BarberProfileScreen(onLogout: widget.onLogout),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        items: _tabs,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
