class ProfileSetupPolicy {
  const ProfileSetupPolicy._();

  static const Duration hideDuration = Duration(days: 2);

  static bool isStillHidden(DateTime? hiddenAt, DateTime now) =>
      hiddenAt != null && now.difference(hiddenAt) < hideDuration;
}
