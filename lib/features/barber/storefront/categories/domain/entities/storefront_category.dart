import 'package:equatable/equatable.dart';

class StorefrontCategory extends Equatable {
  final int id;
  final String name;
  final bool global;
  final bool active;
  final bool hasImage;

  const StorefrontCategory({
    required this.id,
    required this.name,
    required this.global,
    required this.active,
    required this.hasImage,
  });

  bool get isOwn => !global;

  @override
  List<Object?> get props => [id, name, global, active, hasImage];
}
