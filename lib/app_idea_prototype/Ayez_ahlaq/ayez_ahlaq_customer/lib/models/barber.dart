import 'package:flutter/material.dart';

class Barber {
  final String id;
  final String name;
  final String tag;
  final double rating;
  final String status;
  final bool ok;
  final List<Color> portfolio;

  const Barber({
    required this.id,
    required this.name,
    required this.tag,
    required this.rating,
    required this.status,
    required this.ok,
    required this.portfolio,
  });
}
