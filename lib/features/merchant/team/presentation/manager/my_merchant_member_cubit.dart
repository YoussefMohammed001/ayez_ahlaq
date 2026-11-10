import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/change_my_merchant_password_use_case.dart';
import '../../domain/use_cases/get_my_merchant_member_use_case.dart';
import 'my_merchant_member_state.dart';

class MyMerchantMemberCubit extends Cubit<MyMerchantMemberState> {
  final GetMyMerchantMemberUseCase _getMe;
  final ChangeMyMerchantPasswordUseCase _changePassword;

  MyMerchantMemberCubit(this._getMe, this._changePassword)
    : super(const MyMerchantMemberState());

  Future<void> load() async {
    emit(state.copyWith(status: MyMemberStatus.loading));

    final result = await _getMe();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MyMemberStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (member) =>
          emit(state.copyWith(status: MyMemberStatus.success, member: member)),
    );
  }

  Future<bool> changePassword(String current, String next) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _changePassword(current, next);

    final failure = result.fold((value) => value, (_) => null);

    if (failure != null) {
      emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
      return false;
    }

    emit(state.copyWith(isSubmitting: false));
    await load();
    return true;
  }
}
