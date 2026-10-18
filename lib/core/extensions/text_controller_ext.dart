import 'package:flutter/widgets.dart';

extension TextControllerExt on TextEditingController {
  String? get textOrNull {
    final value = text.trim();
    return value.isEmpty ? null : value;
  }
}
