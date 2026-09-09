import 'package:equatable/equatable.dart';

class TransferAccount extends Equatable {
  final int id;
  final String type;
  final String mobileNumber;
  final String label;

  const TransferAccount({
    required this.id,
    required this.type,
    required this.mobileNumber,
    required this.label,
  });

  @override
  List<Object?> get props => [id, type, mobileNumber, label];
}
