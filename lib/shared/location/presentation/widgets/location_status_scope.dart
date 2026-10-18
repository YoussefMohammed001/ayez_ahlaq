import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/services_locator.dart';
import '../manager/location_status_cubit.dart';
import '../manager/location_status_state.dart';

class LocationStatusScope extends StatelessWidget {
  final Widget Function(BuildContext context, LocationStatusState state)
  builder;
  final VoidCallback? onBecameAvailable;

  const LocationStatusScope({
    super.key,
    required this.builder,
    this.onBecameAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocationStatusCubit>()..refresh(),
      child: _ResumeRefresher(
        child: BlocConsumer<LocationStatusCubit, LocationStatusState>(
          listenWhen: (previous, current) =>
              previous.isLoaded &&
              !previous.availability.isAvailable &&
              current.availability.isAvailable,
          listener: (_, __) => onBecameAvailable?.call(),
          builder: builder,
        ),
      ),
    );
  }
}

class _ResumeRefresher extends StatefulWidget {
  final Widget child;

  const _ResumeRefresher({required this.child});

  @override
  State<_ResumeRefresher> createState() => _ResumeRefresherState();
}

class _ResumeRefresherState extends State<_ResumeRefresher>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
      context.read<LocationStatusCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
