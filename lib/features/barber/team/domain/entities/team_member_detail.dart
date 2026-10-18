import 'package:equatable/equatable.dart';
import '../../../profile/domain/entities/barber_permissions.dart';

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
  final BarberPermissions permissions;

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
    this.permissions = BarberPermissions.none,
  });

  TeamMemberDetail copyWith({
    bool? available,
    bool? active,
    BarberPermissions? permissions,
  }) {
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
      permissions: permissions ?? this.permissions,
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
    permissions,
  ];
}
