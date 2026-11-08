import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/entities/profile_setup_policy.dart';

void main() {
  final now = DateTime(2026, 11, 8, 12);

  test('the card stays hidden for exactly two days', () {
    expect(ProfileSetupPolicy.hideDuration, const Duration(days: 2));
  });

  test('is hidden until two days have passed', () {
    expect(ProfileSetupPolicy.isStillHidden(now, now), isTrue);
    expect(
      ProfileSetupPolicy.isStillHidden(
        now.subtract(const Duration(days: 1, hours: 23)),
        now,
      ),
      isTrue,
    );
    expect(
      ProfileSetupPolicy.isStillHidden(
        now.subtract(const Duration(days: 2)),
        now,
      ),
      isFalse,
    );
  });

  test('was never hidden', () {
    expect(ProfileSetupPolicy.isStillHidden(null, now), isFalse);
  });
}
