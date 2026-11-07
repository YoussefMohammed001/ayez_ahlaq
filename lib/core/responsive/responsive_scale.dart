import 'dart:ui';

class ResponsiveScale {
  const ResponsiveScale._();

  static const Size phoneDesign = Size(402, 874);
  static const double tabletScale = 1.15;

  static Size designSizeFor(Size screen) {
    if (screen.width < phoneDesign.width * 1.5) return phoneDesign;
    return Size(screen.width / tabletScale, screen.height / tabletScale);
  }
}
