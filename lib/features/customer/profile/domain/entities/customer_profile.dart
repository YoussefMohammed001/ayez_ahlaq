import 'package:equatable/equatable.dart';

class CustomerProfile extends Equatable {
  final String name;
  final String phoneNumber;

  const CustomerProfile({required this.name, required this.phoneNumber});

  @override
  List<Object?> get props => [name, phoneNumber];
}
