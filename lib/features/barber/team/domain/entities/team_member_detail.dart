import 'package:equatable/equatable.dart';

class TeamMemberDetail extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  final String tagline;
  final bool available;
  final bool active;
  final bool mustChangePassword;
  final double rating;
  final int ratingCount;

  const TeamMemberDetail({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.tagline,
    required this.available,
    required this.active,
    required this.mustChangePassword,
    required this.rating,
    required this.ratingCount,
  });

  TeamMemberDetail copyWith({bool? available, bool? active}) {
    return TeamMemberDetail(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      tagline: tagline,
      available: available ?? this.available,
      active: active ?? this.active,
      mustChangePassword: mustChangePassword,
      rating: rating,
      ratingCount: ratingCount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    phoneNumber,
    tagline,
    available,
    active,
    mustChangePassword,
    rating,
    ratingCount,
  ];
}
