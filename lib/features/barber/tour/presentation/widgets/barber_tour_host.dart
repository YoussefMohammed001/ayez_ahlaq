import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../../../../../core/analytics/app_analytics.dart';
import '../../../../../core/di/sl.dart';
import '../../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../../../shared/tour/app_tour_controller.dart';
import '../manager/barber_tour_cubit.dart';
import '../manager/barber_tour_state.dart';

class BarberTourHost extends StatefulWidget {
  final BarberTourCubit tourCubit;
  final PreferencesKeys seenKey;
  final List<GlobalKey> Function() sequence;
  final VoidCallback onShowHome;
  final Widget child;

  const BarberTourHost({
    super.key,
    required this.tourCubit,
    required this.seenKey,
    required this.sequence,
    required this.onShowHome,
    required this.child,
  });

  @override
  State<BarberTourHost> createState() => _BarberTourHostState();
}

class _BarberTourHostState extends State<BarberTourHost> {
  static const _firstRunDelay = Duration(milliseconds: 2200);
  static const _requestedDelay = Duration(milliseconds: 500);

  late final AppTourController _controller;
  Timer? _timer;
  int _handledRequests = 0;

  @override
  void initState() {
    super.initState();
    _handledRequests = widget.tourCubit.state.requestCount;
    final analytics = sl<AppAnalytics>();
    _controller = AppTourController(
      sl<PreferencesStorage>(),
      seenKey: widget.seenKey,
      onCompleted: analytics.tourCompleted,
      onSkipped: analytics.tourSkipped,
    )..attach();
    if (!_controller.hasBeenSeen) _schedule(_firstRunDelay, 'first_run');
  }

  void _schedule(Duration delay, String source) {
    _timer?.cancel();
    _timer = Timer(delay, () {
      if (mounted && _controller.start(widget.sequence())) {
        sl<AppAnalytics>().tourStarted(source);
      }
    });
  }

  void _onRequested(BarberTourState state) {
    if (state.requestCount == _handledRequests) return;
    _handledRequests = state.requestCount;
    widget.onShowHome();
    _schedule(_requestedDelay, 'requested');
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarberTourCubit, BarberTourState>(
      bloc: widget.tourCubit,
      listener: (_, state) => _onRequested(state),
      child: widget.child,
    );
  }
}
