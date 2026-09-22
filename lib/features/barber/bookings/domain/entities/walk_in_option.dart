import 'package:equatable/equatable.dart';
import 'walk_in_option_barber.dart';

class WalkInOption extends Equatable {
  final int serviceTypeId;
  final String name;
  final List<WalkInOptionBarber> barbers;

  const WalkInOption({
    required this.serviceTypeId,
    required this.name,
    required this.barbers,
  });

  @override
  List<Object?> get props => [serviceTypeId, name, barbers];
}
