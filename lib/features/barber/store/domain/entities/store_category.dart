import 'package:equatable/equatable.dart';

class StoreCategory extends Equatable {
  final int id;
  final String name;

  const StoreCategory({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
