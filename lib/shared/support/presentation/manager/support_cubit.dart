import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_support_info_use_case.dart';
import 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  final GetSupportInfoUseCase _getSupportInfo;

  SupportCubit(this._getSupportInfo) : super(const SupportState());

  Future<void> loadSupportInfo() async {
    emit(state.copyWith(status: SupportStatus.loading));

    final result = await _getSupportInfo();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SupportStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (info) => emit(state.copyWith(status: SupportStatus.success, info: info)),
    );
  }
}
