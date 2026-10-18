import '../di/services_locator.dart';

class SessionScope {
  SessionScope._();

  static final Map<Type, Object> _cubits = {};

  static T cubit<T extends Object>() =>
      _cubits.putIfAbsent(T, () => sl<T>()) as T;

  static void reset() => _cubits.clear();
}
