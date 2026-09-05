import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_profile.dart';

class CustomerProfileState extends Equatable {
  final CustomerProfile? profile;

  const CustomerProfileState({this.profile});

  CustomerProfileState copyWith({CustomerProfile? profile}) {
    return CustomerProfileState(profile: profile ?? this.profile);
  }

  @override
  List<Object?> get props => [profile];
}
