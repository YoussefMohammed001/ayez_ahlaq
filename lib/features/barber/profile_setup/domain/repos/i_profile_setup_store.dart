abstract class IProfileSetupStore {
  bool get started;

  bool get dismissed;

  Future<void> markStarted();

  Future<void> dismiss();
}
