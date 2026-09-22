enum MoneyDirection {
  add,
  subtract;

  static MoneyDirection fromApi(String? value) => switch (value) {
    'SUBTRACT' => MoneyDirection.subtract,
    _ => MoneyDirection.add,
  };

  String toApi() => switch (this) {
    MoneyDirection.add => 'ADD',
    MoneyDirection.subtract => 'SUBTRACT',
  };
}
