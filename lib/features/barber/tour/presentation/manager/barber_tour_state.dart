import 'package:equatable/equatable.dart';

class BarberTourState extends Equatable {
  final int requestCount;

  const BarberTourState({this.requestCount = 0});

  @override
  List<Object?> get props => [requestCount];
}
