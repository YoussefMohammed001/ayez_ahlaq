class RefreshThrottle {
  final Duration minGap;
  final DateTime Function() clock;
  DateTime? _lastAllowed;

  RefreshThrottle({
    this.minGap = const Duration(seconds: 5),
    this.clock = DateTime.now,
  });

  bool tryAcquire() {
    final now = clock();
    final last = _lastAllowed;

    if (last != null && now.difference(last) < minGap) return false;

    _lastAllowed = now;
    return true;
  }
}
