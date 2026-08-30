enum UserType {
  customer,
  barber,
  merchant;

  static UserType? fromApi(String? value) => switch (value) {
    'CUSTOMER' => UserType.customer,
    'BARBER' => UserType.barber,
    'MERCHANT' => UserType.merchant,
    _ => null,
  };

  String toApi() => switch (this) {
    UserType.customer => 'CUSTOMER',
    UserType.barber => 'BARBER',
    UserType.merchant => 'MERCHANT',
  };

  String get apiSegment => switch (this) {
    UserType.customer => 'customer',
    UserType.barber => 'barber',
    UserType.merchant => 'merchant',
  };
}
