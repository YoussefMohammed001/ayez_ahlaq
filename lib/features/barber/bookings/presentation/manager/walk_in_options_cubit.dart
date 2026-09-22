import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_walk_in_options_use_case.dart';
import 'walk_in_options_state.dart';

class WalkInOptionsCubit extends Cubit<WalkInOptionsState> {
  final GetWalkInOptionsUseCase _getWalkInOptions;

  WalkInOptionsCubit(this._getWalkInOptions) : super(const WalkInOptionsState());

  Future<void> loadOptions() async {
    emit(state.copyWith(status: WalkInOptionsStatus.loading));

    final result = await _getWalkInOptions();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: WalkInOptionsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (options) => emit(
        state.copyWith(status: WalkInOptionsStatus.success, options: options),
      ),
    );
  }
}
