import 'package:flutter/material.dart';

class Shop {
  final String id;
  final String name;
  final double rating;
  final int reviews;
  final String distance;
  final String area;
  final bool open;
  final String closesAt;
  final List<String> tags;
  final List<Color> gradient;

  const Shop({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.area,
    required this.open,
    required this.closesAt,
    required this.tags,
    required this.gradient,
  });
}
