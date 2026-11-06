import 'package:flutter/widgets.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../core/cache/preferences_storage/preferences_storage.dart';
import '../../core/cache/preferences_storage/preferences_storage_keys.dart';
import 'tour_target_registry.dart';

class AppTourController {
  final PreferencesKeys seenKey;
  final PreferencesStorage _preferences;

  AppTourController(this._preferences, {required this.seenKey});

  bool get hasBeenSeen => _preferences.getBoolean(key: seenKey);

  void attach() {
    ShowcaseView.register(
      enableAutoScroll: true,
      onFinish: _markSeen,
      onDismiss: (_) => _markSeen(),
    );
  }

  void detach() {
    try {
      ShowcaseView.get().unregister();
    } catch (_) {
      return;
    }
  }

  bool start(List<GlobalKey> sequence) {
    final visible = sequence.where(TourTargetRegistry.isMounted);
    if (visible.isEmpty) return false;
    ShowcaseView.get().startShowCase(visible.toList());
    return true;
  }

  Future<void> _markSeen() =>
      _preferences.putBoolean(key: seenKey, value: true);
}
