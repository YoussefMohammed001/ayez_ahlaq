enum CrashReportingKey {
  appVersion("APP_VERSION"),
  userId("USER_ID"),
  deviceModel("DEVICE_MODEL");

  final String key;
  const CrashReportingKey(this.key);
}
