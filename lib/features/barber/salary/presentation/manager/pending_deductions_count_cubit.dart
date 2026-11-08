import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_pending_deductions_count_use_case.dart';

class PendingDeductionsCountCubit extends Cubit<int> {
  final GetPendingDeductionsCountUseCase _getCount;

  PendingDeductionsCountCubit(this._getCount) : super(0);

  @override
  void emit(int state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> load() async {
    final result = await _getCount();
    result.fold((_) {}, emit);
  }
}
