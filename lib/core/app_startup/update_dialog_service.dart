import 'package:flutter/cupertino.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class CupertinoUpdateDialogService {
  void showUpdateDialog(
    BuildContext context, {
    required bool isCritical,
    required VoidCallback onUpdate,
    required VoidCallback onSkip,
  }) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
        title: Text(S.of(context).updateRequired),
        content: Text(S.of(context).updateRequiredBody),
        actions: [
          CupertinoDialogAction(
            onPressed: onUpdate,
            child: Text(S.of(context).update),
          ),
          if (!isCritical)
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                onSkip();
              },
              child: Text(S.of(context).notNow),
            ),
        ],
      ),
    );
  }
}
