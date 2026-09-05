import 'package:equatable/equatable.dart';

class StoreCategory extends Equatable {
  final int id;
  final String name;
  final bool hasImage;

  const StoreCategory({required this.id, required this.name, required this.hasImage});

  @override
  List<Object?> get props => [id, name, hasImage];
}
