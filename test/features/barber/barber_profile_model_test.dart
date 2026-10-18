import 'package:ayez_ahlaq/features/barber/profile/data/models/barber_profile_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, dynamic> json({required bool owner, Map<String, dynamic>? permissions}) => {
    'id': 1,
    'name': 'x',
    'owner': owner,
    if (permissions != null) 'permissions': permissions,
  };

  test('owner always has every permission', () {
    final profile = BarberProfileModel.fromJson(json(owner: true));
    expect(profile.isTeamMember, isFalse);
    expect(profile.canCloseBookings, isTrue);
    expect(profile.canMarkPaid, isTrue);
    expect(profile.canViewRevenue, isTrue);
  });

  test('team member follows the permissions the owner set', () {
    final profile = BarberProfileModel.fromJson(
      json(owner: false, permissions: {'canCloseBookings': true}),
    );
    expect(profile.isTeamMember, isTrue);
    expect(profile.canCloseBookings, isTrue);
    expect(profile.canMarkPaid, isFalse);
    expect(profile.canViewRevenue, isFalse);
  });

  test('team member with missing permissions gets none', () {
    final profile = BarberProfileModel.fromJson(json(owner: false));
    expect(profile.canCloseBookings, isFalse);
    expect(profile.canViewRevenue, isFalse);
  });
}
