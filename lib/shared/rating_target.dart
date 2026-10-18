enum RatingTarget {
  barber,
  shop;

  String get toApi => switch (this) {
    RatingTarget.barber => 'BARBER',
    RatingTarget.shop => 'SHOP',
  };

  static RatingTarget fromApi(String? value) => switch (value) {
    'SHOP' => RatingTarget.shop,
    _ => RatingTarget.barber,
  };
}
