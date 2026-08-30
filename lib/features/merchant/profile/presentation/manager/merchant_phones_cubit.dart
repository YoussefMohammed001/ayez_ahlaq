import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/merchant_phone.dart';
import '../../domain/use_cases/add_phone_use_case.dart';
import '../../domain/use_cases/delete_phone_use_case.dart';
import '../../domain/use_cases/get_phones_use_case.dart';
import 'merchant_phones_state.dart';

class MerchantPhonesCubit extends Cubit<MerchantPhonesState> {
  final GetPhonesUseCase _getPhones;
  final AddPhoneUseCase _addPhone;
  final DeletePhoneUseCase _deletePhone;

  MerchantPhonesCubit(this._getPhones, this._addPhone, this._deletePhone)
    : super(const MerchantPhonesState());

  Future<void> loadPhones() async {
    emit(state.copyWith(status: PhonesStatus.loading));

    final result = await _getPhones();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PhonesStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (phones) => emit(
        state.copyWith(status: PhonesStatus.success, phones: phones),
      ),
    );
  }

  Future<bool> addPhone(String phone, String? label) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _addPhone(phone, label);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (added) {
        emit(
          state.copyWith(
            isSubmitting: false,
            phones: [...state.phones, added],
          ),
        );
        return true;
      },
    );
  }

  Future<void> deletePhone(int id) async {
    final previous = state.phones;
    emit(state.copyWith(phones: _without(id)));

    final result = await _deletePhone(id);

    result.leftMap(
      (failure) => emit(
        state.copyWith(phones: previous, errorMessage: failure.message),
      ),
    );
  }

  List<MerchantPhone> _without(int id) =>
      state.phones.where((p) => p.id != id).toList();
}
