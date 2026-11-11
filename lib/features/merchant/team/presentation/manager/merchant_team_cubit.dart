import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/merchant_member_permissions.dart';
import '../../domain/use_cases/add_merchant_member_use_case.dart';
import '../../domain/use_cases/get_merchant_members_use_case.dart';
import 'merchant_team_state.dart';

class MerchantTeamCubit extends Cubit<MerchantTeamState> {
  static const _pageSize = 20;

  final GetMerchantMembersUseCase _getMembers;
  final AddMerchantMemberUseCase _addMember;

  MerchantTeamCubit(this._getMembers, this._addMember)
    : super(const MerchantTeamState());

  Future<void> load() async {
    emit(state.copyWith(status: MerchantTeamStatus.loading));
    await _loadFirstPage();
  }

  Future<void> refresh() => _loadFirstPage();

  Future<void> _loadFirstPage() async {
    final result = await _getMembers(page: 0, size: _pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MerchantTeamStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: MerchantTeamStatus.success,
          members: page.members,
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await _getMembers(page: state.page + 1, size: _pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (page) => emit(
        state.copyWith(
          members: [...state.members, ...page.members],
          page: page.page,
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      ),
    );
  }

  Future<bool> addMember({
    required String name,
    required String phoneNumber,
    String? password,
    double? salary,
    MerchantMemberPermissions permissions = const MerchantMemberPermissions(),
  }) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _addMember(
      name: name,
      phoneNumber: phoneNumber,
      password: password,
      salary: salary,
      permissions: permissions,
    );

    final failure = result.fold((value) => value, (_) => null);

    if (failure != null) {
      emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
      return false;
    }

    emit(state.copyWith(isSubmitting: false));
    await refresh();
    return true;
  }
}
