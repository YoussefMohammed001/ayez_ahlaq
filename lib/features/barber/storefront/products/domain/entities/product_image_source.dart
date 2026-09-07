enum ProductImageSource {
  own,
  category,
  defaultImage,
  none;

  static ProductImageSource fromApi(String? value) => switch (value) {
    'OWN' => ProductImageSource.own,
    'CATEGORY' => ProductImageSource.category,
    'DEFAULT' => ProductImageSource.defaultImage,
    _ => ProductImageSource.none,
  };

  bool get hasImage => this != ProductImageSource.none;
}
