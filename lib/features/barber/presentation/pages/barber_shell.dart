import 'package:flutter/material.dart';
import '../../ratings/presentation/widgets/merchant_rating_prompt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/widgets/nav_tab_item.dart';
import '../../../../core/widgets/notched_bottom_nav_bar.dart';
import '../../bookings/presentation/pages/bookings_home_screen.dart';
import '../../home/presentation/pages/barber_home_screen.dart';
import '../../profile/presentation/manager/barber_profile_state.dart';
import '../../profile/presentation/pages/barber_force_change_password_screen.dart';
import '../../profile/presentation/pages/barber_location_screen.dart';
import '../../profile/presentation/pages/barber_profile_screen.dart';
import '../../../../shared/widgets/blocking_gate.dart';
import '../../storefront/presentation/pages/storefront_home_screen.dart';
import '../widgets/barber_data_loader.dart';
import '../widgets/barber_store_fab.dart';
import 'barber_team_member_shell.dart';
import '../../auth/domain/entities/barber_account_kind.dart';
import '../../profile/domain/entities/barber_profile.dart';
import '../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../../core/helpers/user_helpers.dart';
import '../../../../generated/l10n.dart';

class BarberShell extends StatefulWidget {
  final Future<void> Function() onLogout;
  final int initialIndex;

  const BarberShell({super.key, required this.onLogout, this.initialIndex = 0});

  @override
  State<BarberShell> createState() => _BarberShellState();
}

class _BarberShellState extends State<BarberShell> {
  late int _index = widget.initialIndex;
  bool _ratingPromptScheduled = false;
  bool _ownerDataLoaded = false;

  List<NavTabItem> get _tabs => [
    NavTabItem(Icons.home_rounded, S().tabHome),
    NavTabItem(Icons.event_available_rounded, S().tabBookings),
    NavTabItem(Icons.storefront_outlined, S().storefrontTitle),
    NavTabItem(Icons.person_rounded, S().tabAccount),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      BarberDataLoader.loadCommon(context);
      if (!UserHelpers.barberAccountKind.isTeamMember) {
        _loadOwnerData();
      }
    });
  }

  void _loadOwnerData() {
    if (_ownerDataLoaded) return;
    _ownerDataLoaded = true;
    BarberDataLoader.loadOwner(context);
  }

  void _syncAccountKind(BarberProfile profile) {
    final actual = profile.isTeamMember
        ? BarberAccountKind.teamMember
        : BarberAccountKind.owner;
    if (UserHelpers.barberAccountKind != actual) {
      UserHelpers.setBarberAccountKind(actual);
    }
    if (profile.owner && !_ownerDataLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadOwnerData();
      });
    }
  }

  void _scheduleRatingPrompt(bool canShow) {
    if (!canShow || _ratingPromptScheduled) return;
    _ratingPromptScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) MerchantRatingPrompt.checkAndShow(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberProfileCubit, BarberProfileState>(
      buildWhen: (previous, current) => previous.profile != current.profile,
      builder: (context, profileState) {
        final profile = profileState.profile;
        if (profile != null) _syncAccountKind(profile);
        final isTeamMember =
            profile?.isTeamMember ?? UserHelpers.barberAccountKind.isTeamMember;
        _scheduleRatingPrompt(
          profile != null &&
              !isTeamMember &&
              !profile.mustChangePassword &&
              !profile.needsLocation,
        );
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
            builder: (_) => isTeamMember
                ? BarberTeamMemberShell(onLogout: widget.onLogout)
                : _buildShell(),
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
          const StorefrontHomeScreen(),
          BarberProfileScreen(onLogout: widget.onLogout),
        ],
      ),
      floatingActionButton: BarberStoreFab(
        onPressed: () => context.push(Routes.barberStoreMerchantsScreen),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NotchedBottomNavBar(
        items: _tabs,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
