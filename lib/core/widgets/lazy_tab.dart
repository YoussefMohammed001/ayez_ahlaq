import 'package:flutter/material.dart';

class LazyTab extends StatelessWidget {
  final bool visited;
  final Widget child;

  const LazyTab({super.key, required this.visited, required this.child});

  @override
  Widget build(BuildContext context) =>
      visited ? child : const SizedBox.shrink();
}
