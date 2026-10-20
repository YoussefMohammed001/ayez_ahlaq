import 'package:equatable/equatable.dart';

class WithdrawMethod extends Equatable {
  final int id;
  final String name;

  const WithdrawMethod({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
