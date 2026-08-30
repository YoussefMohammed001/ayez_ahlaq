import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class ResendButton extends StatefulWidget {
  final VoidCallback onResend;
  final int cooldownSeconds;

  const ResendButton({
    super.key,
    required this.onResend,
    this.cooldownSeconds = 90,
  });

  @override
  State<ResendButton> createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remaining = widget.cooldownSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remaining <= 1) {
        t.cancel();
        setState(() => _remaining = 0);
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onTap() {
    widget.onResend();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final canResend = _remaining == 0;
    final s = S.of(context);

    return GestureDetector(
      onTap: canResend ? _onTap : null,
      child: Text(
        canResend ? s.resend_code : '${s.resend_code} (${_remaining}s)',
        style: font13w600.copyWith(color: canResend ? cs.primary : cs.tertiary),
      ),
    );
  }
}
