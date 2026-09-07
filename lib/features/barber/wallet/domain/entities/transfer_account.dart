import 'package:equatable/equatable.dart';

class TransferAccount extends Equatable {
  final int id;
  final String label;
  final String accountNumber;
  final String? holderName;

  const TransferAccount({
    required this.id,
    required this.label,
    required this.accountNumber,
    this.holderName,
  });

  @override
  List<Object?> get props => [id, label, accountNumber, holderName];
}
