import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final int price;
  final double rating;
  final List<Color> gradient;
  final String description;
  final int stock;
  final int minOrderQty;
  final bool active;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.gradient,
    required this.description,
    this.stock = 0,
    this.minOrderQty = 1,
    this.active = true,
  });
}
