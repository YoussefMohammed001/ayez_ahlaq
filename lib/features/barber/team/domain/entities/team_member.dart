import 'package:equatable/equatable.dart';

class TeamMember extends Equatable {
  final int id;
  final String name;
  final bool owner;
  final bool you;
  final double rating;
  final int ratingCount;
  final int clientsToday;
  final int clientsThisMonth;
  final int rank;

  const TeamMember({
    required this.id,
    required this.name,
    required this.owner,
    required this.you,
    required this.rating,
    required this.ratingCount,
    required this.clientsToday,
    required this.clientsThisMonth,
    required this.rank,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    owner,
    you,
    rating,
    ratingCount,
    clientsToday,
    clientsThisMonth,
    rank,
  ];
}
