import '../entities/presence_fix.dart';

abstract class IPresenceTracker {
  Stream<PresenceFix> fixes();
}
