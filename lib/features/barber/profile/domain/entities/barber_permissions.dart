import 'package:equatable/equatable.dart';

class BarberPermissions extends Equatable {
  final bool canViewRevenue;
  final bool canCloseBookings;
  final bool canMarkPaid;

  const BarberPermissions({
    this.canViewRevenue = false,
    this.canCloseBookings = false,
    this.canMarkPaid = false,
  });

  static const none = BarberPermissions();

  static const all = BarberPermissions(
    canViewRevenue: true,
    canCloseBookings: true,
    canMarkPaid: true,
  );

  @override
  List<Object?> get props => [canViewRevenue, canCloseBookings, canMarkPaid];
}
