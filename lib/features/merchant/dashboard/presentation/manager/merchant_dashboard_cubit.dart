import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_dashboard_use_case.dart';
import 'merchant_dashboard_state.dart';

class MerchantDashboardCubit extends Cubit<MerchantDashboardState> {
  final GetDashboardUseCase _getDashboard;

  MerchantDashboardCubit(this._getDashboard)
    : super(const MerchantDashboardState());

  Future<void> loadDashboard() async {
    emit(state.copyWith(status: DashboardStatus.loading));

    final result = await _getDashboard();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (dashboard) => emit(
        state.copyWith(status: DashboardStatus.success, dashboard: dashboard),
      ),
    );
  }
}
