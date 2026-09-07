import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_member_earnings_use_case.dart';
import 'member_earnings_state.dart';

class MemberEarningsCubit extends Cubit<MemberEarningsState> {
  final GetMemberEarningsUseCase _getMemberEarnings;

  MemberEarningsCubit(this._getMemberEarnings)
    : super(const MemberEarningsState());

  Future<void> loadEarnings(int memberId) async {
    emit(
      MemberEarningsState(
        status: MemberEarningsStatus.loading,
        memberId: memberId,
      ),
    );

    final result = await _getMemberEarnings(memberId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MemberEarningsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (earnings) => emit(
        state.copyWith(status: MemberEarningsStatus.success, earnings: earnings),
      ),
    );
  }
}
