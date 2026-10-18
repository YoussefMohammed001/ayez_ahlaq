import 'package:flutter/widgets.dart';

extension ExtTextControllers on Iterable<TextEditingController> {
  void clearAll() {
    for (final controller in this) {
      controller.clear();
    }
  }
}
