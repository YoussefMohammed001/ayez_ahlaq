import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/services_locator.dart';
import '../../../../../core/session/session_events.dart';
import '../../../../../core/session/session_manager.dart';
import '../../../team/presentation/manager/my_merchant_member_cubit.dart';
import '../helpers/refresh_throttle.dart';

class SubMerchantPermissionRefresher extends StatefulWidget {
  final Stream<String>? events;
  final RefreshThrottle? throttle;
  final Widget child;

  const SubMerchantPermissionRefresher({
    super.key,
    required this.child,
    this.events,
    this.throttle,
  });

  @override
  State<SubMerchantPermissionRefresher> createState() =>
      _SubMerchantPermissionRefresherState();
}

class _SubMerchantPermissionRefresherState
    extends State<SubMerchantPermissionRefresher>
    with WidgetsBindingObserver {
  late final RefreshThrottle _throttle = widget.throttle ?? RefreshThrottle();
  StreamSubscription<String>? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final events = widget.events ?? sl<SessionManager>().sessionEvents;
    _subscription = events.listen((event) {
      if (event == SessionEvents.forbidden) _refresh();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  void _refresh() {
    if (!mounted || !_throttle.tryAcquire()) return;
    context.read<MyMerchantMemberCubit>().load();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
