import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_state.dart';
import '../manager/profile_setup_cubit.dart';

class ProfileSetupLocalSync extends StatefulWidget {
  final Widget child;

  const ProfileSetupLocalSync({super.key, required this.child});

  @override
  State<ProfileSetupLocalSync> createState() => _ProfileSetupLocalSyncState();
}

class _ProfileSetupLocalSyncState extends State<ProfileSetupLocalSync> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _sync(context);
    });
  }

  void _sync(BuildContext context) {
    final state = context.read<BarberProfileCubit>().state;

    final photoKnown =
        state.imageStatus == ProfileImageStatus.loaded ||
        state.imageStatus == ProfileImageStatus.empty;
    if (!photoKnown) return;

    context.read<ProfileSetupCubit>().syncLocal(
      hasPhoto: state.imageStatus == ProfileImageStatus.loaded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarberProfileCubit, BarberProfileState>(
      listenWhen: (a, b) => a.imageStatus != b.imageStatus,
      listener: (context, _) => _sync(context),
      child: widget.child,
    );
  }
}
