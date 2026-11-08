import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_worked_hours_use_case.dart';
import 'worked_hours_state.dart';

class WorkedHoursCubit extends Cubit<WorkedHoursState> {
  final GetWorkedHoursUseCase _getWorkedHours;

  WorkedHoursCubit(this._getWorkedHours) : super(const WorkedHoursState());

  @override
  void emit(WorkedHoursState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> load() async {
    if (state.status == WorkedHoursStatus.initial) {
      emit(const WorkedHoursState(status: WorkedHoursStatus.loading));
    }

    final result = await _getWorkedHours();

    result.fold(
      (_) => emit(
        WorkedHoursState(status: WorkedHoursStatus.failure, hours: state.hours),
      ),
      (hours) => emit(
        WorkedHoursState(status: WorkedHoursStatus.success, hours: hours),
      ),
    );
  }
}
