import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/favorite_barber.dart';
import '../repos/i_customer_favorites_repo.dart';

class GetFavoritesUseCase {
  final ICustomerFavoritesRepo _repo;

  GetFavoritesUseCase(this._repo);

  Future<Either<Failure, List<FavoriteBarber>>> call() => _repo.getFavorites();
}
