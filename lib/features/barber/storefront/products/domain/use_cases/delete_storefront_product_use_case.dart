import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../repos/i_barber_storefront_products_repo.dart';

class DeleteStorefrontProductUseCase {
  final IBarberStorefrontProductsRepo _repo;

  DeleteStorefrontProductUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deleteProduct(id);
}
