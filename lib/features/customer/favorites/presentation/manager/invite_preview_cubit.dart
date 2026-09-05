import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/auth/data/local/auth_local_data_source.dart';
import '../../domain/use_cases/add_favorite_via_invite_use_case.dart';
import '../../domain/use_cases/get_invite_preview_use_case.dart';
import 'invite_preview_state.dart';

class InvitePreviewCubit extends Cubit<InvitePreviewState> {
  final GetInvitePreviewUseCase _getPreview;
  final AddFavoriteViaInviteUseCase _addViaInvite;
  final AuthLocalDataSource _authLocalDataSource;

  InvitePreviewCubit(this._getPreview, this._addViaInvite, this._authLocalDataSource)
    : super(const InvitePreviewState());

  Future<void> loadPreview(String code) async {
    emit(state.copyWith(status: InvitePreviewStatus.loading));

    final result = await _getPreview(code);

    result.fold(
      (failure) => emit(
        state.copyWith(status: InvitePreviewStatus.failure, errorMessage: failure.message),
      ),
      (preview) => emit(state.copyWith(status: InvitePreviewStatus.loaded, preview: preview)),
    );
  }

  Future<bool> isLoggedIn() => _authLocalDataSource.isLoggedIn();

  Future<void> addViaInvite(String code) async {
    emit(state.copyWith(status: InvitePreviewStatus.adding));

    final result = await _addViaInvite(code);

    result.fold(
      (failure) => emit(
        state.copyWith(status: InvitePreviewStatus.loaded, errorMessage: failure.message),
      ),
      (_) => emit(state.copyWith(status: InvitePreviewStatus.added)),
    );
  }
}
