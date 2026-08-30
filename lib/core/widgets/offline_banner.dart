import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/app_cubit/app_cubit.dart';
import 'package:ayez_ahlaq/core/app_cubit/app_state.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class OfflineBanner extends StatefulWidget {
  const OfflineBanner({super.key});

  @override
  State<OfflineBanner> createState() => _OfflineBannerState();
}

class _OfflineBannerState extends State<OfflineBanner> {
  bool _showReconnected = false;
  Timer? _timer;

  void _onStateChanged(AppState state) {
    if (state is UpdateAppState) {
      _timer?.cancel();
      setState(() => _showReconnected = true);
      _timer = Timer(const Duration(seconds: 2), () {
        if (mounted) setState(() => _showReconnected = false);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (_, s) => s is UpdateAppState || s is NoInternetState,
      listener: (_, state) => _onStateChanged(state),
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (_, s) => s is UpdateAppState || s is NoInternetState,
        builder: (context, _) {
          final offline = context.read<AppCubit>().isOffline;
          final visible = offline || _showReconnected;

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: !visible ? const SizedBox.shrink() : _Bar(online: !offline),
          );
        },
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.online});

  final bool online;

  @override
  Widget build(BuildContext context) {
    final color = online ? const Color(0xFF048A1A) : const Color(0xFFB00003);

    return Material(
      color: color,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                online ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                size: 16.r,
                color: Colors.white,
              ),
              8.wSpace,
              Text(
                online ? S().backOnline : S().noInternetConnection,
                style: font13w600.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
