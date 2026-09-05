import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_favorites_repo.dart';

class AddFavoriteUseCase {
  final ICustomerFavoritesRepo _repo;

  AddFavoriteUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int barberId) => _repo.addFavorite(barberId);
}
