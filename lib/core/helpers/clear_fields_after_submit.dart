import 'package:flutter/widgets.dart';
import '../extensions/ext_text_controllers.dart';

mixin ClearFieldsAfterSubmit<T extends StatefulWidget> on State<T> {
  List<TextEditingController> get fieldsToClear;

  GlobalKey<FormState>? get clearableFormKey => null;

  bool isSubmittingOf(T widget);

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (isSubmittingOf(oldWidget) && !isSubmittingOf(widget)) clearFields();
  }

  void clearFields() {
    fieldsToClear.clearAll();
    clearableFormKey?.currentState?.reset();
  }
}
