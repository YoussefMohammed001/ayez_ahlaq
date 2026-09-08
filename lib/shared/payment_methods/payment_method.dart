import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  final String code;
  final String label;

  const PaymentMethod({required this.code, required this.label});

  @override
  List<Object?> get props => [code, label];
}
