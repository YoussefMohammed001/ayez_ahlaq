import 'package:equatable/equatable.dart';

class AppliedDiscount extends Equatable {
  final int id;
  final String name;
  final String scope;
  final String benefit;

  const AppliedDiscount({
    required this.id,
    required this.name,
    required this.scope,
    required this.benefit,
  });

  @override
  List<Object?> get props => [id, name, scope, benefit];
}
