import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_dashboard.dart';

enum DashboardStatus { initial, loading, success, failure }

class MerchantDashboardState extends Equatable {
  final DashboardStatus status;
  final MerchantDashboard? dashboard;
  final String? errorMessage;

  const MerchantDashboardState({
    this.status = DashboardStatus.initial,
    this.dashboard,
    this.errorMessage,
  });

  MerchantDashboardState copyWith({
    DashboardStatus? status,
    MerchantDashboard? dashboard,
    String? errorMessage,
  }) {
    return MerchantDashboardState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, dashboard, errorMessage];
}
