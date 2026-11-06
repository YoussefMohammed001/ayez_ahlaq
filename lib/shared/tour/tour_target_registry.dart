import 'package:flutter/widgets.dart';

class TourTargetRegistry {
  TourTargetRegistry._();

  static final Set<GlobalKey> _mounted = {};

  static void add(GlobalKey key) => _mounted.add(key);

  static void remove(GlobalKey key) => _mounted.remove(key);

  static bool isMounted(GlobalKey key) => _mounted.contains(key);
}
