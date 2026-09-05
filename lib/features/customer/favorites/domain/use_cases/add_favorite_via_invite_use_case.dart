import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_favorites_repo.dart';

class AddFavoriteViaInviteUseCase {
  final ICustomerFavoritesRepo _repo;

  AddFavoriteViaInviteUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String inviteCode) =>
      _repo.addFavoriteViaInvite(inviteCode);
}
