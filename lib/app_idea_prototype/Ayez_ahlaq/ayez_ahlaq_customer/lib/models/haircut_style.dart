import 'package:flutter/material.dart';

class HaircutStyle {
  final String id;
  final String name;
  final int priceDelta;
  final List<Color> swatch;

  const HaircutStyle({
    required this.id,
    required this.name,
    required this.priceDelta,
    required this.swatch,
  });
}
