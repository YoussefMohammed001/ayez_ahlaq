class SecurityResult {
  final bool isRooted;
  final bool isEmulator;
  final bool isProxySet;

  const SecurityResult({
    required this.isRooted,
    required this.isEmulator,
    required this.isProxySet,
  });

  bool get isSafe => !isRooted && !isEmulator && !isProxySet;

  @override
  String toString() =>
      'SecurityResult(isRooted: $isRooted, isEmulator: $isEmulator, isProxySet: $isProxySet)';
}
