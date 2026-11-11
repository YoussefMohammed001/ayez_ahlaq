import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_my_merchant_hours_use_case.dart';
import 'my_schedule_state.dart';

class MyScheduleCubit extends Cubit<MyScheduleState> {
  final GetMyMerchantHoursUseCase _getHours;

  MyScheduleCubit(this._getHours) : super(const MyScheduleState());

  Future<void> load() async {
    emit(const MyScheduleState(status: MyScheduleStatus.loading));

    final result = await _getHours();

    result.fold(
      (_) => emit(const MyScheduleState(status: MyScheduleStatus.failure)),
      (days) =>
          emit(MyScheduleState(status: MyScheduleStatus.success, days: days)),
    );
  }
}
