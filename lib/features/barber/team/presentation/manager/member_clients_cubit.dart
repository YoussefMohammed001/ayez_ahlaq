import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../domain/use_cases/get_member_clients_use_case.dart';
import 'member_clients_state.dart';

class MemberClientsCubit extends Cubit<MemberClientsState> {
  final GetMemberClientsUseCase _getMemberClients;

  MemberClientsCubit(this._getMemberClients) : super(MemberClientsState());

  Future<void> loadClients(int memberId) async {
    emit(
      MemberClientsState(status: MemberClientsStatus.loading, memberId: memberId),
    );
    await _fetch();
  }

  Future<void> setDateRange(DateTime from, DateTime to) async {
    emit(state.copyWith(from: from, to: to, status: MemberClientsStatus.loading));
    await _fetch();
  }

  Future<void> _fetch() async {
    final memberId = state.memberId;
    if (memberId == null) return;

    final result = await _getMemberClients(
      memberId,
      from: AppDateTime.formatDateForApi(state.from),
      to: AppDateTime.formatDateForApi(state.to),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MemberClientsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (clients) => emit(
        state.copyWith(status: MemberClientsStatus.success, clients: clients),
      ),
    );
  }
}
