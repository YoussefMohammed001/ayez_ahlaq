import 'package:equatable/equatable.dart';

class MerchantCategory extends Equatable {
  final int id;
  final String name;
  final bool global;
  final int sortOrder;
  final bool active;
  final bool hasImage;

  const MerchantCategory({
    required this.id,
    required this.name,
    required this.global,
    required this.sortOrder,
    required this.active,
    required this.hasImage,
  });

  bool get isOwn => !global;

  @override
  List<Object?> get props => [id, name, global, sortOrder, active, hasImage];
}
