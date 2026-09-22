enum MoneyFrequency {
  daily,
  weekly,
  monthly;

  static MoneyFrequency fromApi(String? value) => switch (value) {
    'WEEKLY' => MoneyFrequency.weekly,
    'MONTHLY' => MoneyFrequency.monthly,
    _ => MoneyFrequency.daily,
  };

  String toApi() => switch (this) {
    MoneyFrequency.daily => 'DAILY',
    MoneyFrequency.weekly => 'WEEKLY',
    MoneyFrequency.monthly => 'MONTHLY',
  };
}
