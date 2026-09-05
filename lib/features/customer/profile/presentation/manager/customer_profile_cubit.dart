import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_cached_profile_use_case.dart';
import 'customer_profile_state.dart';

class CustomerProfileCubit extends Cubit<CustomerProfileState> {
  final GetCachedProfileUseCase _getCachedProfile;

  CustomerProfileCubit(this._getCachedProfile) : super(const CustomerProfileState());

  void loadProfile() {
    emit(state.copyWith(profile: _getCachedProfile()));
  }
}
