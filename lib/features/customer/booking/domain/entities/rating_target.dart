enum RatingTarget {
  barber,
  shop;

  String get toApi => switch (this) {
    RatingTarget.barber => 'BARBER',
    RatingTarget.shop => 'SHOP',
  };
}
