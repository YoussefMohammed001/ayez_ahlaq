import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_customer_profile_use_case.dart';
import 'customer_profile_state.dart';

class CustomerProfileCubit extends Cubit<CustomerProfileState> {
  final GetCustomerProfileUseCase _getProfile;

  CustomerProfileCubit(this._getProfile) : super(const CustomerProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: CustomerProfileStatus.loading));

    final result = await _getProfile();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerProfileStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (profile) => emit(
        state.copyWith(status: CustomerProfileStatus.success, profile: profile),
      ),
    );
  }
}
