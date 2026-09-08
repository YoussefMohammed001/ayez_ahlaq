import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/sponsorship/sponsorship_state.dart';
import '../../domain/use_cases/buy_merchant_sponsorship_use_case.dart';
import '../../domain/use_cases/get_merchant_sponsorship_use_case.dart';

class MerchantSponsorshipCubit extends Cubit<SponsorshipState> {
  final GetMerchantSponsorshipUseCase _getSponsorship;
  final BuyMerchantSponsorshipUseCase _buySponsorship;

  MerchantSponsorshipCubit(this._getSponsorship, this._buySponsorship)
    : super(const SponsorshipState());

  Future<void> loadSponsorship() async {
    emit(state.copyWith(status: SponsorshipStatus.loading));

    final result = await _getSponsorship();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SponsorshipStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (sponsorship) => emit(
        state.copyWith(
          status: SponsorshipStatus.success,
          sponsorship: sponsorship,
        ),
      ),
    );
  }

  Future<bool> buySponsorship() async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _buySponsorship();

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (sponsorship) {
        emit(
          state.copyWith(
            isSubmitting: false,
            status: SponsorshipStatus.success,
            sponsorship: sponsorship,
          ),
        );
        return true;
      },
    );
  }
}
